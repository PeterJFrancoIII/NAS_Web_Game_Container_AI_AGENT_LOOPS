---
description: NAS storage path boundaries for ra2-lan-party project layout. Use before sync, mount, log, or cache path changes.
---

# NAS Storage Boundary

All NAS project-specific files must stay under:

```text
/volume2/Data/App_Development/ra2-lan-party/
```

Do **not** create, mount, sync, log, cache, or document project-specific files directly under `/volume2/Data/App_Development/` or other NAS locations.

## Standard subdirectories

| Path | Purpose |
|------|---------|
| `.../ra2-lan-party/project` | Compose, container, scripts (git sync target) |
| `.../ra2-lan-party/assets` | RA2 game files (copyrighted — not in git) |
| `.../ra2-lan-party/prefixes` | Wine prefixes per player |
| `.../ra2-lan-party/logs` | Runtime logs |
| `.../ra2-lan-party/tls` | HTTPS certificates |
| `.../ra2-lan-party/backups` | Golden master backups |

## Mac development paths

| Path | Role |
|------|------|
| `Red_Alert2_NAS:Arch/synology-ra2-arch/` | Frozen stable (read-only) |
| `Red_Alert2_NAS:Arch_w.AI_AGENT_LOOPS/` | AI governance OS |
| Bootstrapped NAS dev worktree | Active application development |

## sync-to-nas.sh behavior

- Source: local project root (dev worktree)
- Target: `$NAS_TARGET` default `.../ra2-lan-party/project`
- Excludes: `.git`, `.env`, `.DS_Store`, `__pycache__`
- Uses `COPYFILE_DISABLE=1` tar over SSH

## Rules

1. Never sync governance-only AI loops repo to NAS production path.
2. Never write game assets or prefixes into git-tracked paths without explicit approval.
3. Shared cross-project tooling may live under `/volume2/Data/App_Development/` only when truly not RA2-specific.
4. Document path changes in ADR if deployment topology changes.

## Verify

Before sync changes, confirm target:

```bash
echo "NAS_HOST=${NAS_HOST:-MediaServer2Local}"
echo "NAS_TARGET=${NAS_TARGET:-/volume2/Data/App_Development/ra2-lan-party/project}"
```

## Related

- `nas-deploy-ultra` — deploy chain uses this boundary
- `nas-repo-isolation` — Mac-side repo separation
