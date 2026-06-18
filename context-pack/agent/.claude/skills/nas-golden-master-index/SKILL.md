---
description: One-page NAS golden master index — compose stack, ports, CPU layout, verification commands. Use for any NAS architecture or deploy question before loading full GOLDEN_MASTER.md.
---

# NAS Golden Master Index

**On-demand only.** For full detail, read stable repo `docs/GOLDEN_MASTER.md` and `docs/GOLDEN_MASTER_UDP_LAN.md` via GitHub read or local frozen copy — do not always-load into context.

## Frozen stable reference

| Item | Value |
|------|-------|
| **Tag** | `golden-master-2026-06-udp-lan` |
| **GitHub** | `PeterJFrancoIII/NAS_Web_Game_Container` @ `main` |
| **Local frozen** | `Red_Alert2_NAS:Arch/synology-ra2-arch/` |
| **NAS path** | `/volume2/Data/App_Development/ra2-lan-party/project` |
| **Host** | Synology DS225+ · Intel J4125 · i965 VA-API |

## Compose stack (locked)

```text
compose.yaml
  + compose.https.yaml
  + compose.ultra.yaml
  + compose.ultra-udp.yaml
  + compose.ultra-udp-host.yaml
```

**Flags (`.env`):** `RA2_COMPOSE_ULTRA=1`, `RA2_COMPOSE_ULTRA_UDP=1`, `RA2_COMPOSE_ULTRA_UDP_HOST=1`

**Image:** `ra2-lan-party:ultra` · **Containers:** `Cloud_Gaming_Player1`, `Cloud_Gaming_Player2`, `RA2_Coturn`

## Play URLs

| Player | LAN | Remote (DDNS) |
|--------|-----|---------------|
| 1 | `https://192.168.0.193:6081/` | `https://peterjfrancoiii2.synology.me:6081/` |
| 2 | `https://192.168.0.193:6082/` | `https://peterjfrancoiii2.synology.me:6082/` |

Router: forward **TCP 6081 + 6082**. WebRTC: **UDP+TCP 62001–62020**, TURN **62011**, relay **62012–62020**. TURNS **5349** gated off (`WEBRTC_TURNS_ENABLED=0`) until valid cert.

## CPU layout (do not change)

| Core | Assignment |
|------|------------|
| 0 | Game P1 (`PLAYER_ID=1`) |
| 1 | Game P2 (`PLAYER_ID=2`) |
| 2–3 | Stream stack (`ULTRA_STREAM_CPUSET=2,3`) |

Watchdog re-applies `taskset` on `gamemd.exe` — Wine children escape initial pin.

## Client versions (locked at golden master)

- `SETTINGS_VERSION=66`
- `webrtc-ice-utils.js?v=102`, `ultra-play.js?v=102`
- Games: `ra2`, `aoe2`, `starcraft` via `config/games.json`

## Verification commands (stable repo)

```bash
# Pre-deploy unit tests (runs inside redeploy-ultra.sh)
sh scripts/run-webrtc-tests.sh

# Full redeploy (NAS or Mac with NAS_HOST)
RA2_COMPOSE_ULTRA=1 RA2_COMPOSE_ULTRA_UDP=1 RA2_COMPOSE_ULTRA_UDP_HOST=1 \
  sh scripts/redeploy-ultra.sh

# TURN health
sh scripts/probe-webrtc-turn.sh
sh scripts/probe-webrtc-turn-remote.sh   # from Mac with VPN

# Post-deploy
sh scripts/verify-deployment.sh
```

**LAN success signal:** Transport shows `udp video: WebRTC verified/` with rising `webrtc rtp:` counts.

## Key UDP path files (read on demand)

| Path | Role |
|------|------|
| `container/webrtc-media.py` | WebRTC signaling bridge |
| `container/webrtc-media-helper.c` | GStreamer webrtcbin H.264 |
| `container/remote-ultra/ultra-play.js` | Browser client |
| `container/remote-ultra/webrtc-ice-utils.js` | ICE helpers |
| `coturn/turnserver.conf` | TURN creds, relay range |
| `container/ra2-stream-gateway.py` | HTTPS + WSS gateway |

## Not in production hot path

noVNC, x11vnc, Moonlight, Selkies — see `docs/ARCHIVED_EXPERIMENTS.md`.
