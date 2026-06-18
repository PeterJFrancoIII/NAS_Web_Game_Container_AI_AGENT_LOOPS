---
description: Verify WebRTC, ICE, and NAS deploy test gates. Use before/after any WebRTC, coturn, or ultra-play.js change in a NAS dev worktree.
---

# NAS WebRTC Verify

**Risk class:** Yellow locally, **Red** for production NAS deploy without human approval.

Invoke `nas-repo-isolation` first. Run commands in the **NAS dev worktree** (bootstrapped from stable), not in the AI loops governance repo.

## Test chain (in order)

### 1. WebRTC unit tests (fastest — run first)

```bash
sh scripts/run-webrtc-tests.sh
```

Runs:
- Python: `test_webrtc_ice`, `test_gateway_webrtc_ice`, `test_ultra_play_ice_utils`, `test_remote_webrtc_contract`, `test_turn_allocate_probe`
- Node (if available): `tests/ultra_play_ice_utils.test.mjs`

**Pass:** exit 0, `[webrtc-tests] ok`

### 2. Full pre-deploy gate

```bash
sh scripts/run-deploy-tests.sh
```

Runs `run-webrtc-tests.sh` then `run-tests.sh` (full suite including AoE II session prep).

**Pass:** exit 0, `[deploy-tests] ok`

### 3. TURN / ICE probes (NAS or Mac)

```bash
# On NAS or via SSH
sh scripts/probe-webrtc-turn.sh

# From Mac with VPN (remote path)
sh scripts/probe-webrtc-turn-remote.sh
```

**Pass:** TURN allocate succeeds; no connection refused on 62011.

### 4. Redeploy (RED — human approval required)

```bash
RA2_COMPOSE_ULTRA=1 RA2_COMPOSE_ULTRA_UDP=1 RA2_COMPOSE_ULTRA_UDP_HOST=1 \
  sh scripts/redeploy-ultra.sh
```

`redeploy-ultra.sh` runs deploy tests internally before applying compose.

### 5. Post-deploy verification (RED — NAS only)

```bash
sh scripts/verify-deployment.sh
```

Checks container status, player serials, gateway health, WebRTC processes.

## Browser acceptance (manual)

1. Open `https://192.168.0.193:6081/` (LAN IP, not DDNS on same subnet)
2. Hard refresh: Cmd+Shift+R
3. Start a game session
4. Transport panel must show:
   - `udp video: WebRTC verified/`
   - Rising `webrtc rtp:` packet counts

**Remote:** `https://peterjfrancoiii2.synology.me:6081/` with `relay/udp` selected pair.

## Red-zone gates

| Action | Approval |
|--------|----------|
| Edit `coturn/turnserver.conf` host network | Required |
| Change UDP port range 62001–62020 | Required |
| `compose.ultra-udp-host.yaml` host network mode | Required |
| Production `redeploy-ultra.sh` | Required |
| Local unit tests in dev worktree | Green/yellow |

## Key files (when tests fail)

| File | Check |
|------|-------|
| `container/webrtc-media.py` | Signaling bridge |
| `container/webrtc-media-helper.c` | GStreamer encode |
| `container/remote-ultra/webrtc-ice-utils.js` | ICE URL logic |
| `container/remote-ultra/ultra-play.js` | Browser client |
| `coturn/turnserver.conf` | Relay range, creds |
| `container/start-webrtc.sh` | Helper recompile |

## Combine with other skills

- `verification-before-completion` — before claiming tests pass
- `systematic-debugging` — when failures span gateway → webrtc → coturn → browser
- `nas-golden-master-index` — ports and compose flags
