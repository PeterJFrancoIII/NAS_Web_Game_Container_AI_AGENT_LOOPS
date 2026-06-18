# ADR-0003: Bootloader on NAS rebuild repo

Date: 2026-06-18  
Status: accepted

## Context

The NAS container refactor (phases 1–4) was completed without the Bootloader repo layer after an interim revert (`3327cd6`). The user confirmed the **AI System Architect Bootloader** governs this build.

## Decision

Re-install Bootloader Section 11 artifacts on `NAS_Web_Game_Container_AI_AGENT_LOOPS`:

- `context-pack/agent/` as canonical source for `.cursor` / `.claude`
- `AGENTS.md`, `CONTEXT.md`, `CLAUDE.md`, governance rules, skills
- `scripts/sync-context-pack.sh`, `scripts/verify-context-pack.sh`
- Live NAS application code remains in this repo (not a separate worktree)

## Consequences

- Agents must read `MISSION.md` + `docs/specs/current-objective.md` before slices
- Maintainer edits agent rules/skills in `context-pack/agent/`, then sync
- NAS deploy remains red-zone per `nas-production-isolation` rule
- Frozen stable repo policy unchanged (`ADR-0001`)

## References

- `docs/reference/AI_System_Architect_Bootloader_Zero-Drift_Build_5.18.26.md`
- `docs/adr/ADR-0002-context-pack-single-source.md`
