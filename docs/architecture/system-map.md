# System Map — Red_Alert2_NAS:Arch_w.AI_AGENT_LOOPS

Date: 2026-06-18  
Status: accepted — **Bootloader + NAS app unified**

## Overview

This repo combines:

1. **Bootloader governance** — context pack, rules, skills, verify/sync/bootstrap scripts
2. **NAS Web Game Container** — production ultra stack + archived experiments

```text
User → AI Architect (Cursor AUTO)
         reads MISSION.md, AGENTS.md, CONTEXT.md
         loads on-demand skills (nas-golden-master-index, verify-change, …)
         │
         ├─ Implementer (container/, scripts/, compose)
         ├─ Verifier (run-deploy-tests.sh, check-ultra-ready.sh)
         └─ Explorer (frozen stable via read-only GitHub/local)
         │
         ▼
Durable memory: docs/handoffs, docs/adr, docs/ai
```

## Repository layout

```text
MISSION.md AGENTS.md CONTEXT.md     # always-load (boot layer)
context-pack/agent/                 # canonical rules/skills (edit here)
.cursor/ .claude/                   # installed via sync-context-pack.sh

compose.yaml compose.ultra*.yaml    # production compose
container/Dockerfile.ultra          # production image
archive/compose/ archive/container/ # archived experiments
scripts/redeploy-ultra.sh           # production deploy (red-zone)
scripts/archive/                    # experiment scripts
scripts/compose-stack.sh            # debug effective -f stack
tests/                              # contract + deploy gate
docs/GOLDEN_MASTER.md               # production reference
```

## Isolation boundary

```text
  FROZEN:  Red_Alert2_NAS:Arch / NAS_Web_Game_Container
  ACTIVE:  This repo — governed NAS rebuild + live MediaServer2 deploy
  LIVE:    MediaServer2 — Cloud_Gaming_Player1/2, RA2_Coturn only
```

## Data flow

```text
context-pack/agent/
    │ sh scripts/sync-context-pack.sh
    ▼
repo root .cursor/ .claude/
    │ NAS_HOST=MediaServer2 sh scripts/redeploy-ultra.sh
    ▼
/volume2/Data/App_Development/ra2-lan-party/project on MediaServer2
```

## Related

- `docs/adr/ADR-0002-context-pack-single-source.md`
- `docs/adr/ADR-0003-bootloader-on-nas-rebuild.md`
- `docs/INFRASTRUCTURE_BOUNDARY.md`
- `docs/specs/nas-container-refactor.md`
