import argparse
from pathlib import Path


parser = argparse.ArgumentParser()
parser.add_argument("log", nargs="?", type=Path,
                    default=Path(__file__).resolve().parent / "probe/with-otel-compat.log")
text = parser.parse_args().log.read_text()
assert "Failed to handle " not in text, "OTel reported a transformation failure"
for name in ("javax/servlet/GenericServlet", "javax/servlet/http/HttpServlet"):
    lines = [line for line in text.splitlines() if f"name={name} " in line]
    assert len(lines) == 4, lines
    for line in lines:
        assert "minor=0" in line and "parse=OK" in line, line
    dotted = name.replace("/", ".")
    assert f"PROBE retransformed={dotted} declaredMethods=12" in text
    assert text.count(f"Transformed {dotted} --") == 2
    print(f"PASS: {dotted}: decrypted Java input, OTel transform and retransform")
