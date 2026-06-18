#!/bin/sh
# Bootstrap a new project with the Zero-Drift context pack.
# Usage: sh scripts/bootstrap-project.sh <target-dir> "<project-name>"
set -eu

if [ "$#" -lt 2 ]; then
  echo "Usage: sh scripts/bootstrap-project.sh <target-dir> \"<project-name>\"" >&2
  exit 1
fi

TARGET="$1"
PROJECT_NAME="$2"
SCRIPT_DIR="$(CDPATH= cd -- "$(dirname "$0")" && pwd)"
OS_ROOT="$(CDPATH= cd -- "$SCRIPT_DIR/.." && pwd)"
TEMPLATE_DIR="$OS_ROOT/templates/project-bootstrap"

if [ ! -d "$TEMPLATE_DIR" ]; then
  echo "[bootstrap] ERROR: template dir not found: $TEMPLATE_DIR" >&2
  exit 1
fi

mkdir -p "$TARGET"
TARGET="$(CDPATH= cd -- "$TARGET" && pwd)"

echo "[bootstrap] target: $TARGET"
echo "[bootstrap] project: $PROJECT_NAME"

# Copy template tree
cp -R "$TEMPLATE_DIR/." "$TARGET/"

# Customize MISSION.md project name placeholder
if [ -f "$TARGET/MISSION.md" ]; then
  sed "s/{{PROJECT_NAME}}/$PROJECT_NAME/g" "$TARGET/MISSION.md" > "$TARGET/MISSION.md.tmp"
  mv "$TARGET/MISSION.md.tmp" "$TARGET/MISSION.md"
fi

# Customize current-objective stub
if [ -f "$TARGET/docs/specs/current-objective.md" ]; then
  sed "s/{{PROJECT_NAME}}/$PROJECT_NAME/g" "$TARGET/docs/specs/current-objective.md" > "$TARGET/docs/specs/current-objective.md.tmp"
  mv "$TARGET/docs/specs/current-objective.md.tmp" "$TARGET/docs/specs/current-objective.md"
fi

# Copy reference bootloader spec (on-demand layer)
mkdir -p "$TARGET/docs/reference"
if [ -f "$OS_ROOT/docs/reference/AI_System_Architect_Bootloader_Zero-Drift_Build_5.18.26.md" ]; then
  cp "$OS_ROOT/docs/reference/AI_System_Architect_Bootloader_Zero-Drift_Build_5.18.26.md" \
    "$TARGET/docs/reference/"
fi

# Verify bootstrapped project
if [ -f "$OS_ROOT/scripts/verify-context-pack.sh" ]; then
  sh "$OS_ROOT/scripts/verify-context-pack.sh" "$TARGET"
fi

echo "[bootstrap] complete: $TARGET"
echo "[bootstrap] next: cd \"$TARGET\" && git init && edit docs/specs/current-objective.md"
