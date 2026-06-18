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

**Verification:** No files under `Red_Alert2_NAS:Arch` modified.

---

## 2026-06-18 — Rename from Zero-Drift_Build_OS to NAS AI agent loops naming

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
