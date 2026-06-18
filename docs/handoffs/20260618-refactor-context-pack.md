# Handoff: full refactor — context-pack single source

Date: 2026-06-18  
Branch: feature/ai-agent-loops  
Current objective: Refactor governance repo to eliminate duplicate template tree

## Completed

- Introduced `context-pack/agent/` (canonical) and `context-pack/bootstrap/` (stubs)
- Added `scripts/lib/context-pack.sh`, `scripts/sync-context-pack.sh`
- Rewrote `bootstrap-project.sh` and `verify-context-pack.sh`
- Removed `templates/project-bootstrap/` (~50 duplicate files)
- Added `CONTEXT.md`, `ADR-0002`, updated README, system-map, MISSION, AGENTS
- Archived slice handoffs to `docs/handoffs/archive/`

## Maintainer workflow

```bash
# Edit rules/skills
vim context-pack/agent/.cursor/rules/...
sh scripts/sync-context-pack.sh
sh scripts/verify-context-pack.sh
```

## Verification

```bash
sh scripts/verify-context-pack.sh   # PASSED
```

## Next action

Bootstrap NAS dev worktree: `sh scripts/bootstrap-project.sh "<path>" "NAS Dev"`
