# Context Pack — Single Source of Truth

All agent artifacts are edited here, then installed to the repo root or bootstrapped projects.

## Layout

```text
context-pack/
  agent/                 # Installed on every governed project
    .cursor/rules/
    .claude/agents/
    .claude/skills/
    scripts/verify-context-pack.sh
  bootstrap/             # Stubs for new projects ({{PROJECT_NAME}} placeholders)
    MISSION.md
    AGENTS.md
    CLAUDE.md
    README.md
    docs/...
```

## Workflow

### Edit rules or skills

1. Change files under `context-pack/agent/`
2. Run `sh scripts/sync-context-pack.sh` (updates repo root `.cursor` / `.claude`)
3. Run `sh scripts/verify-context-pack.sh`

### Bootstrap new project

```bash
sh scripts/bootstrap-project.sh "/path/to/project" "Project Name"
```

### Do not edit duplicates

- Do **not** maintain `templates/project-bootstrap/` (removed)
- Root `.cursor` and `.claude` are **installed copies** — edit `context-pack/agent/` instead
