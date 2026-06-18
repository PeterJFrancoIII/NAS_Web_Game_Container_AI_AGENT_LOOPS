#!/bin/sh
# Verify the Zero-Drift context pack is complete.
# Usage: sh scripts/verify-context-pack.sh [root-dir]
set -eu

ROOT="${1:-$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)}"
ROOT="$(CDPATH= cd -- "$ROOT" && pwd)"

REQUIRED="
MISSION.md
AGENTS.md
CLAUDE.md
README.md
docs/specs/current-objective.md
docs/architecture/system-map.md
docs/ai/ai-decision-log.md
docs/handoffs/templates/handoff-template.md
.cursor/rules/00-mission.mdc
.cursor/rules/10-code-governance.mdc
.cursor/rules/30-testing-quality.mdc
.cursor/rules/40-security-privacy.mdc
.claude/agents/system-architect.md
.claude/agents/verifier.md
.claude/skills/verify-change/SKILL.md
"

MISSING=0
echo "[verify] checking context pack at: $ROOT"

for rel in $REQUIRED; do
  if [ ! -f "$ROOT/$rel" ]; then
    echo "[FAIL] missing: $rel"
    MISSING=$((MISSING + 1))
  else
    echo "[ok]   $rel"
  fi
done

# Check area rules exist
for area in frontend backend database infrastructure tests; do
  rel=".cursor/rules/areas/${area}.mdc"
  if [ ! -f "$ROOT/$rel" ]; then
    echo "[FAIL] missing: $rel"
    MISSING=$((MISSING + 1))
  else
    echo "[ok]   $rel"
  fi
done

if [ "$MISSING" -gt 0 ]; then
  echo "[verify] FAILED — $MISSING required file(s) missing"
  exit 1
fi

echo "[verify] PASSED — context pack complete"
exit 0
