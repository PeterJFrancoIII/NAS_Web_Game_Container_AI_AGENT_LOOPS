---
description: One-page NAS golden master index — compose stack, ports, archive layout, verification. Use before loading full GOLDEN_MASTER.md.
---

# NAS Golden Master Index

**On-demand only.** Full detail: `docs/GOLDEN_MASTER.md`, `docs/GOLDEN_MASTER_UDP_LAN.md`.

## Active repo (this build)

| Item | Value |
|------|-------|
| **GitHub** | `NAS_Web_Game_Container_AI_AGENT_LOOPS` @ `feature/ai-agent-loops` |
| **NAS path** | `/volume2/Data/App_Development/ra2-lan-party/project` |
| **Host** | MediaServer2 · DS225+ · J4125 · i965 VA-API |

## Compose stack (production — repo root)

```text
compose.yaml
  + compose.https.yaml
  + compose.ultra.yaml
  + compose.ultra-udp.yaml
  + compose.ultra-udp-host.yaml
```

Debug: `RA2_COMPOSE_ULTRA=1 RA2_COMPOSE_ULTRA_UDP=1 RA2_COMPOSE_ULTRA_UDP_HOST=1 sh scripts/compose-stack.sh`

**Archived overlays:** `archive/compose/` · **Archived noVNC modules:** `archive/container/`

**Flags:** `RA2_COMPOSE_ULTRA=1`, `RA2_COMPOSE_ULTRA_UDP=1`, `RA2_COMPOSE_ULTRA_UDP_HOST=1`

**Image:** `ra2-lan-party:ultra` · **Containers:** `Cloud_Gaming_Player1`, `Cloud_Gaming_Player2`, `RA2_Coturn`

## Play URLs

| Player | Remote (DDNS) |
|--------|---------------|
| 1 | `https://peterjfrancoiii2.synology.me:6081/` |
| 2 | `https://peterjfrancoiii2.synology.me:6082/` |

## CPU layout (do not change)

| Core | Assignment |
|------|------------|
| 0 | Game P1 |
| 1 | Game P2 |
| 2–3 | Stream stack (`ULTRA_STREAM_CPUSET=2,3`) |

## Verification commands

```bash
sh scripts/verify-context-pack.sh          # bootloader gate
sh scripts/run-deploy-tests.sh             # NAS pre-deploy gate
RA2_COMPOSE_ULTRA=1 sh scripts/check-ultra-ready.sh   # on NAS
NAS_HOST=MediaServer2 sh scripts/redeploy-ultra.sh      # red-zone deploy
sh scripts/archive/probe-webrtc-turn-remote.sh        # TURN probe (VPN)
```

## Key production files

| Path | Role |
|------|------|
| `container/Dockerfile.ultra` | Production image |
| `container/supervisord.ultra-udp.conf` | UDP ultra supervisord (mounted) |
| `container/ra2-stream-gateway.py` | HTTPS + WSS gateway |
| `container/remote-ultra/` | Browser client |
| `container/webrtc-media.py` | WebRTC signaling (UDP path) |
| `scripts/lib.sh` | Compose resolver (`archived_compose_file`) |

## Frozen stable reference (read-only)

`Red_Alert2_NAS:Arch` / `NAS_Web_Game_Container` @ `golden-master-2026-06-udp-lan`
