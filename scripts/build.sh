#!/bin/bash
set -e

IMAGE_NAME="j00ny0un9/team_03_project:0.1.0"

docker run --rm -it \
  --user "$(id -u):$(id -g)" \
  -v "$(pwd)":/app \
  -w /app \
  "$IMAGE_NAME" \
  bash -c "cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug && cmake --build build -j\$(nproc) && chmod +x build/main"
