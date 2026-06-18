# Archived experiment scripts

Historical deploy and diagnostic scripts for **non-production** streaming profiles (WebRTC `remote.html`, Moonlight, Selkies, Tailscale, VA-API transcode experiments).

Production ultra deploy remains at the parent directory:

```bash
NAS_HOST=MediaServer2 sh scripts/redeploy-ultra.sh
NAS_HOST=MediaServer2 RA2_COMPOSE_ULTRA=1 sh scripts/check-ultra-ready.sh
```

Debug effective compose stack:

```bash
RA2_COMPOSE_ULTRA=1 RA2_COMPOSE_ULTRA_UDP=1 RA2_COMPOSE_ULTRA_UDP_HOST=1 sh scripts/compose-stack.sh
```

## Script inventory

| Script | Profile |
|--------|---------|
| `redeploy-webrtc.sh` | Legacy WebRTC `remote.html` |
| `redeploy-webrtc-udp.sh` | WebRTC + UDP ICE |
| `redeploy-moonlight-poc.sh` | Moonlight Wolf/Sunshine POC |
| `redeploy-profile-selkies.sh` | Selkies/Webtop experiment |
| `redeploy-low-memory.sh` | Low-memory noVNC variant |
| `compare-moonlight-webrtc.sh` | Side-by-side experiment comparison |
| `compare-selkies-webrtc.sh` | Selkies vs WebRTC comparison |
| `check-moonlight-ready.sh` | Moonlight host readiness |
| `check-transcode.sh` | VA-API transcode probe |
| `check-tailscale-direct.sh` | Tailscale WAN path |
| `check-webrtc-ready.sh` | Legacy WebRTC readiness |
| `check-webrtc-ice-reachability.sh` | ICE/TURN reachability |
| `probe-webrtc-turn.sh` | Local TURN allocate probe |
| `probe-webrtc-turn-remote.sh` | Remote TURN probe (VPN) |
| `probe-webrtc-signaling-offer.sh` | Signaling offer smoke test |
| `enable-host-transcode.sh` | Host VA-API prep |
| `enable-uinput.sh` | uinput module for Moonlight/WebRTC input |

All scripts source `../lib.sh` and resolve archived compose files via `archived_compose_file()` in `scripts/lib.sh`.
