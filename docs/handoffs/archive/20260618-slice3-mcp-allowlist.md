# Handoff: Slice 3 MCP allowlist and NAS area rules

Date: 2026-06-18  
Agent: Cursor AUTO  
Branch: feature/ai-agent-loops  
Current objective: Slice 3 complete — MCP ingestion plan finished

## Completed

- `docs/specs/mcp-allowlist.md` — P0/P1 servers, tool matrix, approval gates
- `.cursor/rules/areas/nas-infrastructure.mdc` — compose, coturn, deploy scripts
- `.cursor/rules/areas/nas-game-stability.mdc` — CPU pinning, Wine stability
- `.claude/skills/nas-deploy-ultra/SKILL.md` — redeploy chain (red-zone)
- `.claude/skills/nas-storage-boundary/SKILL.md` — ra2-lan-party path rules
- All mirrored to `templates/project-bootstrap/`
- `AGENTS.md` and `CLAUDE.md` updated

## Human action required

1. Review `docs/specs/mcp-allowlist.md`
2. Enable P0 MCPs in Cursor Settings: `user-github`, `user-context7`
3. Optionally enable `user-firecrawl` (search/scrape only)
4. Record approval in `docs/ai/ai-decision-log.md`

## Verification run

```bash
sh scripts/verify-context-pack.sh
```

## MCP ingestion plan status

| Slice | Status |
|-------|--------|
| 1 NAS distillate | Done |
| 2 Verification skills | Done |
| 3 MCP allowlist + area rules | Done |

## Next smallest action

Bootstrap a NAS dev worktree and begin governed application development, or unfreeze a specific stable change with explicit human approval.
