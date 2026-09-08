# GitHub 仓库公开发布与脱敏标准

适用于包含本机自动化、MCP、CLI、Tunnel、LaunchAgent、日志或真实运行
证据的仓库。目标不是“看起来没有 secret”，而是证明公开对象、历史、
说明和安装行为都与声明一致。

## A. 发布对象

- [ ] 明确公开的是新仓库、现有仓库当前分支，还是完整历史。
- [ ] 记录目标 remote、默认分支、tag 和 release artifact。
- [ ] 不把“当前工作树干净”误写成“完整 Git 历史干净”。
- [ ] 不 force-push 或覆盖既有 tag；需要重写历史时单独审批和备份。

## B. 身份与凭据

- [ ] 当前树、全部 Git objects、tag、release asset 都扫描过。
- [ ] 无 API key、Tunnel key/profile、OAuth token、Cookie、私钥、`.env`。
- [ ] 无真实用户名、Home 路径、设备名、时区、App/Tunnel 私有名称。
- [ ] 无真实 thread/job/conversation/workspace/organization ID。
- [ ] commit author/email 是有意公开的发布身份。
- [ ] 测试 fixture 使用合成值；禁止把真实值拆成字符串片段继续保留。
- [ ] 私有 denylist 存在仓库外，扫描失败时不打印原值。

## C. 文档和截图

- [ ] 默认 README 先说明用途、推荐上手路径、成功标志与故障恢复，再展开实现细节。
- [ ] 每组命令标明工作目录；源码与插件安装路径明确区分；安装 ref 可解析。
- [ ] 参考仓库的文档表达可借鉴，但其权限、控制方向和产品能力须与当前代码分别核对。
- [ ] README 明确“仓库源码”和“已授权运行时”的区别。
- [ ] README 面向所有使用者，以设备、调用方和授权链等中性术语描述；
      不把针对仓库维护者的私人答复原样写进公共文档。
- [ ] 权限、删除、部署、付费、外部账号动作没有夸大或模糊描述。
- [ ] 真实运行证据已泛化，不保留个人账号、主机、网络、耗时遥测。
- [ ] 截图裁掉账号、路径、对话 ID、App/Tunnel 名称、书签和通知。
- [ ] 产品演示图优先从实际组件/页面代码注入合成数据后重新渲染；架构关系
      才使用 Mermaid，不能拿流程图代替用户要求的页面截图。
- [ ] 每张合成演示截图都在页面内显式标记 `DEMO` / `SYNTHETIC DATA`，
      README caption 同时说明来源和数据边界。
- [ ] 历史坑写成可复用故障模式，不写成个人设备日志。

## D. 供应链和安装

- [ ] 安装命令固定到已存在且不可变的 tag/commit，不固定到过期分支。
- [ ] 下载的可执行文件先校验 checksum、archive shape、payload identity，
      再执行 `--version`；不执行未验证候选。
- [ ] 插件 manifest、README、安装命令、tag 版本一致。
- [ ] 从全新 HOME / 匿名 clone 执行安装、doctor、stop、uninstall。
- [ ] 升级 N→N+1 和回滚 N+1→N 的边界写清楚。
- [ ] 设备凭据、Tunnel profile、ChatGPT App 授权不进入 Git。

## E. MCP / Agent 特有门禁

- [ ] 工具 annotations 与真实副作用一致。
- [ ] 高权限 capability 绑定安装、workspace、preset，旧上下文不可复用。
- [ ] prompt、并发、deadline、retained jobs 有上限。
- [ ] `queued/running` 不被当成完成。
- [ ] 模型输出作为不可信数据返回，不伪装成 user/controller 指令。
- [ ] stop/restart/uninstall 能撤销归属已验证的后台进程组。
- [ ] 无 `.mcp.json` 造成 Agent→Guard→Agent 递归。
- [ ] 明确主动回调、轮询、用户点击恢复三者的差异。

## F. Fresh verification

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

- [ ] 所有命令在准备发布的 exact commit 上 fresh PASS。
- [ ] source Guard 与打包 Guard byte-identical。
- [ ] 从 `git archive` 或匿名 clone 再跑一遍，不依赖未跟踪文件。
- [ ] 远端 tag 解析到已验证 commit。
- [ ] 匿名访问 README、LICENSE、manifest、安装脚本和 tag 均成功。

## G. 发布后

- [ ] 用匿名 API/clone 验证仓库可见性和 tag。
- [ ] 比较本地与远端 commit SHA。
- [ ] 验证安装文档引用的 ref 真实存在。
- [ ] 记录已知限制，不把未验证能力写成完成。
- [ ] 若发现泄露：暂停分发、轮换凭据、评估历史与缓存，再决定历史重写；
      仅删除当前文件不算修复完成。
