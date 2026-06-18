# Agent Operating Rules — {{PROJECT_NAME}}

## Prime directive

Build the user's current objective with maximum verified progress and minimum drift.

## Required loop

1. Read MISSION.md.
2. Read docs/specs/current-objective.md.
3. State allowed and forbidden files.
4. Plan before editing.
5. Implement one small slice.
6. Run verification.
7. Update handoff/memory.

## Commands

- Install: [command]
- Dev: [command]
- Test: [command]
- Typecheck: [command]
- Lint: [command]
- Build: [command]

## Risk classes

Green: docs, tests, isolated UI, local-only scripts.
Yellow: API behavior, data shape, dependencies, shared components.
Red: auth, payments, permissions, secrets, production infrastructure, customer data, migrations.

Red changes require explicit human approval before edits and before merge.

## Communication

Use terse, evidence-first updates. Preserve exact code, paths, commands, and errors.
