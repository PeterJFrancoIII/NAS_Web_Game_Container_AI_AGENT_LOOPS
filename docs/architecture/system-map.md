# System Map — Zero-Drift Build OS

Date: 2026-06-18  
Status: accepted

## Overview

```text
┌─────────────────────────────────────────────────────────────┐
│                    User / Human Architect                    │
└──────────────────────────┬──────────────────────────────────┘
                           │ objective
                           ▼
┌─────────────────────────────────────────────────────────────┐
│              AI System Architect (Cursor AUTO)               │
│  Reads: MISSION.md, current-objective.md, .cursor/rules     │
└──────────────────────────┬──────────────────────────────────┘
                           │ decomposes
          ┌────────────────┼────────────────┐
          ▼                ▼                ▼
    ┌──────────┐    ┌──────────┐    ┌──────────┐
    │ Planner  │    │ Explorer │    │ Verifier │
    │ (read)   │    │ (read)   │    │ (test)   │
    └────┬─────┘    └──────────┘    └────┬─────┘
         │                                │
         ▼                                ▼
    ┌──────────┐                    ┌──────────┐
    │Implementer│                   │ Security │
    │ 1 writer │                   │ Reviewer │
    │ /worktree│                   └──────────┘
    └────┬─────┘
         │ verify + handoff
         ▼
┌─────────────────────────────────────────────────────────────┐
│              Durable Memory (version-controlled)             │
│  MISSION.md · handoffs · ADRs · ai-decision-log · rules     │
└─────────────────────────────────────────────────────────────┘
```

## Components

| Component | Path | Responsibility |
|---|---|---|
| Mission summary | `MISSION.md` | Always-load objective, criteria, non-goals |
| Mission Control Packet | `docs/specs/current-objective.md` | Full structured spec |
| Cursor rules | `.cursor/rules/` | Scoped IDE governance |
| Claude agents | `.claude/agents/` | Role definitions for subagents |
| Claude skills | `.claude/skills/` | On-demand procedures |
| Bootstrap | `scripts/bootstrap-project.sh` | Install pack into new project |
| Verification | `scripts/verify-context-pack.sh` | Gate for required artifacts |
| Templates | `templates/project-bootstrap/` | Source files for bootstrap |
| Reference | `docs/reference/` | Full bootloader spec (on-demand) |

## Isolation boundary

```text
  Red_Alert2_NAS:Arch (FROZEN)          Zero-Drift_Build_OS (ACTIVE)
  ─────────────────────────            ─────────────────────────────
  NAS_Web_Game_Container               New GitHub repo
  Production RA2/AoE2/SC streaming     Agent governance OS
  No agent governance changes          Bootstraps future projects
```

## Data flow — bootstrap new project

```text
Zero-Drift_Build_OS/templates/project-bootstrap/*
        │
        │  bootstrap-project.sh <target> "<name>"
        ▼
NewProject/
  ├── MISSION.md          (customized)
  ├── AGENTS.md
  ├── .cursor/rules/
  └── docs/specs/current-objective.md (stub)
```

## External systems (optional, per-project)

| System | Role | Default permission |
|---|---|---|
| GitHub | Version control, CI, PR gates | Read/write repo |
| MCP servers | Tool extensions | Read-only allowlist |
| Gateway agent | Triage, CI summary | Issues/comments only |
| Background agents | Test gen, docs, dep PRs | Isolated branch |
