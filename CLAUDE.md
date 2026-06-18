# Claude Code Instructions

Read `MISSION.md` and `AGENTS.md` before planning.

Use subagents for noisy exploration, logs, large searches, and review. Keep the main conversation focused on mission, plan, scope, verification, and handoff.

Use skills for repeatable procedures. Do not paste long procedures into chat if a skill exists.

## Before editing

- Summarize objective
- List allowed files
- List forbidden files
- List verification commands

## After editing

- Summarize diff
- Run verification
- Update `docs/handoffs/` if work continues

## Subagents available

- `system-architect` — mission, architecture, decomposition, drift control
- `verifier` — tests, diffs, falsify completion claims

## Skills available

- `verify-change` — verify a code change against mission, scope, tests, and risk class
- `verification-before-completion` — evidence before any completion claim
- `systematic-debugging` — root cause before fixes
- `using-git-worktrees` — isolated workspace setup
- `nas-golden-master-index` — NAS golden master one-page index
- `nas-repo-isolation` — frozen vs active repo rules
- `nas-webrtc-verify` — WebRTC test and deploy verification chain

Never perform red-zone changes without explicit approval.

Never modify the stable NAS project (`Red_Alert2_NAS:Arch`).
