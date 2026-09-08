# Design and reference comparison

Reference: https://github.com/XiaoDuoYa/codex-with-chatgpt at
`a9f91cd98df1bc82686f57d5bc2b2993394c93be` (reviewed 2026-09-08).

| Evidence inspected | Reference | This repository / decision |
| --- | --- | --- |
| README, skill/SKILL.md | Purpose, copyable setup prompt, success checklist, developer map | Adopt reader order and task-oriented examples with honest prerequisites |
| src/mcp/server.ts, docs/architecture.md | Read-only workspace tools; Codex drives browser control | Preserve ChatGPT-initiated write-capable Codex dispatch |
| src/cli/index.ts, src/process/daemon.ts | Common CLI surface, local health and repair | Reuse existing service with a thin root adapter |
| src/workspace/manager.ts | Canonical containment and bounded reads | Different data-plane scope; do not transplant into job execution |
| src/auth/*, src/tunnel/* | Own OAuth and Cloudflare transport | Retain official Secure Tunnel integration |
| package.json, tests/ | Typed modules and tests; SDK dependency is latest | Module boundaries are useful; do not copy floating dependency policy |

The reference was inspected, not installed or live-certified. Its claims about
cost, account support and hands-free browser setup are not this project's proof.
No third-party code or screenshots are copied.

Independent reader review caught an existing capability mismatch: the safe preset
returns only synchronous tools in `build_public_tools`, and `run_job` rejects
async execution outside full control. README and runbook now explicitly scope
async onboarding to personal-full-control; no new safe-mode capability is claimed.

Root `bridge.zsh` delegates to the existing packaged script using its own location,
preserving arguments/exit status. No second configuration or process owner.
README first: purpose → quick start → first task/success → component previews →
recovery → technical references. Add a self-contained publication skill with a
reviewed source in `skills/` and a matching discoverable local installation.
