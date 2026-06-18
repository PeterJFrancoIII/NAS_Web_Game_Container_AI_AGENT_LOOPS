# Mission — NAS Web Game Container Refactor

## Objective

Refactor **NAS_Web_Game_Container** (Red Alert 2 Synology Docker stack) — separate production ultra path from archived experiments at the filesystem level.

## Current phase

**Phase 2–3 complete (2026-06-18):** Script and container module archive layout; `compose-stack.sh` debug helper; `run_compose` deduplicated via `compose_file_args()`.

## Repository layout

| Path | Role |
|------|------|
| `compose.yaml`, `compose.ultra*.yaml` | **Production** ultra stack |
| `container/Dockerfile.ultra`, `remote-ultra/` | **Production** runtime image |
| `archive/compose/` | Archived compose overlays |
| `archive/container/` | Archived noVNC/WebRTC image modules |
| `scripts/redeploy-ultra.sh` | **Production** deploy |
| `scripts/archive/` | Historical experiment scripts |
| `scripts/compose-stack.sh` | Print effective `-f` stack |

## Live endpoints

| Player | Remote |
|--------|--------|
| P1 | https://peterjfrancoiii2.synology.me:6081/ |
| P2 | https://peterjfrancoiii2.synology.me:6082/ |

Redeploy after refactor: `NAS_HOST=MediaServer2 sh scripts/redeploy-ultra.sh`

## Success criteria

- [x] Phase 1: `archive/compose/` layout
- [x] Phase 2: `scripts/archive/`, `compose-stack.sh`, `lib.sh` dedup
- [x] Phase 3: `archive/container/` for legacy noVNC modules
- [x] 131 tests pass (deploy gate)
- [ ] Phase 5: CI workflow

## Non-goals

- Frozen `Red_Alert2_NAS:Arch` / `NAS_Web_Game_Container` on GitHub
- Non-RA2 DSM containers on MediaServer2 (`qbittorrent`, `gluetun`, etc.)
