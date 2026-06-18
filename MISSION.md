# Mission

## User objective

Use the **AI System Architect Bootloader** to govern the **NAS Web Game Container** system rebuild — refactor, deploy, and troubleshoot the ultra streaming stack on MediaServer2 while keeping the frozen golden master read-only.

## Current objective

**Bootloader active + NAS refactor live.** Phases 1–5 complete. Live troubleshooting under bootloader verify/handoff loop.

## Success criteria

- [x] Bootloader context pack installed (`verify-context-pack.sh` passes)
- [x] NAS container refactor phases 1–4 deployed to MediaServer2
- [x] `131` deploy-gate tests pass
- [x] Phase 5: GitHub CI workflow (`.github/workflows/ci.yml`)
- [ ] Handoff/memory updated after each agent slice

## Non-goals

- Modifying frozen `Red_Alert2_NAS:Arch` / `NAS_Web_Game_Container`
- Non-RA2 DSM containers on MediaServer2 (`qbittorrent`, `gluetun`, `kmia-arch-ingest`)
- Rebuilding unrelated application features outside NAS streaming stack

## Constraints

- **Stack:** Docker ultra Arch, Wine, WebRTC UDP, coturn, Synology DS225+
- **Deployment:** `NAS_HOST=MediaServer2 sh scripts/redeploy-ultra.sh` (red-zone — human approval for unplanned deploys)
- **Security:** No secrets in git; TLS on NAS at `/volume2/Data/App_Development/ra2-lan-party/tls`
- **Bootloader:** Edit agent artifacts in `context-pack/agent/`, then `sh scripts/sync-context-pack.sh`

## Source of truth

| Layer | Path |
|-------|------|
| Bootloader spec (on demand) | `docs/reference/AI_System_Architect_Bootloader_Zero-Drift_Build_5.18.26.md` |
| Current slice spec | `docs/specs/current-objective.md` |
| NAS refactor plan | `docs/specs/nas-container-refactor.md` |
| Architecture map | `docs/architecture/system-map.md` |
| Decision log | `docs/adr/`, `docs/ai/ai-decision-log.md` |
| Agent index | `CONTEXT.md`, `AGENTS.md` |
| Production reference | `docs/GOLDEN_MASTER.md`, frozen GitHub `NAS_Web_Game_Container` |

## Live endpoints

| Player | Remote |
|--------|--------|
| P1 | https://peterjfrancoiii2.synology.me:6081/ |
| P2 | https://peterjfrancoiii2.synology.me:6082/ |

## Red-zone areas

Production NAS deploy, DSM Docker changes (non-RA2), TLS/coturn mutation, Wine prefix deletion, auth/secrets/migrations — **explicit human approval required**.
