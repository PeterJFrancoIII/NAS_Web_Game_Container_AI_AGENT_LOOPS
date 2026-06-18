#!/bin/sh
# CI smoke: validate ultra production compose stack merges without errors.
set -eu

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname "$0")" && pwd)"
ROOT="$(CDPATH= cd -- "$SCRIPT_DIR/.." && pwd)"
cd "$ROOT"

ENV_FILE="${ENV_FILE:-.env}"
if [ ! -f "$ENV_FILE" ]; then
  cp .env.example "$ENV_FILE"
fi

export RA2_COMPOSE_ULTRA="${RA2_COMPOSE_ULTRA:-1}"
export RA2_COMPOSE_ULTRA_UDP="${RA2_COMPOSE_ULTRA_UDP:-1}"
export RA2_COMPOSE_ULTRA_UDP_HOST="${RA2_COMPOSE_ULTRA_UDP_HOST:-1}"

if ! command -v docker >/dev/null 2>&1; then
  echo "[ci-compose] docker not found — skipping"
  exit 0
fi

. "$SCRIPT_DIR/lib.sh"

compose_args=""
while IFS= read -r token; do
  [ -n "$token" ] || continue
  compose_args="$compose_args $token"
done <<EOF
$(compose_file_args "$ENV_FILE")
EOF

echo "[ci-compose] docker compose config (ultra production stack)"
# shellcheck disable=SC2086
docker compose --env-file "$ENV_FILE" $compose_args config --quiet
echo "[ci-compose] ok"
