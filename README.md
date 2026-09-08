# ChatGPT Codex Bridge

**在 ChatGPT 里交代任务，让本机 Codex 创建项目、写代码和运行测试。**

适合希望在 ChatGPT 网页里主导开发，并在 Mac 的 Codex App 中查看项目和任务的用户。
ChatGPT 派工与审查，Codex 执行；同一项目沿用同一任务继续修改。

macOS · 社区项目 · [MIT](LICENSE) · [安装与恢复](#快速开始) · [常见问题](#已踩过的坑) · [English](#english-reference)

## 快速开始

### 交给 Codex 安装

把下面这段话复制到 **Mac 上的 Codex**：

```text
请安装并配置 https://github.com/larryppgg/chatgpt-codex-bridge 。
先检查现有安装，保留已有项目和任务。阅读仓库安装说明与
chatgpt-codex-controller Skill，核对 Codex 登录、官方 tunnel-client
和本设备 Secure Tunnel profile。缺少账号侧能力时准确告诉我缺什么。
使用已有安装器配置工作区，运行 doctor，再指导我在 ChatGPT 附加连接器。
默认采用个人全权限预设，并说明它允许本机写入和命令执行。
完成后逐项报告：本机服务、ChatGPT 工具可调用、独立项目/任务、
一次演示任务的文件与测试结果。未验证的项目标为未验证。
```

需要准备：Mac、可用的 Codex 登录、Python 3、官方 `tunnel-client` 及本设备
Secure Tunnel profile。ChatGPT 账号必须实际提供相应连接入口。
登录、验证码和账号授权可能需要用户完成；复制这段话不会自动获得这些权限。

### 从源码手动安装

以下命令在终端执行；首次克隆选择一个不存在的目录：

```zsh
git clone https://github.com/larryppgg/chatgpt-codex-bridge.git
cd chatgpt-codex-bridge
zsh bridge.zsh --help
```

接着在**仓库根目录**安装（替换示例参数，工作区目录须已存在）：

```zsh
zsh bridge.zsh install \
  --profile YOUR_DEVICE_PROFILE \
  --workspace /absolute/existing/workspace \
  --preset personal-full-control
zsh bridge.zsh doctor
```

`personal-full-control` 允许 Codex 完整本机访问且不逐项审批；需要工作区范围
写入与审批时用 `workspace-safe`，但该预设目前只公开同步工具，**不支持下面的
异步新项目、后台 Job 和状态卡片流程**。此处安装器使用已有 profile，
不会代为完成 ChatGPT 账号授权。详细步骤见 [安装手册](docs/runbooks/portable-plugin.md)。

偏好 Codex 插件管理器时，可使用 [固定版本安装](docs/runbooks/portable-plugin.md#install-the-verified-release)；
根目录的 `bridge.zsh` 是源码入口，插件包内继续使用 `scripts/` 下的命令。

## 第一次使用

本节使用 `personal-full-control` 预设。

在 ChatGPT 中授权本设备的 Secure Tunnel App，选择 **Use in chat / 在聊天中试用**，
确认输入框附加了 `Codex MCP Guard`。然后发送：

```text
用 Codex 新建 bridge-demo 项目，做一个纯本地的 Markdown 待办清单工具。
先用 workspace-new-project 初始化 spec 和 ADR，再实现、测试。
你负责审查结果，缺什么就在同一 Codex 任务继续修改。
```

完成后应能确认：

- Codex App 出现独立项目和对应任务；
- 项目中实际有文件和测试结果；
- ChatGPT 收到终态结果，并能继续同一任务。

`doctor` 的本机 `ready` 只证明服务检查通过，不能替代这三项验证。
任务返回 `queued` 或 `running` 时仍在处理，ChatGPT 应继续等待。
当前轮结束后，可打开原对话的任务卡片，点击“把结果发给 ChatGPT 审查”恢复。

继续同一项目时可以说：“继续刚才的项目，加上完成状态筛选，运行测试后汇报。”
不要为了追问进度重新创建项目。

## 它解决什么问题

- ChatGPT 负责理解目标、拆任务、检查结果和决定下一步。
- Secure MCP Tunnel 把 ChatGPT 的 MCP 调用转发到本机，不要求开放公网
  入站端口。
- Codex MCP Guard 负责固定工作区、权限预设、Job 状态和任务恢复。
- Codex App Server 在独立项目目录中创建可被 Codex 桌面端识别的项目和
  任务。
- 新项目第一条指令显式调用内置 `workspace-new-project` Skill，先建立
  `AGENTS.md`、README、spec、ADR、源码与项目记忆结构。

## 页面演示

以下是本项目状态卡片的浏览器截图，使用合成数据；它们演示组件的三种状态，
不代表一次真实 ChatGPT → Codex 全链路执行。

### 1. Codex 在后台执行

Codex 可在后台执行。卡片保持加载且客户端支持组件工具时，会轮询 Job 状态。

![Codex 后台执行页面演示](docs/assets/readme/codex-job-running.jpg)

### 2. Codex 完成并等待 ChatGPT 审查

任务进入终态后，卡片显示合成结果，并提供显式的“把结果发给 ChatGPT
审查”按钮。

![Codex 完成页面演示](docs/assets/readme/codex-job-completed.jpg)

### 3. 中断后的恢复入口

如果本机任务被停止或服务重启，卡片保留终态和恢复入口，不会伪装成
成功，也不会自动新建平行 Codex 任务。

![Codex 中断恢复页面演示](docs/assets/readme/codex-job-interrupted.jpg)

## 日常操作

以下命令均从源码仓库根目录执行，也可从任意目录使用入口脚本的绝对路径。

```zsh
zsh bridge.zsh status
zsh bridge.zsh doctor
zsh bridge.zsh restart
zsh bridge.zsh stop
zsh bridge.zsh uninstall
```

在 `personal-full-control` 预设下，长任务应使用：

- 新项目：`codex-start` → 重复 `codex-wait`；
- 同项目继续：`codex-reply-async` → 重复 `codex-wait`；
- 旧卡片恢复：`codex-job-open`，不要重复 `codex-start`；
- `codex` / `codex-reply` 只用于短诊断。

`stop`、重装和卸载会撤销归属已验证的后台进程组；卸载会清除 Bridge
自己的 capability/job 状态，但保留外部 Tunnel profile、项目仓库和 Codex
对话历史。无法证明进程归属时会 fail closed，避免误杀其他进程。

## 安全模型与信任边界

克隆或安装本仓库不会自动获得任何设备的执行权限。仓库不包含：

- Tunnel profile 或 runtime key；
- ChatGPT Developer MCP 授权；
- Codex 登录凭据；
- 本机 capability 签名密钥；
- 原始 Codex thread/job ID；
- 浏览器 Cookie、SSH key、Keychain 或生产环境变量。

建立执行链必须同时满足：

1. Bridge 已在本机安装并运行；
2. 本设备的 Tunnel profile 有效；
3. ChatGPT 已授权对应的 Secure Tunnel App；
4. 当前 ChatGPT 对话明确附加 `Codex MCP Guard`。

`personal-full-control` 是高权限预设：
`danger-full-access + approval-policy=never`。共享或低信任环境应使用
`workspace-safe` 的同步诊断工具；当前异步开发工作流只支持全权限预设。
MCP 调用方不能临时切换预设、扩大权限或指定任意
`cwd`；公开 Job/Thread capability 会绑定安装、工作区和权限策略。

## 已踩过的坑

### 1. 旧对话不一定支持 Developer MCP

看到 `This conversation does not support developer MCPs` 时，新建对话并确认
App pill 真正在当前对话里。旧对话即使能看到连接器名称，也可能没有对应
工具运行时。

### 2. 手机上看得到 App，不等于能够执行

“可见”只证明客户端能显示连接器。必须看到真实 tool call、Job ID 和终态，
才算本机 Codex 调度成功。

### 3. 已安装但返回 0 个函数

常见原因是当前对话没有附加 App、ChatGPT 缓存旧 schema、Tunnel 未
`ready`，或 Guard/插件版本漂移。依次检查 `status`、`doctor`，刷新 App，
再新建对话。

### 4. `Failed to fetch template`

这表示卡片资源没有成功加载，单凭这条提示不能确认本机任务是否执行。
先检查 Tunnel 和原 Job 状态；有有效 Job 时用 `codex-job-open` 重开同一卡片。
以卡片成功加载、原 Job 状态可读为恢复标志，避免重复提交开发任务。

### 5. `queued` 不是完成

`codex-start` 立即返回只代表入队成功。必须继续 `codex-wait`，直到
`completed`、`failed` 或 `interrupted`，然后审查代码、测试和 Git 状态。

### 6. ChatGPT 不会永久在线，也没有零点击反向唤醒

Codex 可以在后台继续，但普通 ChatGPT 回合结束后，MCP 不能无条件向旧
对话主动发消息。卡片按钮是明确的用户恢复动作，不是 24/7 unsolicited
reverse push。

### 7. MCP thread 不自动等于 Codex 侧边栏任务

单纯运行 `codex mcp-server` 可能返回 threadId，但不保证 Codex 桌面端侧边栏
出现项目。本 Bridge 使用 App Server 创建 project/task，并校验 projectId、
threadId 和 `cwd` 一致。

### 8. 不要在插件中加入 `.mcp.json`

Guard 的服务对象是 ChatGPT Secure Tunnel。若让 Codex 自己把 Guard 当成
MCP 客户端加载，会形成 `Codex → Guard → Codex` 的递归或重复控制路径，
也不会完成 ChatGPT Developer Mode 授权。

### 9. v0.6.0 的安全缺口

- capability 没有完整绑定 workspace/preset；
- stop/uninstall 没有完整撤销 detached worker 进程组；
- Tunnel 验证脚本在 checksum/provenance 通过前执行候选二进制；
- Apps follow-up 可能把 Codex 原始文本拼成 user-role 消息；
- 同步工具缺少独立并发和截止时间边界。

这些问题已在 v0.6.1 修复。v0.6.0 已退出公开分发，不能作为安全回滚版本。

### 10. 当前目录脱敏不等于 Git 历史脱敏

扫描当前树通过，只能证明当前树。公开前还必须检查全部提交、tag、作者
邮箱、删除过的文件和 release 附件；测试 fixture 也不能通过拆分字符串来
保留真实识别值。

### 11. README 截图同样属于发布物

已登录账号截图可能暴露用户名、App/Tunnel 名称、对话 ID、真实项目、路径、
书签和通知。本 README 只发布由实际组件代码渲染的合成演示页面，并明确
标记 `DEMO · SYNTHETIC DATA`。若使用真实产品截图，须审查裁剪或遮盖后的
最终文件与元数据，并保留足够的操作上下文；这些组件预览不代替全链路验收。

### 12. 旧配置卸载报 `refusing unexpected uninstall target`

部分 macOS 版本的 `plutil` 在可选字段不存在时把错误写到标准输出，旧读取
逻辑可能把它当作路径。当前源码已修复：只接受成功读取的值，失败时回落到
兼容路径，并保留精确路径校验。此修复尚不在旧 v0.6.1 标签中；遇到该问题
使用当前源码卸载入口，不要手动放宽路径校验。

## 开发与仓库导航

| 位置 | 用途 |
| --- | --- |
| `bridge.zsh` | 源码安装、诊断与停止入口 |
| `scripts/bridge/` | MCP Guard、异步 Job 与 Codex App Server 集成 |
| `plugins/chatgpt-codex-bridge/` | 可分发插件、服务脚本和控制技能 |
| `tests/bridge/`、`tests/portable/` | 协议、安装与打包验证 |
| `docs/runbooks/` | 安装、升级与恢复说明 |
| `docs/specs/`、`docs/adr/` | 功能规格及架构决策 |
| `skills/github-project-presentation/` | 可复用 GitHub 项目表达与发布 skill |

贡献修改时，先说明用户场景与实际变化，运行相关测试；Guard 源码和打包副本须保持一致。
可复用文档规范见 [GitHub 项目表达 skill](skills/github-project-presentation/SKILL.md)。
与参考仓库的 [代码及文档比较](docs/specs/github-reader-experience/design.md) 记录了采用与保留的理由。

## 发布前验证

开发者在 macOS 的仓库根目录运行：

```zsh
make check
```

这个入口运行现有 Guard 协议、辅助脚本、打包、隔离安装/卸载和脱敏测试。
GitHub 的 [Checks](https://github.com/larryppgg/chatgpt-codex-bridge/actions/workflows/check.yml)
使用相同命令。测试采用合成 Codex/Tunnel，不需要账号凭据；真实 ChatGPT
连接和侧边栏效果仍按“第一次使用”的验收步骤检查。

排查单项失败时可用 `make check-protocol` 或 `make check-portable`，也可单独运行：

```zsh
/usr/bin/python3 tests/bridge/test-codex-mcp-guard.py
/bin/zsh tests/bridge/test-verify-tunnel-client.zsh
/bin/zsh tests/portable/test-macos-installer.zsh
/bin/zsh tests/portable/test-public-sanitization.zsh
/bin/zsh tests/portable/test-plugin-package.zsh
/bin/zsh tests/portable/test-readme-demo.zsh
gitleaks git --redact --no-banner
git fsck --full --strict
```

带有私有识别值的 denylist 必须保存在仓库外：

```zsh
/bin/zsh scripts/release/check-public-sanitization.zsh \
  --repo "$PWD" \
  --denylist /absolute/private-denylist.txt
```

完整标准见 [GitHub 仓库公开发布与脱敏清单](docs/GITHUB_RELEASE_CHECKLIST.zh-CN.md)。

## 平台边界

- 当前服务封装只支持 macOS LaunchAgent；Windows/Linux 暂未实现。
- 这是 MIT 社区项目，不是 OpenAI 官方产品。
- 仓库不提供 ChatGPT、Codex、Tunnel、GitHub 或设备凭据。
- 不承诺所有账号套餐都开放 Developer MCP，以当前产品 UI 和真实工具调用
  为准。
- 不承诺普通 ChatGPT 对话结束后能够零点击反向唤醒。

---

## English reference

Version 0.6.1 is the security-hardened macOS bridge between a ChatGPT Secure
MCP Tunnel and local Codex. `codex-start` creates a unique child project root,
registers it with the Codex desktop app, creates an App Server project/task,
and explicitly invokes the bundled `workspace-new-project` Skill before
implementation.

The repository marketplace is `.agents/plugins/marketplace.json`. The plugin
contains the controller Skill, reviewed Guard, parameterized LaunchAgent, and
install/doctor/uninstall commands. Device-specific Tunnel identity, signing
keys, raw thread/job IDs, and credentials remain outside Git.

For long work, use `codex-start` or `codex-reply-async`, then call
`codex-wait` until a terminal state. If the ChatGPT turn has ended, reopen the
Apps card and use its explicit return control. This is user-initiated recovery,
not an unsolicited reverse push.

Install and operate the service through
[`docs/runbooks/portable-plugin.md`](docs/runbooks/portable-plugin.md). Review
the inline Chinese guide above for the complete setup, screenshots, security
boundaries, recovery workflow, and known pitfalls.
