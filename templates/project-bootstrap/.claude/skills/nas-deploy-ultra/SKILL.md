---
description: NAS ultra deploy procedure — validate, test, sync, redeploy. RED-ZONE for production NAS without human approval.
---

# NAS Deploy Ultra

**Risk class: RED** for production NAS. Run only with explicit human approval.

Invoke `nas-repo-isolation` and `nas-webrtc-verify` before deploy.

## Pre-deploy gate (required)

```bash
sh scripts/validate-env.sh          # if present
sh scripts/run-deploy-tests.sh      # WebRTC + full unit suite
```

Must exit 0 before any sync or compose recreate.

## Mac → NAS deploy chain

```bash
# Default host: MediaServer2Local
# Default target: /volume2/Data/App_Development/ra2-lan-party/project

RA2_COMPOSE_ULTRA=1 RA2_COMPOSE_ULTRA_UDP=1 RA2_COMPOSE_ULTRA_UDP_HOST=1 \
  sh scripts/redeploy-ultra.sh
```

**What redeploy-ultra.sh does:**
1. Runs `run-deploy-tests.sh`
2. `sync-to-nas.sh` — tar project to NAS (excludes `.git`, `.env`, assets)
3. SSH: build/recreate `ra2-player-1`, `ra2-player-2`, `ra2-coturn`
4. Runs `coturn/update_coturn_ip.sh`
5. Verifies stream-helper, gateway, Xvfb inside containers

## Environment overrides

| Var | Default | Purpose |
|-----|---------|---------|
| `NAS_HOST` | `MediaServer2Local` | SSH target |
| `NAS_TARGET` | `.../ra2-lan-party/project` | Remote project path |
| `RA2_ULTRA_BUILD` | `1` | Build image on NAS |
| `RA2_ULTRA_SERVICE` | `ra2-player-1 ra2-player-2` | Services to recreate |

## Post-deploy verification (NAS)

```bash
sh scripts/verify-deployment.sh
sh scripts/probe-webrtc-turn.sh
```

## Browser check

- LAN: `https://192.168.0.193:6081/` — hard refresh Cmd+Shift+R
- Success: `udp video: WebRTC verified/` + rising `webrtc rtp:`

## Never without approval

- Deploy to production NAS from unverified branch
- Skip `run-deploy-tests.sh`
- Sync to wrong `NAS_TARGET` path
- Modify frozen `Red_Alert2_NAS:Arch` tree instead of dev worktree

## Related

- `nas-storage-boundary` — path constraints
- `nas-golden-master-index` — compose stack and ports
