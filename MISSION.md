# Mission — NAS Web Game Container Refactor

## Objective

Refactor **NAS_Web_Game_Container** (Red Alert 2 Synology Docker stack) in this repo — Docker compose, WebRTC/Ultra streaming, Wine game containers, coturn, and deploy scripts — while preserving the frozen golden master at `Red_Alert2_NAS:Arch` / `synology-ra2-arch`.

## Current phase

**Phase 1 — Compose layout:** Move archived experiment compose overlays to `archive/compose/`, update `scripts/lib.sh` and docs paths, keep the production ultra stack (`compose.yaml` + `compose.https.yaml` + `compose.ultra*.yaml`) at repo root.

## Success criteria

- [ ] `docs/specs/nas-container-refactor.md` phased plan published
- [x] Archived compose files under `archive/compose/`
- [ ] `scripts/lib.sh` resolves archived overlays; ultra production stack unchanged
- [ ] `sh scripts/run-webrtc-tests.sh` and `pytest` pass
- [ ] Changes on `feature/ai-agent-loops` and merged to `main`

## Non-goals

- Modifying frozen `Red_Alert2_NAS:Arch` / `synology-ra2-arch`
- Deploying to production NAS without human approval
- Bootloader / Zero-Drift governance overlay (lives in separate research)

## Source of truth

- Refactor plan: `docs/specs/nas-container-refactor.md`
- Production stack: `docs/GOLDEN_MASTER.md`
- Architecture: `docs/CONSOLIDATED_ARCHITECTURE.md`

## Red-zone areas

Auth, payments, production NAS deploy, secrets, TLS key rotation, coturn credentials, Wine prefix mutations — explicit human approval required.
