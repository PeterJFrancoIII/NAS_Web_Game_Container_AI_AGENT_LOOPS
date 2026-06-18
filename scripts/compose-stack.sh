#!/bin/sh
# Print effective docker compose -f stack for the current RA2_* profile flags.
set -eu

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/lib.sh"

ENV_FILE="${ENV_FILE:-.env}"

section() {
  printf '\n== %s ==\n' "$1"
}

section "Profile flags"
printf 'RA2_COMPOSE_ULTRA=%s\n' "${RA2_COMPOSE_ULTRA:-0}"
printf 'RA2_COMPOSE_ULTRA_UDP=%s\n' "${RA2_COMPOSE_ULTRA_UDP:-0}"
printf 'RA2_COMPOSE_ULTRA_UDP_HOST=%s\n' "${RA2_COMPOSE_ULTRA_UDP_HOST:-0}"
printf 'RA2_COMPOSE_WEBRTC=%s\n' "${RA2_COMPOSE_WEBRTC:-0}"
printf 'RA2_COMPOSE_MOONLIGHT=%s\n' "${RA2_COMPOSE_MOONLIGHT:-0}"
printf 'RA2_COMPOSE_TAILSCALE=%s\n' "${RA2_COMPOSE_TAILSCALE:-0}"
printf 'RA2_COMPOSE_TRANSCODE=%s\n' "${RA2_COMPOSE_TRANSCODE:-0}"

section "Compose files (in order)"
# shellcheck disable=SC2046
set -- $(compose_file_args "$ENV_FILE")
while [ $# -gt 0 ]; do
  if [ "$1" = "-f" ]; then
    shift
    printf '  -f %s\n' "$1"
    shift
  else
    shift
  fi
done

section "docker compose command"
printf 'docker compose --env-file %s' "$ENV_FILE"
# shellcheck disable=SC2046
printf ' %s' $(compose_file_args "$ENV_FILE")
printf '\n'
