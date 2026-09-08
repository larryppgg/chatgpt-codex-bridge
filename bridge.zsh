#!/bin/zsh
set -euo pipefail

# Source-checkout convenience entry; the packaged service remains authoritative.
readonly BRIDGE_REPO_ROOT="${0:A:h}"
if [[ $# -eq 0 || "$1" == --help || "$1" == -h ]]; then
  print -r -- 'Usage: zsh bridge.zsh {install|doctor|status|restart|stop|uninstall} [options]'
  print -r -- 'Run from a source checkout, or use an absolute path from any directory.'
  print -r -- 'Install: --profile NAME --workspace ABSOLUTE_DIRECTORY --preset personal-full-control|workspace-safe'
  print -r -- 'Requires macOS, Codex login and an existing device Secure Tunnel profile.'
  exit 0
fi
exec /bin/zsh "${BRIDGE_REPO_ROOT}/plugins/chatgpt-codex-bridge/scripts/chatgpt-codex-bridge.zsh" "$@"
