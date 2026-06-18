---
description: Verify a code change against mission, scope, tests, and risk class. Use before claiming a task is done.
---

# Verify change

1. Read MISSION.md and AGENTS.md.
2. Inspect `git diff --stat` and `git diff`.
3. Check whether changed files match declared scope.
4. Identify risk class: green, yellow, red.
5. Run relevant commands from AGENTS.md.
6. Run `sh scripts/verify-context-pack.sh` if governance files changed.
7. Summarize evidence.
8. State done/blocker clearly.

## Risk class quick reference

- **Green:** docs, tests, isolated scripts
- **Yellow:** API, data shape, dependencies, shared components
- **Red:** auth, payments, permissions, secrets, prod infra, customer data, migrations — requires human approval

## Output format

```text
SCOPE_OK: yes | no
RISK_CLASS: green | yellow | red
CHECKS: [command] -> pass | fail
EVIDENCE: ...
VERDICT: done | blocker
```
