# Mission

## User objective

Implement and maintain the **Zero-Drift Build OS** — a portable bootloader and repository context pack that lets AI System Architects start new projects with mission alignment, drift prevention, verification gates, and durable file-based memory.

## Current objective

Install the v2.0 context pack (Section 11 of the bootloader spec), bootstrap tooling, and verification CI in this isolated repository on branch `feature/zero-drift-bootloader-os`.

## Success criteria

- [x] New directory fully separated from `Red_Alert2_NAS:Arch` stable system
- [x] Mission Control Packet at `docs/specs/current-objective.md`
- [x] Cursor rules, Claude agents, and verify-change skill installed
- [x] `bootstrap-project.sh` copies context pack into new projects
- [x] `verify-context-pack.sh` validates required artifacts
- [ ] GitHub repo created and pushed on dedicated branch
- [ ] First handoff written after bootstrap verification passes

## Non-goals

- Modifying or importing code from `NAS_Web_Game_Container` / `synology-ra2-arch`
- Running production NAS deployments from this repo
- Building application features unrelated to agent governance
- Installing untrusted MCP servers or skills without review

## Constraints

- Stack: Markdown, shell scripts, GitHub Actions, Cursor/Claude config files
- Deployment: Local bootstrap into target project directories
- Security/privacy: Least-privilege tool policy; red-zone approval for auth/secrets/prod
- Timeline: Initial install complete in this session

## Source of truth

- Spec: `docs/specs/current-objective.md`
- Architecture map: `docs/architecture/system-map.md`
- Decision log: `docs/ai/ai-decision-log.md`
- Full reference: `docs/reference/AI_System_Architect_Bootloader_Zero-Drift_Build_5.18.26.md`

## Red-zone areas

Changes to auth, payments, permissions, production infrastructure, customer data, secrets, and database migrations require explicit human approval.
