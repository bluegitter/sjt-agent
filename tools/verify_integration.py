"""Compare original and compatible agents against the same encrypted app."""

import argparse
import hashlib
import json
import os
from pathlib import Path
import re
import shutil
import socket
import subprocess
import time
from urllib.error import HTTPError, URLError
from urllib.request import urlopen


BASE = Path(__file__).resolve().parent
ROOT = BASE.parents[1]
OUTPUT = BASE / "integration"
PORTS = (18999, 18084, 19466)


def request(url):
    try:
        with urlopen(url, timeout=5) as response:
            return response.status, response.read().decode()
    except HTTPError as error:
        return error.code, error.read().decode()


def http_count(metrics):
    return sum(float(line.rsplit(" ", 1)[1]) for line in metrics.splitlines()
               if line.startswith("http_server_request_duration_seconds_count{"))


def run_case(name, agent, java, output=OUTPUT):
    work = output / name
    work.mkdir(parents=True, exist_ok=True)
    shutil.copy2(ROOT / "application-dev.properties", work)
    shutil.copy2(ROOT / "log4j.properties", work)
    log_path = work / "console.log"
    command = [str(java), "-Xms128m", "-Xmx768m", "-Dfile.encoding=UTF-8",
               f"-javaagent:{agent}",
               f"-javaagent:{ROOT / 'observability/otel/opentelemetry-javaagent.jar'}",
               "-Dotel.metrics.exporter=prometheus", "-Dotel.exporter.prometheus.port=19466",
               "-Dotel.exporter.prometheus.host=127.0.0.1", "-Dotel.traces.exporter=none",
               "-Dotel.logs.exporter=none", "-Dotel.javaagent.debug=true",
               "-Dotel.service.name=sjt-otel-compat-test", "-jar",
               str(ROOT / "demo-springboot-dev-202611100317.jar"),
               "--spring.profiles.active=dev", "--server.port=18999",
               "--server.address=127.0.0.1", "--management.server.port=18084",
               "--management.server.address=127.0.0.1"]
    health = "http://127.0.0.1:18999/demo/api/health"
    process = None
    try:
        with log_path.open("w") as log:
            process = subprocess.Popen(command, cwd=work, stdout=log, stderr=subprocess.STDOUT)
            deadline = time.monotonic() + 90
            while time.monotonic() < deadline:
                if process.poll() is not None:
                    raise RuntimeError(f"{name} exited early; inspect {log_path}")
                try:
                    status, body = request(health)
                    if status == 200 and json.loads(body)["data"]["status"] == "UP":
                        break
                except (URLError, OSError):
                    pass
                time.sleep(0.5)
            else:
                raise RuntimeError(f"{name} failed to become healthy; inspect {log_path}")
            status, body = request("http://127.0.0.1:18084/actuator/health")
            assert status == 200 and json.loads(body)["status"] == "UP"
            metrics_url = "http://127.0.0.1:19466/metrics"
            before = request(metrics_url)[1]
            (work / "metrics-before.prom").write_text(before)
            for _ in range(20):
                status, body = request(health)
                assert status == 200 and json.loads(body)["code"] == "0"
            for _ in range(3):
                assert request("http://127.0.0.1:18999/demo/not-a-real-route")[0] == 404
            after = request(metrics_url)[1]
            (work / "metrics-after.prom").write_text(after)
            delta = http_count(after) - http_count(before)
            log_text = log_path.read_text()
            failures = log_text.count("Failed to handle ")
            transformed = re.findall(r"Transformed (javax\.servlet[^ ]*)", log_text)
            if name == "compatible":
                assert failures == 0, f"Unexpected transformation failures: {failures}"
                assert "http_server_request_duration_seconds_bucket{" in after
                assert delta >= 23, f"HTTP counter did not track test traffic: {delta}"
                assert "javax.servlet.GenericServlet" in transformed
                assert "javax.servlet.http.HttpServlet" in transformed
            else:
                assert failures > 0, "Original-agent control did not reproduce failure"
                assert "http_server_request_duration_seconds" not in after
            return {"case": name, "agent_sha256": hashlib.sha256(agent.read_bytes()).hexdigest(),
                    "business_health": 200, "management_health": 200,
                    "successful_test_requests": 20, "not_found_test_requests": 3,
                    "http_count_before": http_count(before), "http_count_after": http_count(after),
                    "http_count_delta": delta, "transformation_failures": failures,
                    "transformed_servlet_classes": sorted(set(transformed)),
                    "console_log": str(log_path.relative_to(ROOT))}
    finally:
        if process is not None and process.poll() is None:
            process.terminate()
            try:
                process.wait(timeout=20)
            except subprocess.TimeoutExpired:
                process.kill()
                process.wait(timeout=10)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--compatible-agent", type=Path, default=ROOT / "sjt_agent-otel-compat.jar")
    parser.add_argument("--output-dir", type=Path, default=OUTPUT)
    args = parser.parse_args()
    output = args.output_dir.resolve()
    for port in PORTS:
        with socket.socket() as sock:
            sock.bind(("127.0.0.1", port))
    output.mkdir(parents=True, exist_ok=True)
    java_home = os.environ.get("PROBE_JAVA_HOME") or subprocess.check_output(
        ["/usr/libexec/java_home", "-v", "17"], text=True).strip()
    results = []
    for name, agent in [("original", ROOT / "sjt_agent.jar"),
                        ("compatible", args.compatible_agent.resolve())]:
        result = run_case(name, agent, Path(java_home) / "bin/java", output)
        results.append(result)
        print(json.dumps(result), flush=True)
    (output / "summary.json").write_text(json.dumps(results, indent=2) + "\n")
    print("PASS: original and compatible encrypted-app integration tests; test processes stopped")


if __name__ == "__main__":
    main()
