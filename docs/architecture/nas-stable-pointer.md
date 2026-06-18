# NAS Stable Pointer

Read-only reference map for agents working in the AI agent loops repo. **Do not copy stable production code here** — use skills and targeted file reads instead.

Date: 2026-06-18  
Status: accepted

---

## Frozen stable system

| Field | Value |
|-------|-------|
| **Purpose** | Production RA2 / AoE II / StarCraft browser streaming on Synology |
| **Golden master tag** | `golden-master-2026-06-udp-lan` |
| **Local path** | `/Users/computer/Desktop/App Development/Red_Alert2_NAS:Arch/synology-ra2-arch/` |
| **NAS runtime path** | `/volume2/Data/App_Development/ra2-lan-party/project` |
| **GitHub** | https://github.com/PeterJFrancoIII/NAS_Web_Game_Container |
| **Default branch** | `main` |
| **Policy** | **Read-only** for all AI agents unless human explicitly unfreezes |

## Active AI agent loops system

| Field | Value |
|-------|-------|
| **Purpose** | Agent governance OS, context pack, bootstrap tooling |
| **Local path** | `/Users/computer/Desktop/App Development/Red_Alert2_NAS:Arch_w.AI_AGENT_LOOPS/` |
| **GitHub** | https://github.com/PeterJFrancoIII/NAS_Web_Game_Container_AI_AGENT_LOOPS |
| **Branches** | `main`, `feature/ai-agent-loops` |
| **Policy** | Write allowed per mission scope |

---

## Authoritative stable docs (load on demand)

| Document | Path in stable repo | When to read |
|----------|---------------------|--------------|
| Golden master | `docs/GOLDEN_MASTER.md` | Deploy, restore, architecture |
| UDP LAN lock | `docs/GOLDEN_MASTER_UDP_LAN.md` | WebRTC, ports, ICE, coturn |
| Deploy status | `docs/NAS_DEPLOY_STATUS.md` | Current production state |
| Ultra streaming | `docs/ULTRA_LIGHT_ARCH_STREAMING.md` | Transport design |
| Archived experiments | `docs/ARCHIVED_EXPERIMENTS.md` | noVNC, Moonlight — not production |

**Skill shortcut:** invoke `.claude/skills/nas-golden-master-index/` before loading any of the above.

---

## GitHub read-only access (MCP)

Preferred tools against `NAS_Web_Game_Container`:

- `get_file_contents` — single file fetch
- `get_commit` / `list_commits` — verify golden master SHA
- `pull_request_read` / `issue_read` — triage only

**Blocked by default:** `push_files`, `merge_pull_request`, `delete_file`, `create_repository`

---

## Local read-only access

```bash
# Example: read one stable doc without importing
cat "/Users/computer/Desktop/App Development/Red_Alert2_NAS:Arch/synology-ra2-arch/docs/GOLDEN_MASTER.md"
```

Never `git commit` inside `Red_Alert2_NAS:Arch` from AI loops sessions.

---

## Future NAS development worktree

Application code changes will live in a **separate bootstrapped directory** (not this governance repo), created via:

```bash
sh scripts/bootstrap-project.sh "<target-dir>" "NAS Dev Worktree"
```

That worktree inherits skills including `nas-golden-master-index` and `nas-repo-isolation`.

---

## Related artifacts

- ADR: `docs/adr/ADR-0001-repository-isolation.md`
- Skill: `.claude/skills/nas-repo-isolation/SKILL.md`
- Skill: `.claude/skills/nas-golden-master-index/SKILL.md`
