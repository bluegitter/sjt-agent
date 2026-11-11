# SJT cross-platform OTel compatibility patch

## Scope and mechanism

The input JAR already contains the user-verified macOS x86-64 fix. That library
is preserved byte-for-byte. The other seven native libraries receive the same
JVMTI capability change, located independently in each platform's initialization
code immediately before `AddCapabilities`:

```text
capability mask: 0x60ac000008 -> 0x00ac000008
can_retransform_classes:     1 -> 0
can_retransform_any_class:   1 -> 0
```

This puts the SJT decryption hook in the retransformation-incapable group, before
OTel's retransformation-capable transformers. The JVM reuses that group's initial
output during retransformation, so OTel also receives decrypted bytes then. This
does not disable OTel's own retransformation capability. The encrypted application
JAR, Java classes in the agent, and all other agent archive members are unchanged.

## Reviewed instruction changes

Offsets refer to instruction starts in the native library file, not the JAR.
Each new platform changes one instruction byte before any code signing.

| Library | File offset | Instruction change |
| --- | --- | --- |
| sjt_windows_x64.dll | 0x65f | movl $96, 372(%rsp) -> movl $0, 372(%rsp) |
| sjt_windows_x86.dll | 0x619 | movl $96, 152(%esp) -> movl $0, 152(%esp) |
| sjt_linux_x64.so | 0x31b7c | movb $96, 20(%rsp) -> movb $0, 20(%rsp) |
| sjt_linux_x86.so | 0x22eba | movb $96, 16(%esp) -> movb $0, 16(%esp) |
| sjt_linux_a64.so | 0x91bac | mov w2, #96 -> mov w2, #0 |
| sjt_linux_a32hf.so | 0x3cc9c | orr r3, r3, #96 -> orr r3, r3, #0 (Thumb) |
| sjt_darwin_a64.dylib | 0x7aefc | movk x8, #96, lsl #32 -> movk x8, #0, lsl #32 |
| sjt_darwin_x64.dylib | 0x2eae | Already corrected; unchanged |

The macOS ARM64 library is ad-hoc re-signed and passes `codesign --verify
--strict`. Signing preserves all file-backed Mach-O sections. Both Windows
libraries were unsigned (empty PE certificate directory); no signature is
removed. ELF build IDs are unchanged; use manifest SHA-256 values to identify
the patched artifacts instead.

## Artifacts and reproducibility

- Installed artifact: workspace root `sjt_agent.jar`.
- Identical distributable: workspace root `sjt_agent-multiplatform-otel-compat.jar`.
- Original backup: `sjt_agent-before-8163f2221a11.jar` in this directory.
- Original SHA-256: `8163f2221a115ef51364a1f8924842f53904bfc1595bb14633d47a91b941a89a`.
- Output SHA-256: `4ca7f63765a9d04d922fded78a59ba0602c8e222738b56b86725086e187a3d18`.
- Per-library hashes/instructions: `patch-manifest.json`; disassembly under
  `original/` and `patched/`, files ending in `.init.asm`.
- Builder: `../patch_all_platforms.py`, pinned to this exact original archive and
  eight library fingerprints; refuses unknown inputs and in-place builds.

To rebuild from the backup, run from the workspace root on macOS with objdump
and codesign available. The installed JAR is intentionally not accepted as input:

```sh
python3 analysis/sjt-agent/patch_all_platforms.py \
  --source analysis/sjt-agent/multiplatform/sjt_agent-before-8163f2221a11.jar \
  --output /tmp/sjt_agent-multiplatform-rebuilt.jar
python3 -m unittest discover -s analysis/sjt-agent -p test_patch_all_platforms.py -v
```

## Validation and limitations

- Ten focused unit tests pass: platform coverage, exact changes, independent
  immediate decoding, fingerprint/instruction guards, unchanged macOS x64,
  unknown-input rejection, backup and atomic installation behavior.
- ZIP CRC, archive inventory and every non-native member verified unchanged.
- macOS x86-64 / JDK 17: both GenericServlet and HttpServlet arrive decrypted at
  the Java observer; OTel initial transformation and retransformation pass.
  Evidence: `runtime-probe.log`.
- Encrypted-app integration: business and management health return HTTP 200;
  20 healthy requests and three HTTP 404 requests increase the HTTP histogram
  count by exactly 23 (2 -> 25); zero transformation failures. Evidence:
  `integration-result.json` and `integration/compatible/`.
- Windows, Linux and ARM binaries have static instruction/dataflow verification
  only. Runtime acceptance on those OS/CPU/JDK combinations remains necessary.
  This workstation cannot provide cross-platform runtime validation.
- `start.sh` is not modified. Isolated integration-test processes are stopped by
  the test; replacing the JAR does not restart an already running application.

The directory is not a Git repository, so no Git commit can be created here.
