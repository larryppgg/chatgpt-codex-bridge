.PHONY: help check check-protocol check-portable

help:
	@echo "make check          Run local macOS protocol, packaging and isolated install tests"
	@echo "make check-protocol Run Guard and bridge helper tests"
	@echo "make check-portable Run package, installer, sanitization and demo tests"
	@echo "These checks use test fixtures, not live ChatGPT/Tunnel credentials."

check: check-protocol check-portable

check-protocol:
	/bin/zsh tests/bridge/test-codex-mcp-guard.zsh
	/bin/zsh tests/bridge/test-check-sandbox-repo.zsh
	/bin/zsh tests/bridge/test-local-preflight.zsh
	/bin/zsh tests/bridge/test-resolve-codex-bin.zsh
	/bin/zsh tests/bridge/test-verify-tunnel-client.zsh

check-portable:
	/bin/zsh tests/portable/test-plugin-package.zsh
	/bin/zsh tests/portable/test-macos-installer.zsh
	/bin/zsh tests/portable/test-public-sanitization.zsh
	/bin/zsh tests/portable/test-readme-demo.zsh
