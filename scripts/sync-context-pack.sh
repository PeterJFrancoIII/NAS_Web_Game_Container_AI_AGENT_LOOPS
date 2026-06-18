#!/bin/sh
# Install context-pack/agent into this repository root (.cursor, .claude, verify script).
# Edit files under context-pack/agent/, then run: sh scripts/sync-context-pack.sh
set -eu

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname "$0")" && pwd)"
REPO_ROOT="$(CDPATH= cd -- "$SCRIPT_DIR/.." && pwd)"
. "$SCRIPT_DIR/lib/context-pack.sh"

ROOT="$(context_pack_root)"
echo "[sync] installing agent pack from context-pack/agent -> $ROOT"
install_agent_pack "$ROOT"
echo "[sync] complete — run: sh scripts/verify-context-pack.sh"
