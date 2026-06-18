# AI Decision Log

Chronological record of significant AI/human architecture and governance decisions.

---

## 2026-06-18 — Isolate AI agent loops repo from NAS stable system

**Decision:** Create `Red_Alert2_NAS:Arch_w.AI_AGENT_LOOPS` as a new directory and `NAS_Web_Game_Container_AI_AGENT_LOOPS` as a new GitHub repository. Do not branch from or modify `NAS_Web_Game_Container`.

**Rationale:** The RA2 NAS golden master achieved stability. Agent governance work must not risk production streaming code.

**Alternatives considered:**
- Add context pack to existing NAS repo — rejected (pollution risk)
- Git worktree inside NAS repo — rejected (shared history)

**Consequences:**
- Future governed NAS development uses the AI agent loops repo
- Two repos: frozen NAS + active AI agent loops

**Verification:** `sh scripts/verify-context-pack.sh` passes after sync.

---

## 2026-06-18 — Re-enable Bootloader on NAS rebuild repo (ADR-0003)

**Decision:** Restore Bootloader Section 11 repo layer (`context-pack/`, `AGENTS.md`, governance rules/skills) on top of the completed NAS container refactor (phases 1–4).

**Rationale:** User confirmed this build is governed by `AI_System_Architect_Bootloader_Zero-Drift_Build_5.18.26.md`. NAS app code and bootloader governance coexist in `NAS_Web_Game_Container_AI_AGENT_LOOPS`.

**Consequences:**
- Agents follow MISSION → current-objective → scope → verify → handoff loop
- Maintainer edits `context-pack/agent/`, then `sync-context-pack.sh`
- NAS deploy remains red-zone unless user approves in session

**Verification:** `verify-context-pack.sh` + `run-deploy-tests.sh` pass.

**Decision:** Rename local directory to `Red_Alert2_NAS:Arch_w.AI_AGENT_LOOPS` and GitHub repo to `NAS_Web_Game_Container_AI_AGENT_LOOPS`.

**Rationale:** User requested naming that reflects the NAS project lineage while preserving full separation from the stable system.

**Verification:** `git remote -v` shows `NAS_Web_Game_Container_AI_AGENT_LOOPS`.

---

## 2026-06-18 — Copy-based bootstrap over git submodule

**Decision:** Use `bootstrap-project.sh` to copy templates into target directories.

**Rationale:** Simpler for non-git projects; no submodule coupling; each project owns its context pack.

**Alternatives considered:**
- Git submodule — rejected (complexity for AI agents)
- npm/pip package — deferred (no runtime dependency needed yet)

**Consequences:** Bootstrapped projects may drift from OS template; periodic re-sync manual or scripted.

**Verification:** Integration test in bootstrap script temp dir.

---

## 2026-06-18 — Slice 1: NAS distillate skills (MCP ingestion plan)

**Decision:** Add `nas-golden-master-index` and `nas-repo-isolation` skills plus `docs/architecture/nas-stable-pointer.md`. Distill stable golden master facts into on-demand skills instead of importing stable code or always-loading `GOLDEN_MASTER.md`.

**Rationale:** Reduces context bloat and rediscovery cost while preserving ADR-0001 isolation.

**Files added:**
- `.claude/skills/nas-golden-master-index/SKILL.md`
- `.claude/skills/nas-repo-isolation/SKILL.md`
- `templates/project-bootstrap/.claude/skills/` (mirrored)
- `docs/architecture/nas-stable-pointer.md`

**Verification:** `sh scripts/verify-context-pack.sh` passes; stable repo not modified.

---

## 2026-06-18 — Slice 2: Verification and debug skills

**Decision:** Add `nas-webrtc-verify` skill; copy `verification-before-completion`, `systematic-debugging`, `using-git-worktrees` from global skills into repo and bootstrap template; extend `30-testing-quality.mdc` with NAS test globs.

**Rationale:** Encode stable test gates so agents stop rediscovering `run-webrtc-tests.sh` → `run-deploy-tests.sh` → `verify-deployment.sh` chain.

**Verification:** `verify-context-pack.sh` passes; stable repo not modified.

---

## 2026-06-18 — Slice 3: MCP allowlist and NAS area rules

**Decision:** Add `docs/specs/mcp-allowlist.md`, NAS area rules (`nas-infrastructure`, `nas-game-stability`), and `nas-deploy-ultra` / `nas-storage-boundary` skills. P0 MCP enablement deferred to human Cursor settings approval.

**Rationale:** Wire read-only tool boundary; promote stable invariants into scoped rules without always-load bloat.

**Verification:** `verify-context-pack.sh` passes; stable repo not modified.

---

## 2026-06-18 — Full refactor: context-pack single source of truth

**Decision:** Replace duplicated `templates/project-bootstrap/` with `context-pack/agent/` + `context-pack/bootstrap/`. Add `sync-context-pack.sh`.

**Rationale:** Eliminate ~90 mirrored files and drift between root and template copies.

**Verification:** ADR-0002; bootstrap and verify tests pass.

---
