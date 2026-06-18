# MCP Allowlist — NAS AI Agent Loops

Date: 2026-06-18  
Status: proposed — **requires human approval before enabling in Cursor settings**

This document defines which MCP servers and tools agents may use for NAS-related work. Aligns with bootloader Section 13 (least privilege) and ADR-0001 (repo isolation).

---

## Policy summary

| Tier | Meaning |
|------|---------|
| **P0** | Enable by default after human approval |
| **P1** | Enable when needed; read-only subset only |
| **P2** | Optional fallback |
| **Skip** | Not applicable to NAS domain |
| **Red** | Blocked unless explicit per-task human approval |

**Default posture:** read-only first. No production mutation via MCP.

---

## Server allowlist

### P0 — Enable after approval

#### user-github

| Tool | Permission | Use for NAS |
|------|------------|-------------|
| `get_file_contents` | Read | Fetch stable `GOLDEN_MASTER.md`, specific source files |
| `get_commit` | Read | Verify golden master SHA |
| `list_commits` | Read | History on frozen vs active repos |
| `list_branches` | Read | Branch state |
| `list_tags` | Read | `golden-master-2026-06-udp-lan` tag |
| `get_tag` | Read | Tag metadata |
| `pull_request_read` | Read | PR triage |
| `list_pull_requests` | Read | PR list |
| `issue_read` | Read | Issue triage |
| `list_issues` | Read | Issue list |
| `search_code` | Read | Find symbols in frozen repo |
| `search_repositories` | Read | Repo discovery |

| Tool | Permission | Policy |
|------|------------|--------|
| `issue_write` | Write | **Yellow** — comments/labels only with approval |
| `add_issue_comment` | Write | **Yellow** — triage comments only |
| `pull_request_review_write` | Write | **Yellow** — review comments only |
| `create_or_update_file` | Write | **Red** — AI loops repo only, not `NAS_Web_Game_Container` |
| `push_files` | Write | **Red** — blocked for frozen stable repo |
| `merge_pull_request` | Write | **Red** — human only |
| `delete_file` | Write | **Red** — blocked |
| `create_repository` | Write | **Red** — blocked |
| `create_branch` | Write | **Yellow** — active repo only with approval |
| `fork_repository` | Write | **Red** — blocked |

**Repo scope:**
- **Read freely:** `PeterJFrancoIII/NAS_Web_Game_Container` (frozen)
- **Write (if approved):** `PeterJFrancoIII/NAS_Web_Game_Container_AI_AGENT_LOOPS` only

#### user-context7

| Tool | Permission | Use for NAS |
|------|------------|-------------|
| `resolve-library-id` | Read | Docker Compose, GStreamer, pytest, Playwright |
| `query-docs` | Read | Current API/docs for WebRTC stack dependencies |

---

### P1 — Enable when needed (read-only subset)

#### user-firecrawl

| Tool | Permission | Use for NAS |
|------|------------|-------------|
| `firecrawl_search` | Read | Synology DSM, coturn, WebRTC troubleshooting |
| `firecrawl_scrape` | Read | Single-page doc fetch |

| Tool | Policy |
|------|--------|
| `firecrawl_crawl` | **Red** — broad crawl, defer |
| `firecrawl_agent` | **Red** — autonomous web agent |
| `firecrawl_interact` | **Red** — interactive browser |
| `firecrawl_extract` | **Yellow** — approval required |
| `firecrawl_monitor_*` | **Skip** — not needed initially |

#### user-brave-search (P2 alternative)

Use **one** of Firecrawl or Brave for web search. Prefer Firecrawl if already configured.

| Tool | Permission |
|------|------------|
| Search/summarize tools | Read only |

---

### P2 — Optional

#### cursor-app-control

| Tool | Use |
|------|-----|
| Workspace/tab management | Open stable reference in Glass, switch to NAS dev worktree |

No NAS deploy side effects.

---

### Skip / Defer

| Server | Reason |
|--------|--------|
| **user-postgres** | NAS stack has no Postgres |
| **user-fastio** | Agent file-share infra; optional later for human handoff delivery only |

---

## Approval matrix

| Action class | MCP allowed? | Human approval |
|--------------|--------------|----------------|
| Read stable golden master doc | GitHub `get_file_contents` | No |
| Read library docs | Context7 | No |
| Web search troubleshooting | Firecrawl search/scrape | No |
| Comment on issue/PR | GitHub write (comments) | Yes |
| Push to AI loops repo | GitHub `create_or_update_file` | Yes |
| Push to frozen stable repo | Any write | **Blocked** |
| Production NAS deploy | Shell/MCP | **Red — never via MCP** |
| Enable new MCP server | Cursor settings | **Yes — review this doc first** |

---

## Enabling in Cursor (human step)

1. Review this allowlist.
2. Open Cursor Settings → MCP.
3. Enable **P0** servers: `user-github`, `user-context7`.
4. Optionally enable **P1** `user-firecrawl` (read tools only).
5. Do **not** enable Postgres or Fast.io unless scope changes.
6. Record approval in `docs/ai/ai-decision-log.md`.

---

## Agent invocation rules

1. Invoke `nas-repo-isolation` before any GitHub MCP use.
2. Fetch **one file at a time** from frozen repo — never bulk-import.
3. Prefer skills (`nas-golden-master-index`) over repeated MCP fetches.
4. Log red/yellow MCP tool use in handoff when used.

---

## Related

- `docs/adr/ADR-0001-repository-isolation.md`
- `.claude/skills/nas-repo-isolation/SKILL.md`
- Bootloader Section 13: `docs/reference/AI_System_Architect_Bootloader_Zero-Drift_Build_5.18.26.md`
