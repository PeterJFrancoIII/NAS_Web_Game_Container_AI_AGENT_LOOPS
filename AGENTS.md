# Agent Operating Rules

## Prime directive

Build the user's current objective with maximum verified progress and minimum drift.

## Required loop

1. Read `MISSION.md`.
2. Read `docs/specs/current-objective.md`.
3. State allowed and forbidden files.
4. Plan before editing.
5. Implement one small slice.
6. Run verification.
7. Update handoff/memory.

## Commands

- Verify context pack: `sh scripts/verify-context-pack.sh`
- Bootstrap new project: `sh scripts/bootstrap-project.sh <target-dir> "<project-name>"`
- Check git status: `git status`
- Diff stat: `git diff --stat`

## Risk classes

**Green:** docs, tests, isolated UI, local-only scripts, context pack templates.

**Yellow:** API behavior, data shape, dependencies, shared components, bootstrap script behavior.

**Red:** auth, payments, permissions, secrets, production infrastructure, customer data, migrations.

Red changes require explicit human approval before edits and before merge.

## Separation rule

This repository (`Red_Alert2_NAS:Arch_w.AI_AGENT_LOOPS` / `NAS_Web_Game_Container_AI_AGENT_LOOPS`) must never modify the frozen stable system (`Red_Alert2_NAS:Arch` / `NAS_Web_Game_Container`). All new governed development uses this AI agent loops repo or projects bootstrapped from it.

## Communication

Use terse, evidence-first updates. Preserve exact code, paths, commands, and errors.

Use Caveman-style compression for routine inter-agent summaries:

```text
FINDING: ...
EVIDENCE: path:line
RISK: ...
FIX: ...
VERIFY: command
```

Do not compress user requirements, security requirements, API contracts, migrations, exact errors, code, commands, file paths, or acceptance criteria.

## Architect response format

```text
MISSION: one sentence
STATE: known / unknown / blocked
PLAN: next smallest step
SCOPE: allowed / forbidden files
VERIFY: exact commands
RISKS: likely drift or failure
HANDOFF: durable memory to write
```
