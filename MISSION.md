# Mission

## User objective

Implement and maintain **Red_Alert2_NAS:Arch_w.AI_AGENT_LOOPS** — the AI agent loops variant of the NAS Web Game Container project, with a portable bootloader and repository context pack for mission-aligned, zero-drift development.

## Current objective

Operate the v2.0 context pack (Section 11 of the bootloader spec), bootstrap tooling, and verification CI on branch `feature/ai-agent-loops`.

## Success criteria

- [x] New directory fully separated from `Red_Alert2_NAS:Arch` stable system
- [x] Directory named `Red_Alert2_NAS:Arch_w.AI_AGENT_LOOPS`
- [x] GitHub repo `NAS_Web_Game_Container_AI_AGENT_LOOPS` created and pushed
- [x] Mission Control Packet at `docs/specs/current-objective.md`
- [x] Cursor rules, Claude agents, and verify-change skill installed
- [x] `bootstrap-project.sh` copies context pack into new projects
- [x] `verify-context-pack.sh` validates required artifacts
- [x] First handoff written after bootstrap verification passes

## Non-goals

- Modifying or importing production code from the frozen `NAS_Web_Game_Container` golden master
- Running production NAS deployments from this repo without explicit approval
- Building application features unrelated to agent governance
- Installing untrusted MCP servers or skills without review

## Constraints

- Stack: Markdown, shell scripts, GitHub Actions, Cursor/Claude config files
- Deployment: Local bootstrap into target project directories
- Security/privacy: Least-privilege tool policy; red-zone approval for auth/secrets/prod
- Full separation from `Red_Alert2_NAS:Arch` at all times

## Source of truth

- Spec: `docs/specs/current-objective.md`
- Architecture map: `docs/architecture/system-map.md`
- Decision log: `docs/ai/ai-decision-log.md`
- Full reference: `docs/reference/AI_System_Architect_Bootloader_Zero-Drift_Build_5.18.26.md`

## Red-zone areas

Changes to auth, payments, permissions, production infrastructure, customer data, secrets, and database migrations require explicit human approval.
