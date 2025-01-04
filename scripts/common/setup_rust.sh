#! /usr/bin/env bash
set -euxo pipefail
if ! command -v rustup >/dev/null; then
  echo "rustup not found. installing..."
  RUST_UP_HOME=$HOME/.local/bin/rustup curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path &&
    rustup component add rust-analyzer clippy
fi
