# Archived Compose Overlays

Experiment and legacy streaming profiles moved here in Phase 1 of the NAS container refactor.

Production deploy uses only the root-level `compose.yaml`, `compose.https.yaml`, and `compose.ultra*.yaml` files. See `docs/ARCHIVED_EXPERIMENTS.md` and `docs/specs/nas-container-refactor.md`.

`scripts/lib.sh` resolves paths under this directory when the corresponding `RA2_COMPOSE_*` flag is set.
