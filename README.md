# Red Alert 2 NAS — AI Agent Loops

AI System Architect bootloader and governed context pack for the NAS Web Game Container project line.

**Local directory:** `Red_Alert2_NAS:Arch_w.AI_AGENT_LOOPS`  
**GitHub:** [NAS_Web_Game_Container_AI_AGENT_LOOPS](https://github.com/PeterJFrancoIII/NAS_Web_Game_Container_AI_AGENT_LOOPS)

**Source spec:** [`docs/reference/AI_System_Architect_Bootloader_Zero-Drift_Build_5.18.26.md`](docs/reference/AI_System_Architect_Bootloader_Zero-Drift_Build_5.18.26.md)

## What this is

This repository is the **AI agent loops** variant of the NAS project — fully separated from the stable golden master. It installs durable agent memory, drift prevention, and verification gates for governed development.

| Stable sibling (frozen) | This repo (active) |
|---|---|
| `Red_Alert2_NAS:Arch` / `NAS_Web_Game_Container` | `Red_Alert2_NAS:Arch_w.AI_AGENT_LOOPS` / `NAS_Web_Game_Container_AI_AGENT_LOOPS` |
| Production golden master | AI agent loops + governance OS |

## Quick start

### Boot a new project

```bash
sh scripts/bootstrap-project.sh "/path/to/new-project" "My Project Name"
cd "/path/to/new-project"
sh scripts/verify-context-pack.sh
```

### Verify this repo

```bash
sh scripts/verify-context-pack.sh
```

### Agent session protocol (Cursor AUTO)

1. Read `MISSION.md` and `docs/specs/current-objective.md`
2. Read relevant `.cursor/rules/*.mdc`
3. Plan with allowed/forbidden files and verification commands
4. Implement one slice
5. Run verification
6. Update `docs/handoffs/` before context reset

## Repository layout

```text
MISSION.md                 # Always-load mission summary
AGENTS.md                  # Cross-agent operating rules
CLAUDE.md                  # Claude Code instructions
.cursor/rules/             # Cursor IDE scoped rules
.claude/agents/            # Role-specific subagent definitions
.claude/skills/            # Repeatable procedures
docs/specs/                # Mission Control Packet
docs/architecture/         # System map
docs/adr/                  # Architecture decision records
docs/handoffs/             # Session transition memory
docs/ai/                   # AI decision audit log
scripts/                   # Bootstrap and verification
templates/                 # Files copied into new projects
```

## Branches

| Branch | Purpose |
|---|---|
| `main` | Stable AI agent loops release |
| `feature/ai-agent-loops` | Active implementation of v2.0 context pack |

## License

Internal tooling. Adapt per project.
