#!/bin/sh
# Bootstrap a new governed project from context-pack/.
# Usage: sh scripts/bootstrap-project.sh <target-dir> "<project-name>"
set -eu

if [ "$#" -lt 2 ]; then
  echo "Usage: sh scripts/bootstrap-project.sh <target-dir> \"<project-name>\"" >&2
  exit 1
fi

TARGET="$1"
PROJECT_NAME="$2"
SCRIPT_DIR="$(CDPATH= cd -- "$(dirname "$0")" && pwd)"
REPO_ROOT="$(CDPATH= cd -- "$SCRIPT_DIR/.." && pwd)"
. "$SCRIPT_DIR/lib/context-pack.sh"

ROOT="$(context_pack_root)"
mkdir -p "$TARGET"
TARGET="$(CDPATH= cd -- "$TARGET" && pwd)"

echo "[bootstrap] target: $TARGET"
echo "[bootstrap] project: $PROJECT_NAME"

install_agent_pack "$TARGET"
install_bootstrap_stubs "$TARGET" "$PROJECT_NAME"

mkdir -p "$TARGET/docs/reference"
if [ -f "$ROOT/docs/reference/AI_System_Architect_Bootloader_Zero-Drift_Build_5.18.26.md" ]; then
  cp "$ROOT/docs/reference/AI_System_Architect_Bootloader_Zero-Drift_Build_5.18.26.md" "$TARGET/docs/reference/"
fi

if [ -f "$ROOT/docs/specs/mcp-allowlist.md" ]; then
  cp "$ROOT/docs/specs/mcp-allowlist.md" "$TARGET/docs/specs/"
fi

if [ -f "$ROOT/docs/architecture/nas-stable-pointer.md" ]; then
  mkdir -p "$TARGET/docs/architecture"
  cp "$ROOT/docs/architecture/nas-stable-pointer.md" "$TARGET/docs/architecture/"
fi

sh "$ROOT/scripts/verify-context-pack.sh" "$TARGET"

echo "[bootstrap] complete: $TARGET"
echo "[bootstrap] next: cd \"$TARGET\" && git init && edit docs/specs/current-objective.md"
