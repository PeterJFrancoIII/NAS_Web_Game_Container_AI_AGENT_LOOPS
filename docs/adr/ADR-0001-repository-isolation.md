# ADR-0001: Repository isolation from NAS stable system

Date: 2026-06-18  
Status: accepted  
Decision owner: human + AI System Architect

## Context

The Red Alert 2 NAS WebRTC streaming stack (`Red_Alert2_NAS:Arch` / `NAS_Web_Game_Container`) reached golden-master stability. The user wants to implement the AI System Architect Bootloader with agent loops without risking that system.

## Decision

1. Create a new top-level directory: `Red_Alert2_NAS:Arch_w.AI_AGENT_LOOPS`
2. Initialize a separate git repository: `NAS_Web_Game_Container_AI_AGENT_LOOPS`
3. Use branch `feature/ai-agent-loops` for active implementation
4. Never import or modify NAS production code from the frozen golden master

## Alternatives considered

- **Branch in NAS repo:** Faster setup but violates separation requirement
- **Monorepo with packages/:** Over-engineered for current scope
- **Worktree of NAS repo:** Shares git history and remote — rejected

## Consequences

- Clean agent governance experimentation
- Two repos to maintain: frozen NAS + active AI agent loops
- Naming clearly signals relationship and separation

## Verification

- `git remote -v` points to `NAS_Web_Game_Container_AI_AGENT_LOOPS`, not `NAS_Web_Game_Container`
- `AGENTS.md` separation rule documented
