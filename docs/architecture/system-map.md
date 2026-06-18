# System Map — Red_Alert2_NAS:Arch_w.AI_AGENT_LOOPS

Date: 2026-06-18  
Status: accepted (refactored)

## Overview

Governance OS with **single-source context pack**. Agent artifacts live in `context-pack/agent/`; repo root `.cursor`/`.claude` are installed copies.

```text
User → AI Architect (Cursor AUTO)
         reads MISSION.md, CONTEXT.md, scoped rules
         invokes on-demand skills
         │
         ├─ Explorer (read stable via GitHub MCP)
         ├─ Implementer (bootstrapped NAS dev worktree)
         └─ Verifier (verify-context-pack, nas-webrtc-verify)
         │
         ▼
Durable memory: docs/handoffs, docs/ai, docs/adr
```

## Components

| Component | Path | Responsibility |
|-----------|------|----------------|
| Context pack (canonical) | `context-pack/agent/` | Rules, agents, skills — **edit here** |
| Bootstrap stubs | `context-pack/bootstrap/` | New-project doc templates |
| Sync | `scripts/sync-context-pack.sh` | Install agent pack to repo root |
| Bootstrap | `scripts/bootstrap-project.sh` | New governed project |
| Verify | `scripts/verify-context-pack.sh` | Artifact gate |
| Agent index | `CONTEXT.md` | Fast navigation |
| Live mission | `MISSION.md`, `docs/specs/` | Current truth |
| Governance docs | `docs/adr/`, `docs/handoffs/`, `docs/ai/` | Decisions and session memory |

## Isolation boundary

```text
  FROZEN: Red_Alert2_NAS:Arch / NAS_Web_Game_Container
  ACTIVE: Red_Alert2_NAS:Arch_w.AI_AGENT_LOOPS / NAS_Web_Game_Container_AI_AGENT_LOOPS
  FUTURE: bootstrapped NAS dev worktree (application code)
```

## Data flow

```text
context-pack/agent/
    │ sync-context-pack.sh
    ▼
repo root .cursor/ .claude/
    │ bootstrap-project.sh
    ▼
NAS dev worktree (new directory)
```

## Related

- `docs/adr/ADR-0002-context-pack-single-source.md`
- `docs/architecture/nas-stable-pointer.md`
- `docs/specs/mcp-allowlist.md`
