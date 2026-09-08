# Tasks

- [x] Inspect reference README, CLI, MCP, workspace and architecture.
- [x] Revise root README and add cwd-independent service entrypoint.
- [x] Create and install the reusable presentation skill.
- [x] Validate command delegation, documentation links and privacy; publish.

Verification: root help and invalid-option forwarding passed from a different
directory; README demo/package checks and skill validation passed. Ten local
README links/assets resolved. Public checkout sanitization and Gitleaks passed.
An independent reader review found the safe-preset/async mismatch; both onboarding
documents now state it. Live account setup was not rerun for this documentation
and entrypoint change.

## Contributor verification follow-through

- [x] Consolidate existing suites into make check and run locally.
- [x] Add credential-free macOS CI and inspect the remote result.
- [x] Extend the presentation skill to cover executable validation and CI proof.

The first hosted macOS run reproduced a legacy-uninstall failure: plutil's
failed optional extraction could write diagnostics to stdout. The reader now
publishes only successful extraction output. The exact-path deletion guard is
unchanged. Existing isolated installer tests pass locally and on GitHub.
Hosted verification: https://github.com/larryppgg/chatgpt-codex-bridge/actions/runs/34226068385
at runtime commit 4d88bf3e1b2830e32c01e959436f6ad5fe962d01: success.
