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

## Frozen stable repo (read-only)

| Item | Value |
|------|-------|
| Local | `Red_Alert2_NAS:Arch/synology-ra2-arch/` |
| GitHub | `PeterJFrancoIII/NAS_Web_Game_Container` @ `main` |
| Tag | `golden-master-2026-06-udp-lan` |
| Pointer doc | `docs/architecture/nas-stable-pointer.md` |

**Policy:** GitHub MCP and local reads only. No writes, pushes, or imports of stable production code into this repo. Invoke `nas-repo-isolation` skill before cross-repo work.

## On-demand skills (load when relevant — not always)

| Skill | Trigger |
|-------|---------|
| `verify-change` | Before claiming any task done |
| `verification-before-completion` | Before any success/completion claim |
| `systematic-debugging` | Bug, test failure, unexpected behavior |
| `using-git-worktrees` | Starting isolated feature work |
| `nas-golden-master-index` | NAS architecture, ports, compose, deploy questions |
| `nas-repo-isolation` | Cross-repo work, imports, GitHub access |
| `nas-webrtc-verify` | WebRTC, ICE, coturn, ultra-play.js changes |
| `nas-deploy-ultra` | NAS redeploy/sync tasks (red-zone) |
| `nas-storage-boundary` | Path, mount, sync-to-nas changes |

MCP policy: `docs/specs/mcp-allowlist.md` — **human must approve before enabling P0 MCPs in Cursor settings.**

Full bootloader reference: `docs/reference/AI_System_Architect_Bootloader_Zero-Drift_Build_5.18.26.md` — **on demand only**.

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
