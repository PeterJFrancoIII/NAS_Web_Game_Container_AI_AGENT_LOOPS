# NAS Game Container Refactor — Phased Plan

**Repo:** `NAS_Web_Game_Container_AI_AGENT_LOOPS`  
**Frozen reference:** `synology-ra2-arch` (never modify)  
**Production path:** Ultra browser streaming — `compose.yaml` + `compose.https.yaml` + `compose.ultra.yaml` + `compose.ultra-udp.yaml` + `compose.ultra-udp-host.yaml`

## Goals

1. Separate production compose from archived experiments at the filesystem level.
2. Keep `scripts/lib.sh` as the single compose-file resolver for all profiles.
3. Preserve contract tests and deploy scripts; no behavior change for `RA2_COMPOSE_ULTRA=1`.

---

## Phase 1 — Compose archive layout (current)

| Action | Detail |
|--------|--------|
| Move | 10 archived overlays → `archive/compose/` |
| Keep at root | `compose.yaml`, `compose.https.yaml`, `compose.ultra*.yaml`, `compose.player*-network.yaml` |
| Update | `scripts/lib.sh` — `ARCHIVED_COMPOSE_DIR=archive/compose` |
| Update | Docs (`ARCHIVED_EXPERIMENTS.md`, experiment guides, `DEPLOY_SYNOLOGY.md`) |
| Update | Archived-profile scripts (`redeploy-moonlight-poc.sh`, `check-transcode.sh`, etc.) |
| Verify | `sh scripts/run-webrtc-tests.sh`, `python3 -m pytest tests/` |

**Done when:** Tests pass; `run_compose` with `RA2_COMPOSE_ULTRA=1` still uses root ultra files only.

---

## Phase 2 — Script consolidation (planned)

- Group archived deploy scripts under `scripts/archive/` or prefix with `archive-`.
- Deduplicate `redeploy-webrtc*.sh` vs ultra path; document which are historical.
- Add `scripts/compose-stack.sh` helper that prints effective `-f` args for debugging.

---

## Phase 3 — Container module archive (planned)

- Move unused WebRTC/noVNC modules (see `docs/ARCHIVED_EXPERIMENTS.md`) to `archive/container/`.
- Keep `container/Dockerfile.ultra`, `supervisord.ultra.conf`, ultra play stack at runtime paths.
- Update image build context and contract tests.

---

## Phase 4 — Documentation and skills sync (planned)

- Update `nas-golden-master-index` skill with `archive/compose/` paths.
- Sync `context-pack/agent/` distillate after application refactor stabilizes.
- Refresh `docs/CONSOLIDATED_ARCHITECTURE.md` directory map.

---

## Phase 5 — CI and deploy gate (planned)

- GitHub workflow: `run-webrtc-tests.sh` + pytest on push.
- Optional: smoke `docker compose config` for ultra stack only.
- Human-gated NAS deploy remains via `scripts/redeploy-ultra.sh`.

---

## Archived compose inventory

| File | Profile |
|------|---------|
| `compose.webrtc.yaml` | Legacy `remote.html` WebRTC |
| `compose.webrtc-host.yaml` | WebRTC host network |
| `compose.webrtc-udp.yaml` | WebRTC UDP ICE |
| `compose.webrtc-uinput.yaml` | WebRTC + uinput |
| `compose.wolf.yaml` | Moonlight Wolf experiment |
| `compose.sunshine.yaml` | Moonlight Sunshine experiment |
| `compose.moonlight-uinput.yaml` | Moonlight uinput overlay |
| `compose.selkies-experiment.yaml` | Selkies/Webtop |
| `compose.tailscale.yaml` | Tailscale WAN |
| `compose.transcode.yaml` | VA-API transcode overlay |

## Production compose inventory (repo root)

| File | Role |
|------|------|
| `compose.yaml` | Base RA2 Wine + Xvfb services |
| `compose.https.yaml` | TLS mounts (auto when cert present) |
| `compose.player1-network.yaml` | Player 1 bridge (disabled when ultra-udp-host) |
| `compose.player2-network.yaml` | Player 2 macvlan |
| `compose.ultra.yaml` | Ultra Arch browser streaming |
| `compose.ultra-udp.yaml` | Coturn / UDP ICE for ultra |
| `compose.ultra-udp-host.yaml` | Host-network UDP mode (golden master) |
