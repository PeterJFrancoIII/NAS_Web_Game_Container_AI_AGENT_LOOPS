# NAS Game Container Refactor — Phased Plan

**Repo:** `NAS_Web_Game_Container_AI_AGENT_LOOPS`  
**Frozen reference:** `synology-ra2-arch` (never modify)  
**Live NAS:** MediaServer2 — RA2 stack deployed for live troubleshooting  
**Production path:** Ultra browser streaming — `compose.yaml` + `compose.https.yaml` + `compose.ultra.yaml` + `compose.ultra-udp.yaml` + `compose.ultra-udp-host.yaml`

## Goals

1. Separate production compose from archived experiments at the filesystem level.
2. Keep `scripts/lib.sh` as the single compose-file resolver for all profiles.
3. Preserve contract tests and deploy scripts; no behavior change for `RA2_COMPOSE_ULTRA=1`.

---

## Phase 1 — Compose archive layout ✅

| Action | Detail |
|--------|--------|
| Move | 10 archived overlays → `archive/compose/` |
| Keep at root | `compose.yaml`, `compose.https.yaml`, `compose.ultra*.yaml`, `compose.player*-network.yaml` |
| Update | `scripts/lib.sh` — `ARCHIVED_COMPOSE_DIR=archive/compose` |

---

## Phase 2 — Script consolidation ✅

| Action | Detail |
|--------|--------|
| Move | 17 experiment scripts → `scripts/archive/` |
| Add | `scripts/compose-stack.sh` — print effective `-f` args |
| Dedup | `run_compose()` now builds from `compose_file_args()` |
| Fix | `compose_file_args()` uses `*_overlay_enabled()` env flags (not `extra` param) |
| Docs | `scripts/archive/README.md` |

---

## Phase 3 — Container module archive ✅

| Action | Detail |
|--------|--------|
| Move | Legacy noVNC/WebRTC modules → `archive/container/` |
| Keep in `container/` | `Dockerfile.ultra`, `supervisord.ultra*.conf`, `remote-ultra/`, `webrtc-media.py` (UDP ultra) |
| Update | `compose.yaml` dockerfile → `archive/container/Dockerfile`; volume mounts → `archive/container/…` |
| Docs | `archive/container/README.md` |

---

## Phase 4 — Documentation sync ✅

- `docs/ARCHIVED_EXPERIMENTS.md` — archive paths
- `docs/CONSOLIDATED_ARCHITECTURE.md` — directory map
- `MISSION.md` — phase status

---

## Phase 5 — CI and deploy gate (planned)

- GitHub workflow: `run-webrtc-tests.sh` + pytest on push
- Optional: `RA2_COMPOSE_ULTRA=1 sh scripts/compose-stack.sh` smoke in CI

---

## Debug commands

```bash
# Effective production stack
RA2_COMPOSE_ULTRA=1 RA2_COMPOSE_ULTRA_UDP=1 RA2_COMPOSE_ULTRA_UDP_HOST=1 sh scripts/compose-stack.sh

# Deploy
NAS_HOST=MediaServer2 sh scripts/redeploy-ultra.sh
```

## Production compose inventory (repo root)

| File | Role |
|------|------|
| `compose.yaml` | Base RA2 Wine + Xvfb services |
| `compose.https.yaml` | TLS mounts |
| `compose.player1-network.yaml` | Player 1 bridge |
| `compose.player2-network.yaml` | Player 2 macvlan |
| `compose.ultra.yaml` | Ultra Arch browser streaming |
| `compose.ultra-udp.yaml` | Coturn / UDP ICE |
| `compose.ultra-udp-host.yaml` | Host-network UDP (golden master) |
