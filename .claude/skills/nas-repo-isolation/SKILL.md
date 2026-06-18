---
description: Enforce frozen stable NAS vs active AI agent loops repo separation. Use before any cross-repo work, imports, or GitHub writes.
---

# NAS Repo Isolation

## Two-repo model

| Role | Local directory | GitHub | Policy |
|------|-----------------|--------|--------|
| **Frozen stable** | `Red_Alert2_NAS:Arch/synology-ra2-arch/` | `NAS_Web_Game_Container` | **Read-only** reference |
| **Active AI loops** | `Red_Alert2_NAS:Arch_w.AI_AGENT_LOOPS/` | `NAS_Web_Game_Container_AI_AGENT_LOOPS` | Governance OS + future bootstrapped dev |

## Rules

1. **Never write** to `Red_Alert2_NAS:Arch` or push to `NAS_Web_Game_Container` from AI agent sessions unless the human explicitly unfreezes stable.
2. **Never import** stable `container/`, `compose*.yaml`, or production scripts into the AI loops repo — distill facts into skills/docs instead.
3. **NAS application development** happens in a **bootstrapped worktree** (future), not in the AI loops governance repo itself.
4. **GitHub MCP:** use read tools (`get_file_contents`, `get_commit`, `pull_request_read`) against frozen repo; write tools only against AI loops repo or approved dev worktree.
5. **Golden master tag:** `golden-master-2026-06-udp-lan` on stable — treat as immutable baseline.

## Safe read paths (frozen repo)

- `docs/GOLDEN_MASTER.md`, `docs/GOLDEN_MASTER_UDP_LAN.md`
- `docs/NAS_DEPLOY_STATUS.md`, `docs/ULTRA_LIGHT_ARCH_STREAMING.md`
- `scripts/run-webrtc-tests.sh`, `scripts/verify-deployment.sh` (read for recipes, don't copy wholesale)

## Forbidden without approval

- `git push` to `NAS_Web_Game_Container`
- `redeploy-ultra.sh` against production NAS
- Modifying coturn, compose overlays, or Wine prefixes on stable tree
- Merging AI loops governance changes into stable `main`

## When cross-repo context is needed

1. Invoke `nas-golden-master-index` skill first.
2. Fetch specific stable files via GitHub read MCP or local frozen read — **one file at a time**.
3. Record decisions in `docs/ai/ai-decision-log.md` if architecture changes.

## ADR

See `docs/adr/ADR-0001-repository-isolation.md`.
