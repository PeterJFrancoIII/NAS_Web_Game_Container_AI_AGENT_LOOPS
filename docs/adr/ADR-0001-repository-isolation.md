# ADR-0001: Repository isolation from NAS stable system

Date: 2026-06-18  
Status: accepted  
Decision owner: human + AI System Architect

## Context

The Red Alert 2 NAS WebRTC streaming stack (`Red_Alert2_NAS:Arch` / `NAS_Web_Game_Container`) reached golden-master stability. The user wants to implement the Zero-Drift Build OS bootloader without risking that system.

## Decision

1. Create a new top-level directory: `Zero-Drift_Build_OS`
2. Initialize a separate git repository with its own GitHub remote
3. Use branch `feature/zero-drift-bootloader-os` for active implementation
4. Never import or modify NAS production code from this repo

## Alternatives considered

- **Branch in NAS repo:** Faster setup but violates separation requirement
- **Monorepo with packages/:** Over-engineered for current scope
- **Worktree of NAS repo:** Shares git history and remote — rejected

## Consequences

- Clean agent governance experimentation
- Duplicate README/setup overhead (acceptable)
- NAS backup remains immutable reference at `main` on `NAS_Web_Game_Container`

## Verification

- `git remote -v` in Zero-Drift_Build_OS does not point to NAS_Web_Game_Container
- `AGENTS.md` separation rule documented
