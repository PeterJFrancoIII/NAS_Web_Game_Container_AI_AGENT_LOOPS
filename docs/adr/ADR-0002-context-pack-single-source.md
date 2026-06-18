# ADR-0002: Context-pack single source of truth

Date: 2026-06-18  
Status: accepted  
Decision owner: human + AI System Architect

## Context

The governance repo duplicated every agent artifact in both the repo root and `templates/project-bootstrap/` (~90 mirrored files). Edits risked drift between copies.

## Decision

1. Introduce `context-pack/` as the **single canonical source** for agent artifacts.
2. `context-pack/agent/` holds `.cursor/`, `.claude/`, and verify script — installed to repo root via `sync-context-pack.sh`.
3. `context-pack/bootstrap/` holds stub docs with `{{PROJECT_NAME}}` for new projects.
4. Remove `templates/project-bootstrap/` entirely.
5. Root `AGENTS.md`, `MISSION.md`, `CLAUDE.md`, `README.md` remain **live governance-repo docs** (not overwritten by sync).

## Alternatives considered

- **Git submodule for pack** — rejected (agent complexity)
- **Symlinks from root to context-pack** — rejected (Cursor may not follow reliably)
- **Keep dual trees** — rejected (drift)

## Consequences

- All rule/skill edits go to `context-pack/agent/` then `sh scripts/sync-context-pack.sh`
- Bootstrap uses `context-pack/` directly
- Smaller repo, one edit path

## Verification

```bash
sh scripts/sync-context-pack.sh
sh scripts/verify-context-pack.sh
sh scripts/bootstrap-project.sh /tmp/nas-bootstrap-test "Test"
```
