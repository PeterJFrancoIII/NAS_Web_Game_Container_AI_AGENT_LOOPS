# Infrastructure Boundary — MediaServer2 & Production NAS

Date: 2026-06-18  
Status: **accepted — non-negotiable**

This document defines what agents and developers may **not** touch on the live NAS while refactoring in `NAS_Web_Game_Container_AI_AGENT_LOOPS`.

---

## MediaServer2 access

| Item | Value |
|------|-------|
| Hostname | **MediaServer2** |
| DDNS | **peterjfrancoiii2.synology.me** |
| Mac SSH alias (DDNS) | `MediaServer2` → `peterjfrancoiii2.synology.me` |
| Mac SSH alias (LAN) | `MediaServer2Local` → `192.168.0.193` |
| LAN IP | `192.168.0.193` |
| SSH shell port (project docs) | **23921** |
| DSM / user endpoint | `peterjfrancoiii2.synology.me:5001` |

```bash
# Remote (DDNS)
ssh MediaServer2

# LAN
ssh MediaServer2Local
```

Verify `~/.ssh/config` for the exact port on alias `MediaServer2`. Project deploy scripts default to `NAS_HOST=MediaServer2` or `MediaServer2Local`.

---

## Frozen production — DO NOT TOUCH

The following are part of the **old stable system** and are **perfectly working**. No agent, script, or refactor in this repo may modify them without **explicit human approval**:

| Category | Examples | Policy |
|----------|----------|--------|
| **Running DSM Docker containers** | `Cloud_Gaming_Player1`, `Cloud_Gaming_Player2`, `RA2_Coturn`, qBit/Gluetun stack, any other Container Manager workload | **Read-only** — no `docker stop`, `restart`, `rm`, `compose up`, image rebuild, or recreate |
| **Frozen local repo** | `Red_Alert2_NAS:Arch/synology-ra2-arch` | Never write |
| **Frozen GitHub** | `NAS_Web_Game_Container` @ golden master | Never push |
| **Production NAS paths** | `/volume2/Data/App_Development/ra2-lan-party/` runtime tree on live NAS | No `sync-to-nas.sh`, `redeploy-ultra.sh`, or prefix/asset mutation unless human explicitly approves a maintenance window |
| **TLS, coturn creds, router forwards** | Live certs, `turnserver.conf` on NAS, port forwards | Red-zone — approval required |

### What this repo IS for

- **Local refactor** of compose layout, scripts, container code, tests, and docs
- **Live ultra deploy** to MediaServer2 RA2 stack via `NAS_HOST=MediaServer2 sh scripts/redeploy-ultra.sh` (human-approved 2026-06-18)
- **Read-only** inspection of non-RA2 containers — no state changes

### What agents must never do by default

```bash
# FORBIDDEN without explicit human approval:
NAS_HOST=MediaServer2 sh scripts/redeploy-ultra.sh
NAS_HOST=MediaServer2 sh scripts/sync-to-nas.sh
ssh MediaServer2 'sudo docker compose ...'
ssh MediaServer2 'sudo docker restart ...'
ssh MediaServer2 'sudo docker rm ...'
```

---

## Refactor vs production deploy

| Layer | Location | Touch? |
|-------|----------|--------|
| Refactor workspace | This repo on Mac | Yes — edit freely |
| Stable reference | `Red_Alert2_NAS:Arch` | Read-only |
| Live NAS containers | MediaServer2 DSM | **No** |
| Future isolated stack | TBD (new path/ports/project) | Only after ADR + approval |

---

## Related

- `MISSION.md` — non-goals and red-zone
- `docs/GOLDEN_MASTER.md` — production stack definition (reference only)
- `docs/NAS_DS225_QUICK_REFERENCE.md` — host identity and network
- `.cursor/rules/nas-production-isolation.mdc` — IDE enforcement
