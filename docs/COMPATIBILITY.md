# Encrypted SJT / OTel Compatibility Patch

## Implemented approach

Keep the encrypted application JAR and the SJT decryption implementation.
Move SJT decryption from the retransformation-capable native hook group to the
retransformation-incapable group. OTel's capable Java transformers then receive
the decrypted bytes during initial class definition.

The equivalent change in vendor source, before the first ClassFileLoadHook
enable, is to remove these two requested capabilities from a fresh JVMTI
environment's capability set:

```c
caps.can_retransform_classes = 0;
caps.can_retransform_any_class = 0;
// Preserve all other existing capability settings.
(*jvmti)->AddCapabilities(jvmti, &caps);
// SetEventCallbacks and enable ClassFileLoadHook as before.
```

There is no vendor source in this workspace. build_compat_agent.py therefore
implements a tightly version-pinned binary change in a COPY of the agent:

- Original source SHA-256 must match one of the two reviewed archive versions.
  The original and current-037b43f1 archives contain identical x86-64 libraries.
- The x86-64 member's SHA-256 is also checked independently before patching.
- Only libs/sjt_darwin_x64.dylib is changed.
- At file offset 0x2eb0, the capability mask changes from 0x60ac000008 to
  0xac000008. This changes exactly one byte before ad-hoc signing.
- The decryption algorithm and Java loader are not changed. The modified
  library is ad-hoc signed and verified for macOS loading.
- All other archive entries are checked for byte identity.
- The original sjt_agent.jar is never overwritten. Output is the separate
  the selected output JAR, with a JSON build manifest alongside it. The full
  verification script defaults to a version-suffixed name to preserve earlier
  compatibility artifacts. The current build is sjt_agent-otel-compat-037b43f1.jar.
- No decrypted application classes are written to disk by the patch or probes.

## Verification results

Full application tests use the SAME encrypted
demo-springboot-dev-202611100317.jar and JDK 17, in separate JVMs and work
directories. Test ports are 18999, 18084 and 19466; exporters bind loopback.
Test processes are terminated after verification. The existing service is not
stopped or switched by the tests.

| Check | Original agent | Compatible agent |
| --- | --- | --- |
| Business and management health | HTTP 200 | HTTP 200 |
| OTel transformation failures after test traffic | 104 | 0 |
| GenericServlet / HttpServlet OTel transformations | Fail | Succeed |
| http_server_request_duration_seconds histogram | Absent | Present |
| HTTP count delta for 20 successful + 3 missing-route requests | 0 | 23 |

The successful metrics include the standard _bucket, _sum and _count series,
status-code labels for 200 and 404, and the business route /demo/api/health.
See integration/summary.json, integration/compatible/console.log, and
integration/compatible/metrics-after.prom for measured results.

A focused class-loader probe also calls Instrumentation.retransformClasses on
GenericServlet and HttpServlet. Both retain valid decrypted input, are
successfully instrumented again, and remain reflectively usable. The JVM reuses
the incapable transformer's earlier output before invoking capable transformers;
the SJT decryptor does not need to run again for those retransformations.
See probe/with-otel-compat.log and verify_compat_probe.py.

## Reproduce all checks

```bash
bash analysis/sjt-agent/verify_compat.sh
```

Requirements: macOS x86-64, installed x86-64 JDK 17, clang, codesign and Python 3.
The complete checks build the separate agent, run unit tests, original-agent
regression probes, compatible-agent transform/retransform probes, and both
full-application controls. They also verify the original agent's SHA-256.

## Start compatibility mode

To switch the existing local service deliberately:

```bash
./stop.sh
./start-otel-compatible.sh
```

The new launcher requires an x86-64 JVM and builds the pinned compatibility
artifact before invoking start.sh with explicit SJT_AGENT and JAVA_BIN values.
It refuses to start while app.pid identifies a running process. The existing
start.sh default remains the original agent; both launchers share stop.sh.

To roll back:

```bash
./stop.sh
./start.sh
```

## Scope and residual risk

This is an experimental, local compatibility workaround, not a vendor-supported
release. Only this exact macOS x86-64 agent build on JDK 17 was tested. ARM64,
Linux, Windows, vendor hot-reload/redefine features, all business endpoints and
long-running load behavior are NOT certified by these checks. The loader still
contains original libraries for other platforms; they are not patched and the
compatibility launcher does not claim to support them.

Do not apply the byte offset to other builds. Ask the vendor to implement the
capability change in source and validate its security/lifecycle assumptions.
Disk encryption is preserved, but any Java execution and OTel instrumentation
necessarily make executable class bytes available in process memory. This patch
is not a promise of unchanged anti-analysis strength or licensing support.
