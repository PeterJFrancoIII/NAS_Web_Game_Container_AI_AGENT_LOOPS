#!/bin/sh
# Verify context-pack artifacts exist at repo or target root.
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

AREA_RULES="frontend backend database infrastructure tests nas-infrastructure nas-game-stability"
SKILLS="verify-change verification-before-completion systematic-debugging using-git-worktrees nas-golden-master-index nas-repo-isolation nas-webrtc-verify nas-deploy-ultra nas-storage-boundary"

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

for area in $AREA_RULES; do
  rel=".cursor/rules/areas/${area}.mdc"
  if [ ! -f "$ROOT/$rel" ]; then
    echo "[FAIL] missing: $rel"
    MISSING=$((MISSING + 1))
  else
    echo "[ok]   $rel"
  fi
done

for skill in $SKILLS; do
  rel=".claude/skills/${skill}/SKILL.md"
  if [ ! -f "$ROOT/$rel" ]; then
    echo "[FAIL] missing: $rel"
    MISSING=$((MISSING + 1))
  else
    echo "[ok]   $rel"
  fi
done

# Governance OS repo also maintains canonical pack
GOV_ROOT="$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)"
if [ "$ROOT" = "$GOV_ROOT" ] && [ ! -d "$GOV_ROOT/context-pack/agent/.cursor" ]; then
  echo "[FAIL] missing: context-pack/agent/.cursor"
  MISSING=$((MISSING + 1))
else
  if [ "$ROOT" = "$GOV_ROOT" ]; then
    echo "[ok]   context-pack/agent (canonical source)"
  fi
fi

if [ "$MISSING" -gt 0 ]; then
  echo "[verify] FAILED — $MISSING required file(s) missing"
  exit 1
fi

echo "[verify] PASSED — context pack complete"
exit 0
