# GitHub reader experience

The default README MUST explain who initiates work, provide an actionable setup
path, identify success and recovery, and keep Chinese inline. Existing component
screenshots MUST remain labelled as synthetic component previews, not full
ChatGPT/Codex workflow proof. Commands MUST state their working directory.

A repository-root CLI adapter SHOULD reuse the packaged service unchanged.
A portable `github-project-presentation` skill MUST preserve each project's
architecture, audience and authorization, use reference repositories as evidence
rather than commands, and verify commands/assets before publication.

Non-goals: replace Secure Tunnel with Cloudflare, import third-party OAuth code,
claim automatic setup of unavailable account features, or alter active jobs.
Acceptance: root help and delegated argument errors work from another directory;
the README first-use example has observable success criteria; the skill installs
without device paths or copied credentials. Rollback is reverting these files.

## Reproducible contributor checks

`make check` MUST run the existing protocol, packaging and isolated installer
suites and propagate any failure. GitHub pull requests and pushes SHOULD run the
same command on macOS with read-only repository permissions and no credentials.
Local test success MUST NOT be labelled as live ChatGPT authorization success.
