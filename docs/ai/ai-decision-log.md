# AI Decision Log

Chronological record of significant AI/human architecture and governance decisions.

---

## 2026-06-18 — Isolate Zero-Drift Build OS from NAS stable system

**Decision:** Create `Zero-Drift_Build_OS` as a new directory and new GitHub repository. Do not branch from or modify `NAS_Web_Game_Container`.

**Rationale:** The RA2 NAS golden master achieved stability. Agent governance work must not risk production streaming code.

**Alternatives considered:**
- Add context pack to existing NAS repo — rejected (pollution risk)
- Git worktree inside NAS repo — rejected (shared history)

**Consequences:**
- Future projects bootstrap from this OS
- Two repos to maintain: frozen NAS + active governance OS

**Verification:** No files under `Red_Alert2_NAS:Arch` modified in this session.

---

## 2026-06-18 — Copy-based bootstrap over git submodule

**Decision:** Use `bootstrap-project.sh` to copy templates into target directories.

**Rationale:** Simpler for non-git projects; no submodule coupling; each project owns its context pack.

**Alternatives considered:**
- Git submodule — rejected (complexity for AI agents)
- npm/pip package — deferred (no runtime dependency needed yet)

**Consequences:** Bootstrapped projects may drift from OS template; periodic re-sync manual or scripted.

**Verification:** Integration test in bootstrap script temp dir.
