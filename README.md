# Red Alert 2 NAS — AI Agent Loops

Governed AI agent context pack for the NAS Web Game Container project line.

| | |
|---|---|
| **Local** | `Red_Alert2_NAS:Arch_w.AI_AGENT_LOOPS` |
| **GitHub** | [NAS_Web_Game_Container_AI_AGENT_LOOPS](https://github.com/PeterJFrancoIII/NAS_Web_Game_Container_AI_AGENT_LOOPS) |
| **Frozen stable** | `Red_Alert2_NAS:Arch` / [NAS_Web_Game_Container](https://github.com/PeterJFrancoIII/NAS_Web_Game_Container) |

## Quick start

```bash
# Verify this repo
sh scripts/verify-context-pack.sh

# After editing rules/skills in context-pack/agent/
sh scripts/sync-context-pack.sh

# Bootstrap a new governed NAS dev project
sh scripts/bootstrap-project.sh "/path/to/nas-dev" "NAS Dev"
```

**Agent navigation:** [`CONTEXT.md`](CONTEXT.md) · [`MISSION.md`](MISSION.md) · [`AGENTS.md`](AGENTS.md)

## Architecture (refactored)

```text
context-pack/              # SINGLE SOURCE OF TRUTH — edit rules/skills here
  agent/                   #   .cursor, .claude, verify script
  bootstrap/               #   stubs for new projects ({{PROJECT_NAME}})
scripts/
  sync-context-pack.sh     # agent/ → repo root
  bootstrap-project.sh     # agent/ + bootstrap/ → new project
  verify-context-pack.sh
docs/                      # live governance memory (mission, ADRs, handoffs)
MISSION.md                 # always-load mission (repo-specific)
.cursor/ .claude/          # installed copies (do not edit — sync from context-pack)
```

## Maintainer workflow

1. Edit `context-pack/agent/.cursor/rules/` or `.claude/skills/`
2. `sh scripts/sync-context-pack.sh`
3. `sh scripts/verify-context-pack.sh`
4. Commit **both** `context-pack/` and synced root `.cursor`/`.claude`

## Branches

| Branch | Purpose |
|--------|---------|
| `main` | Stable release |
| `feature/ai-agent-loops` | Active development |

## Reference

- Bootloader spec: [`docs/reference/AI_System_Architect_Bootloader_Zero-Drift_Build_5.18.26.md`](docs/reference/AI_System_Architect_Bootloader_Zero-Drift_Build_5.18.26.md)
- Context pack docs: [`context-pack/README.md`](context-pack/README.md)
- ADR: [`docs/adr/ADR-0002-context-pack-single-source.md`](docs/adr/ADR-0002-context-pack-single-source.md)
