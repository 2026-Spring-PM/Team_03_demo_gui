#!/bin/bash
set -euo pipefail

IMAGE_NAME="j00ny0un9/team_03_project:0.1.0"

cleanup() {
  xhost -local:docker > /dev/null 2>&1 || true
}
trap cleanup EXIT INT TERM

mkdir -p saves

DOCKER_ARGS=(
  --rm
  -it
  --init
  --user "$(id -u):$(id -g)"
  -e DISPLAY="$DISPLAY"
  -v /tmp/.X11-unix:/tmp/.X11-unix:rw
  -v "$(pwd)":/app
  -w /app
)

if [ -e /dev/dri ]; then
  DOCKER_ARGS+=(--device /dev/dri:/dev/dri)
fi

if [ -e /dev/snd ]; then
  DOCKER_ARGS+=(--device /dev/snd:/dev/snd)
fi

xhost +local:docker > /dev/null 2>&1 || true

docker run "${DOCKER_ARGS[@]}" \
  "$IMAGE_NAME" \
  bash -lc 'chmod +x ./build/main && exec ./build/main'