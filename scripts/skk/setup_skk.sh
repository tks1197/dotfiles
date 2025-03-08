#! /usr/bin/env bash
set -euxo pipefail

# SKK SKK_USER_DICT
mkdir -p ~/.config/skk

# download skk directory
mkdir -p ~/.local/share/skk/

# TODO: download skk-jisyo
if ! command -v yaskkserv2 2>&1 >/dev/null; then
  echo "yaskkserv2 not found installing..."
  gh get wachikun/yaskkserv2
  pushd ~/src/github.com/wachikun/yaskkserv2 || exit
  cargo build --release
  cp -av target/release/yaskkserv2 /usr/local/sbin/yaskkserv2
  cp -av target/release/yaskkserv2_make_dictionary ~/.local/bin/yaskkserv2_make_dictionary
  popd || exit
fi
