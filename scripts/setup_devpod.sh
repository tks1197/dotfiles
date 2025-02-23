#! /usr/bin/env bash
set -euxo pipefail
# devpod CLI
# https://devpod.sh/docs/getting-started/install#optional-install-devpod-cli

archtecture=$1

if ! command -v devpod >/dev/null; then
  echo "devpod not found. installing..."
  DEVPOD_DIR=$HOME/.local/share/devpod
  mkdir -p "$DEVPOD_DIR"
  DEVPOD_HOME=$DEVPOD_DIR curl -L -o devpod "https://github.com/loft-sh/devpod/releases/latest/download/devpod-$archtecture" &&
    sudo install -c -m 0755 devpod "$HOME"/.local/bin/ && rm -f devpod
fi
