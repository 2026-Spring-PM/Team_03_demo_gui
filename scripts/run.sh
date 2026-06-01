#!/usr/bin/env bash
set -euo pipefail

IMAGE_NAME="${IMAGE_NAME:-j00ny0un9/team_03_project:0.1.1}"
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

mkdir -p saves

if ! docker image inspect "$IMAGE_NAME" >/dev/null 2>&1; then
  echo "Docker image not found: $IMAGE_NAME"
  echo "Run: bash docker/docker_build.sh"
  exit 1
fi

if [ ! -x build/main ]; then
  echo "Executable not found: build/main"
  echo "Run: bash scripts/build.sh"
  exit 1
fi

MODE="${1:-${RUN_MODE:-x11}}"

run_vnc() {
  echo "Starting VNC/noVNC mode..."
  echo "Open this after the container starts: http://localhost:6080/vnc.html"

  docker run --rm -it \
    --init \
    --shm-size=256m \
    --user "$(id -u):$(id -g)" \
    -e HOME=/tmp \
    -e DISPLAY=:99 \
    -e VNC_RESOLUTION="${VNC_RESOLUTION:-1280x720x24}" \
    -p 6080:6080 \
    -v "$ROOT_DIR":/app \
    -w /app \
    "$IMAGE_NAME" \
    bash -lc '
      set -euo pipefail
      mkdir -p "$HOME" /tmp/.fluxbox
      rm -f /tmp/.X99-lock

      Xvfb :99 -screen 0 "${VNC_RESOLUTION:-1280x720x24}" +extension GLX +render -noreset >/tmp/xvfb.log 2>&1 &
      sleep 1
      fluxbox >/tmp/fluxbox.log 2>&1 &
      x11vnc -display :99 -forever -shared -nopw -listen 0.0.0.0 -rfbport 5900 -xkb >/tmp/x11vnc.log 2>&1 &
      websockify --web=/usr/share/novnc/ 0.0.0.0:6080 localhost:5900 >/tmp/novnc.log 2>&1 &

      echo "noVNC: http://localhost:6080/vnc.html"
      chmod +x ./build/main
      exec ./build/main
    '
}

run_x11() {
  if [ -z "${DISPLAY:-}" ]; then
    echo "DISPLAY is empty. Use VNC mode: bash scripts/run.sh vnc"
    exit 1
  fi

  xhost +local:docker >/dev/null 2>&1 || true
  cleanup() { xhost -local:docker >/dev/null 2>&1 || true; }
  trap cleanup EXIT INT TERM

  DOCKER_ARGS=(
    --rm
    -it
    --init
    --user "$(id -u):$(id -g)"
    -e HOME=/tmp
    -e DISPLAY="$DISPLAY"
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw
    -v "$ROOT_DIR":/app
    -w /app
  )

  if [ -e /dev/dri ]; then
    DOCKER_ARGS+=(--device /dev/dri:/dev/dri)
  fi

  if [ -e /dev/snd ]; then
    DOCKER_ARGS+=(--device /dev/snd:/dev/snd)
  fi

  docker run "${DOCKER_ARGS[@]}" \
    "$IMAGE_NAME" \
    bash -lc 'chmod +x ./build/main && exec ./build/main'
}

case "$MODE" in
  vnc|--vnc)
    run_vnc
    ;;
  x11|--x11)
    run_x11
    ;;
  *)
    echo "Usage: bash scripts/run.sh [vnc|x11]"
    exit 1
    ;;
esac
