# SJT Agent / OpenTelemetry 加密插桩兼容分析

本仓库整理 SJT 加密 Agent 与 OpenTelemetry Java Agent 同时运行时的根因分析、native patch 工具、原版/兼容版 JAR、反汇编证据和参考 C 代码。

## 结论

SJT 通过 JVMTI `ClassFileLoadHook` 解密 classfile。原版同时申请 `can_retransform_classes` 和 `can_retransform_any_class`，导致 SJT hook 与 OTel 的可重转换 transformer 排在同一阶段：OTel 先看到加密字节，ASM 解析失败。兼容方案把能力掩码从 `0x60ac000008` 改为 `0x00ac000008`，不申请两个 retransformation 能力。这样 JVM 会先固定 SJT 的解密输出，再交给 OTel 插桩。

这不是修改解密算法，也不是修改 Java Loader；每个平台 native library 只改动一条设置能力掩码的指令。

## 目录

- `artifacts/`：`sjt_agent-original.jar`、`sjt_agent-otel-compat.jar` 和已安装副本。
- `reference/agent_onload_reference.c`：依据反汇编恢复的易读 C 参考实现（伪代码，非供应商源码）。
- `tools/patch_all_platforms.py`：版本固定、哈希校验、指令校验、签名和原子安装工具。
- `tools/test_patch_all_platforms.py`：10 项补丁完整性测试。
- `tools/verify_compat_probe.py`、`tools/verify_integration.py`：类重转换和加密应用验证工具。
- `docs/SJT-OTel加密插桩问题分析与解决方案.md`：完整中文分析文档。
- `docs/COMPATIBILITY.md`：兼容补丁设计、回归结果和风险边界。
- `verification/patch-manifest.json`：逐库 SHA-256、偏移、前后指令和验证记录。
- `native/`：native 原始/补丁库、反汇编、符号和字符串证据。
- `verification/probe/`、`verification/integration/`：运行验证日志和指标结果。

## 平台补丁位置

| 平台库 | 文件偏移 | 虚拟地址 | 修改 |
|---|---:|---:|---|
| `sjt_windows_x64.dll` | `0x65f` | `0x18000125f` | `movl $96` → `movl $0` |
| `sjt_windows_x86.dll` | `0x619` | `0x10001219` | `movl $96` → `movl $0` |
| `sjt_linux_x64.so` | `0x31b7c` | `movb $96` → `movb $0` |
| `sjt_linux_x86.so` | `0x22eba` | `movb $96` → `movb $0` |
| `sjt_linux_a64.so` | `0x91bac` | `mov w2,#96` → `mov w2,#0` |
| `sjt_linux_a32hf.so` | `0x3cc9c` | `orr r3,r3,#96` → `orr r3,r3,#0` |
| `sjt_darwin_a64.dylib` | `0x7aefc` | `movk x8,#96` → `movk x8,#0` |
| `sjt_darwin_x64.dylib` | `0x2eae` | 已是兼容版本，保持不变 |

偏移是 native 文件内部偏移，不是 JAR 整体偏移。不要把偏移直接套到其他版本。

## 重新构建与测试

在本仓库根目录执行：

```bash
python3 tools/patch_all_platforms.py \
  --source artifacts/sjt_agent-original.jar \
  --output /tmp/sjt_agent-otel-compat.jar

python3 -m unittest discover -s tools -p 'test_patch_all_platforms.py' -v
```

构建脚本会拒绝未知 SHA-256、错误指令和原地构建；会校验 ZIP 条目、CRC、非 native 条目字节一致性，并对 macOS ARM64 进行 ad-hoc 签名校验。

## 运行验证

本机 macOS x86-64/JDK 17 已验证：GenericServlet 和 HttpServlet 的首次插桩及重转换成功；加密应用 20 次健康请求加 3 次 404 请求后，HTTP histogram count 增量为 23，OTel transformation failures 为 0。可参考 `verification/integration/`。

检查实际 HTTP 指标：

```bash
curl -fsS http://127.0.0.1:9466/metrics \
  | grep '^http_server_request_duration_seconds'
```

`/metrics` 返回 200 只能证明 exporter 可访问，必须检查 `http_server_request_duration_seconds` 系列才能判断 HTTP 自动插桩是否生效。

Windows、Linux、ARM 目前完成静态指令/数据流和归档完整性验证，仍需在对应 OS、CPU 和 JDK 上进行运行验收。

## 版本与哈希

- 原版 JAR：`artifacts/sjt_agent-original.jar`
- 兼容版 SHA-256：`4ca7f63765a9d04d922fded78a59ba0602c8e222738b56b86725086e187a3d18`
- 原版 SHA-256：`8163f2221a115ef51364a1f8924842f53904bfc1595bb14633d47a91b941a89a`

这是固定版本的实验性兼容补丁，不是供应商正式发布版本。升级 JAR、JDK、OTel 或应用后，应重新反汇编、核验哈希并执行完整验证。
