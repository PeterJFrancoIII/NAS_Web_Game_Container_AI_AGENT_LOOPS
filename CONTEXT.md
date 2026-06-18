# Agent Context Index

Fast navigation for AI sessions. **Always-load:** `MISSION.md`, `AGENTS.md`. Everything else is on-demand.

## Start here

| Need | Read |
|------|------|
| Current objective | `MISSION.md` → `docs/specs/current-objective.md` |
| Operating rules | `AGENTS.md` |
| Claude-specific | `CLAUDE.md` |
| Frozen vs active NAS repos | `docs/architecture/nas-stable-pointer.md` |
| System architecture | `docs/architecture/system-map.md` |
| MCP tool policy | `docs/specs/mcp-allowlist.md` |

## Edit agent artifacts (maintainers)

| Task | Path | Command after edit |
|------|------|------------------|
| Cursor rules | `context-pack/agent/.cursor/rules/` | `sh scripts/sync-context-pack.sh` |
| Claude skills | `context-pack/agent/.claude/skills/` | `sh scripts/sync-context-pack.sh` |
| Claude agents | `context-pack/agent/.claude/agents/` | `sh scripts/sync-context-pack.sh` |
| Bootstrap stubs | `context-pack/bootstrap/` | — |
| Live mission | `MISSION.md`, `docs/specs/current-objective.md` | — |

## On-demand skills

| Skill | When |
|-------|------|
| `nas-golden-master-index` | NAS ports, compose, golden master |
| `nas-repo-isolation` | Cross-repo / GitHub access |
| `nas-webrtc-verify` | WebRTC test chain |
| `nas-deploy-ultra` | Deploy (red-zone) |
| `nas-storage-boundary` | NAS paths / sync |
| `verify-change` | Before claiming done |
| `verification-before-completion` | Evidence before success claims |
| `systematic-debugging` | Multi-component failures |
| `using-git-worktrees` | Isolated feature work |

## Reference (never always-load)

- Full bootloader: `docs/reference/AI_System_Architect_Bootloader_Zero-Drift_Build_5.18.26.md`
- Stable golden master: read via GitHub MCP from `NAS_Web_Game_Container` — see `nas-golden-master-index`

## Repo map

```text
context-pack/agent/          # canonical agent artifacts (edit here, then sync)
MISSION.md AGENTS.md CONTEXT.md   # always-load boot layer
compose.yaml container/        # production NAS ultra stack
archive/                     # archived compose + container modules
scripts/redeploy-ultra.sh    # production deploy (red-zone)
docs/specs/current-objective.md  # current bootloader slice
.cursor/ .claude/              # installed copies (sync from context-pack)
```
