# Handoff: NAS container refactor Phase 1

Date: 2026-06-18  
Agent: Cursor (forked subagent)  
Branch/worktree: `feature/ai-agent-loops` → `main`  
Current objective: Phase 2 script consolidation per `docs/specs/nas-container-refactor.md`

## Completed

- Updated `MISSION.md` for NAS application refactor (not bootloader-only governance).
- Wrote phased plan: `docs/specs/nas-container-refactor.md`.
- **Phase 1:** Moved 10 archived compose overlays to `archive/compose/`.
- Updated `scripts/lib.sh` with `ARCHIVED_COMPOSE_DIR` and `archived_compose_file()` helper.
- Updated docs (`ARCHIVED_EXPERIMENTS.md`, experiment guides, `DEPLOY_SYNOLOGY.md`, `README.md`).
- Updated archived-profile scripts (`redeploy-moonlight-poc.sh`, `check-transcode.sh`, etc.).
- Updated contract tests for new paths.
- Production ultra stack unchanged at repo root.

## Changed files

| Area | Paths |
|------|-------|
| Mission/spec | `MISSION.md`, `docs/specs/nas-container-refactor.md` |
| Archive | `archive/compose/*` (10 compose files + README) |
| Scripts | `scripts/lib.sh`, `redeploy-moonlight-poc.sh`, `check-*.sh`, `admin-rebuild-check.sh`, `compare-selkies-webrtc.sh` |
| Docs | `docs/ARCHIVED_EXPERIMENTS.md`, `CONSOLIDATED_ARCHITECTURE.md`, `MOONLIGHT_EXPERIMENT.md`, `SELKIES_EXPERIMENT.md`, `TAILSCALE.md`, `DEPLOY_SYNOLOGY.md`, `README.md` |
| Tests | `tests/test_project_contracts.py`, `tests/test_checkpoint_scripts.py` |

## Verification run

```text
sh scripts/run-webrtc-tests.sh  → 36/38 passed (2 DNS env failures)
python3 -m pytest tests/       → 126 passed, 3 skipped, 2 failed (same DNS)
```

Failures: `test_expand_private_candidate_includes_lan_and_public` and `test_rewrite_sdp_duplicates_lan_candidates_in_offer` — `peterjfrancoiii2.synology.me` resolves to `100.11.158.236` (Tailscale) instead of expected `108.2.161.76`. Not caused by compose archive refactor.

## Failing checks or blockers

- None for Phase 1 scope. DNS-dependent ICE tests need mock/stub or offline hostname in Phase 2.

## Decisions made

- Archived compose dir: `archive/compose/` (not `scripts/archive/`).
- `lib.sh` remains single resolver; archived paths via `archived_compose_file()`.
- Frozen repo `synology-ra2-arch` not touched.

## Risks

- NAS deploy scripts synced from this repo must include `archive/compose/` subtree.
- `redeploy-moonlight-poc.sh` sources `lib.sh` for `archived_compose_file` — direct `docker compose` one-liners in docs use full paths.

## Next smallest action

Phase 2: move archived deploy scripts under `scripts/archive/` and add `scripts/compose-stack.sh` debug helper.

## Context needed by next agent

- Active repo: `NAS_Web_Game_Container_AI_AGENT_LOOPS` / local `Red_Alert2_NAS:Arch_w.AI_AGENT_LOOPS`
- Frozen: `synology-ra2-arch` — never modify
- Production deploy: `RA2_COMPOSE_ULTRA=1` + `scripts/redeploy-ultra.sh`
- Governance overlay still at `context-pack/` — sync via `scripts/sync-context-pack.sh` when NAS skills change
