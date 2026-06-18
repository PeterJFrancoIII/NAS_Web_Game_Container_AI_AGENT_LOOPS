# Archived container modules

Legacy **noVNC / WebRTC `remote.html`** image sources. Production ultra streaming uses `container/Dockerfile.ultra` and files remaining in `container/`.

## Archived image

| File | Role |
|------|------|
| `Dockerfile` | Base `ra2-lan-party:latest` noVNC image |
| `supervisord.conf` | noVNC + websockify + x11vnc + audio-proxy stack |
| `entrypoint.sh` | noVNC container entrypoint |
| `remote/` | Legacy WebRTC browser client (`remote.html`) |
| `audio-proxy.sh`, `latency-proxy.sh` | noVNC-era audio path |
| `start-websockify.sh`, `start-x11vnc.sh` | noVNC streaming |
| `healthcheck-novnc.sh` | Base compose healthcheck |
| `patch-novnc.sh`, `cursor-lock.js`, `latency-overlay.js` | noVNC patches |
| `input-proxy.py`, `uinput_backend.py`, `start-input-proxy.sh` | uinput experiment |
| `websockify-tokens.cfg` | Websockify token config |

## Still in `container/` (production ultra)

- `Dockerfile.ultra`, `supervisord.ultra.conf`, `supervisord.ultra-udp.conf`
- `ra2-stream-gateway.py`, `remote-ultra/`, `stream-helper.c`
- `webrtc-media.py`, `webrtc-media-helper.c`, `start-webrtc.sh` (UDP ultra path)
- Wine/game/session scripts, `entrypoint-ultra.sh`, `healthcheck-ultra.sh`

Referenced from root `compose.yaml` via `dockerfile: archive/container/Dockerfile` and volume mounts under `./archive/container/…`.
