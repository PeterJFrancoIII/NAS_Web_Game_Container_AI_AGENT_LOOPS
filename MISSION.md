# Mission

## User objective

Maintain **Red_Alert2_NAS:Arch_w.AI_AGENT_LOOPS** as the governed AI agent loops OS for NAS Web Game Container development — with a refactored single-source context pack, NAS distillate skills, and MCP allowlist.

## Current objective

Operate the refactored `context-pack/` architecture. All rule and skill edits flow through `context-pack/agent/` → `sync-context-pack.sh`.

## Success criteria

- [x] Single source of truth at `context-pack/` (ADR-0002)
- [x] `templates/project-bootstrap/` duplication removed
- [x] `sync-context-pack.sh`, `bootstrap-project.sh`, `verify-context-pack.sh` operational
- [x] MCP ingestion slices 1–3 complete
- [ ] NAS dev worktree bootstrapped for application development
- [ ] P0 MCPs enabled in Cursor after human review

## Non-goals

- Modifying frozen `NAS_Web_Game_Container` golden master
- Importing stable production code into this governance repo
- Always-loading full bootloader or golden master docs

## Source of truth

- Agent index: `CONTEXT.md`
- Spec: `docs/specs/current-objective.md`
- Architecture: `docs/architecture/system-map.md`
- Canonical pack: `context-pack/`
- MCP policy: `docs/specs/mcp-allowlist.md`

## Red-zone areas

Auth, payments, permissions, production NAS deploy, secrets, migrations — explicit human approval required.
