# SJT 加密类与 OpenTelemetry 插桩兼容性分析

本文记录加密应用、SJT Agent 和 OpenTelemetry Java Agent 同时运行时的故障现象、定位过程、根因、修复方式及验证方法，便于后续升级 Agent、JDK 或部署平台时复查。

## 1. 问题背景

应用使用 SJT/Virbox 对 JAR 中的 Java 类进行保护。启动参数同时加载：

```text
-javaagent:sjt_agent.jar
-javaagent:opentelemetry-javaagent.jar
```

SJT 的 Java 入口 `com.sense.Loader.premain` 主要负责选择、解压并加载当前平台的 native library；真正的解密逻辑位于 native JVMTI `ClassFileLoadHook`，不是 Java `Instrumentation` transformer。

## 2. 现象与启动脚本问题

典型现象包括：

- 应用本身可能可以启动，健康接口返回 200；
- OTel 日志出现 `Failed to handle ... for transformation`；
- `GenericServlet`、`HttpServlet` 等受保护类的 ASM 解析失败；
- `/metrics` 端点可能仍然返回 200，但没有 `http_server_request_duration_seconds`；
- 因此不能仅用 `/metrics` 的 HTTP 状态码判断 HTTP 自动插桩是否成功。

前台启动脚本曾出现：

```text
./start.sh: 行 14: EXISTING_PID?: 未绑定的变量
```

原因是脚本使用 `set -u` 时，变量名后的 `?` 被 shell 解析为变量名的一部分，而不是问号文本。应使用明确的变量边界，例如 `${EXISTING_PID}`。本次任务保留前台启动行为，没有改成后台启动；脚本中 Java 进程退出后的旧 PID bookkeeping 逻辑不影响前台运行，但后续可单独清理。

## 3. 根因：JVMTI hook 顺序

原始 native 初始化逻辑大致如下：

1. `JavaVM->GetEnv(..., JVMTI_VERSION_1_1)` 获取 `jvmtiEnv`；
2. `AddCapabilities` 请求包括以下两项在内的能力：

   ```text
   can_retransform_classes = 1
   can_retransform_any_class = 1
   ```

3. 注册 `ClassFileLoadHook`；
4. 启用 `JVMTI_EVENT_CLASS_FILE_LOAD_HOOK`（事件编号 54）。

原始能力掩码为：

```text
0x60ac000008
```

其中高 32 位的 `0x60` 对应两个 retransformation 能力。SJT 的 native hook 因此属于可重转换 transformer 组。JVM 在类首次定义时先把加密字节交给 Java transformer（包括 OTel），之后 SJT 才在 native hook 中解密。于是 OTel 的 ASM 看到的是加密/保护格式，解析失败；JVM 后续仍可能使用 SJT 解密后的字节完成类加载，所以应用健康接口不一定失败。

这也解释了为什么：

- OTel 可能报告转换错误，但服务仍能启动；
- JVM exporter 指标端点仍可访问；
- HTTP server 指标缺失，因为 servlet 类没有被 OTel 正确插桩。

## 4. Agent_OnLoad 的可读实现

`Agent_OnLoad` 本身只是调用统一初始化函数：

```c
JNIEXPORT jint JNICALL
Agent_OnLoad(JavaVM *vm, char *options, void *reserved)
{
    return sjt_initialize(vm);
}
```

初始化流程可概括为：

```c
static jint sjt_initialize(JavaVM *vm)
{
    jvmtiEnv *jvmti = NULL;
    jvmtiCapabilities caps = {0};
    jvmtiEventCallbacks callbacks = {0};
    jvmtiError err;

    if (virbox_initialize() != 0)
        return JNI_ERR;

    err = (*vm)->GetEnv(vm, (void **)&jvmti, JVMTI_VERSION_1_1);
    if (err != JVMTI_ERROR_NONE)
        return err;

    /* 保留其他能力；不要申请两个 retransformation 能力。 */
    caps.can_tag_objects = 1;
    caps.can_get_bytecodes = 1;
    /* 其他原有能力按供应商版本填写。 */
    caps.can_retransform_classes = 0;
    caps.can_retransform_any_class = 0;

    err = (*jvmti)->AddCapabilities(jvmti, &caps);
    if (err != JVMTI_ERROR_NONE &&
        err != JVMTI_ERROR_NOT_AVAILABLE)       /* 98 */
        return err;

    callbacks.ClassFileLoadHook = sjt_ClassFileLoadHook;
    err = (*jvmti)->SetEventCallbacks(
        jvmti, &callbacks, sizeof(callbacks));
    if (err != JVMTI_ERROR_NONE)
        return err;

    err = (*jvmti)->SetEventNotificationMode(
        jvmti, JVMTI_ENABLE,
        JVMTI_EVENT_CLASS_FILE_LOAD_HOOK, NULL);
    return err == JVMTI_ERROR_NONE ? JNI_OK : err;
}
```

真实 native 代码还包含 Virbox 初始化、错误打印、初始化状态位，以及受保护类的解密算法；上述代码只表达控制流和 JVMTI 语义，不是供应商源码的逐字恢复。

## 5. 解决方案

核心方案是让 SJT 解密 hook 进入**不可 retransformation 的 transformer 组**，同时保留 OTel 的可重转换能力：

```c
caps.can_retransform_classes = 0;
caps.can_retransform_any_class = 0;
(*jvmti)->AddCapabilities(jvmti, &caps);
```

等价的 native 能力掩码变化：

```text
0x60ac000008  ->  0x00ac000008
```

这样类首次定义时，JVM 先得到 SJT 解密后的字节，再交给 OTel；后续 OTel 重转换时，JVM 会复用不可重转换 hook 的先前输出，SJT 不需要再次解密，OTel 可以稳定拿到合法 classfile。

### 5.1 当前多平台二进制补丁

由于没有供应商 native 源码，实际采用了版本固定、哈希校验、指令校验的二进制补丁。每个平台只修改一条设置能力掩码的指令：

| 成员 | 文件偏移 | 修改 |
|---|---:|---|
| `libs/sjt_windows_x64.dll` | `0x65F` | `movl $96` → `movl $0` |
| `libs/sjt_windows_x86.dll` | `0x619` | `movl $96` → `movl $0` |
| `libs/sjt_linux_x64.so` | `0x31B7C` | `movb $96` → `movb $0` |
| `libs/sjt_linux_x86.so` | `0x22EBA` | `movb $96` → `movb $0` |
| `libs/sjt_linux_a64.so` | `0x91BAC` | `mov w2,#96` → `mov w2,#0` |
| `libs/sjt_linux_a32hf.so` | `0x3CC9C` | `orr r3,r3,#96` → `orr r3,r3,#0` |
| `libs/sjt_darwin_a64.dylib` | `0x7AEFC` | `movk x8,#96` → `movk x8,#0` |
| `libs/sjt_darwin_x64.dylib` | `0x2EAE` | 已修复，保持不变 |

偏移均为 native 文件内部偏移，不是 JAR 整体偏移。构建脚本为 `analysis/sjt-agent/patch_all_platforms.py`，会校验源 JAR、每个 native library 的 SHA-256、目标指令字节和 ZIP 完整性；未知版本拒绝修改。

### 5.2 签名与回滚

- macOS ARM64 补丁后进行 ad-hoc codesign，并通过 `codesign --verify --strict`；
- Windows 原 DLL 无签名证书目录，未移除签名；
- macOS x64 保留用户已验证版本，字节级不变；
- 原始 JAR 备份为 `analysis/sjt-agent/multiplatform/sjt_agent-before-8163f2221a11.jar`；
- 当前兼容包为 `sjt_agent-multiplatform-otel-compat.jar`；
- 当前安装包 SHA-256：

  ```text
  4ca7f63765a9d04d922fded78a59ba0602c8e222738b56b86725086e187a3d18
  ```

回滚时停止应用，恢复备份 JAR，再按原启动方式启动。不要把其他版本的相同偏移直接套用到新版本。

## 6. 验证方法

### 6.1 类转换验证

使用 Java observer 记录 SJT 前后的 classfile，并调用 OTel：

```bash
python3 analysis/sjt-agent/verify_compat_probe.py \
  analysis/sjt-agent/multiplatform/runtime-probe.log
```

应确认 `javax.servlet.GenericServlet` 和 `javax.servlet.http.HttpServlet`：

- Java 侧首次输入已是解密格式；
- OTel 初次 transform 成功；
- `Instrumentation.retransformClasses` 再次成功；
- 日志中没有 transformation failure。

### 6.2 HTTP 与 OTel 指标验证

先产生业务流量：

```bash
for i in {1..5}; do
  curl -fsS http://127.0.0.1:8999/demo/api/health
  printf '\n'
done
```

再访问 Prometheus exporter，并检查 HTTP histogram：

```bash
curl -fsS http://127.0.0.1:9466/metrics \
  | grep '^http_server_request_duration_seconds'
```

应能看到 `_bucket`、`_sum`、`_count` 系列。仅返回 HTTP 200 只能证明 exporter 可访问，不能证明 servlet 已插桩。

本机已验证：20 次健康请求加 3 次不存在路由请求，HTTP count 增量为 23；OTel transformation failures 为 0。

## 7. 风险与边界

- 本机已在 macOS x86-64、JDK 17、同一加密应用上完成运行验证；Windows、Linux、ARM 目前是静态反汇编和完整性验证，仍应在对应 OS/CPU/JDK 上做启动、类转换、指标和压力测试。
- 这是针对固定版本 native library 的实验性兼容补丁，不等同于供应商正式发布版本。
- OTel 正确插桩意味着解密后的 class bytes 会在 JVM 进程内存中出现；该方案不承诺保持原有反分析强度。
- 需要验证 redefine/retransform、热加载、类卸载、不同 JDK 版本和长期运行行为。
- 升级 `sjt_agent.jar`、JDK、OTel 或应用包后，应重新检查 native SHA-256 和 JVMTI 能力顺序，不能盲目复用偏移。

## 8. 相关文件

- `analysis/sjt-agent/patch_all_platforms.py`：多平台构建与安装脚本。
- `analysis/sjt-agent/multiplatform/patch-manifest.json`：逐库哈希、偏移和指令证据。
- `analysis/sjt-agent/multiplatform/README.md`：多平台补丁说明与限制。
- `analysis/sjt-agent/verify_integration.py`：加密应用集成验证。
- `analysis/sjt-agent/verify_compat_probe.py`：类转换/重转换验证。
- `analysis/sjt-agent/native/disassembly.txt`：macOS x64 反汇编证据。
- `analysis/sjt-agent/probe/capability-layout.txt`：JVMTI 函数表偏移验证。

