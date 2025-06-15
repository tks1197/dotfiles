#! /usr/bin/env bash
set -euxo pipefail

# SKK SKK_USER_DICT
mkdir -p ~/.config/skk

# download skk directory
mkdir -p ~/.local/share/skk/

# Download SKK dictionaries
DICT_DIR=~/.local/share/skk
DICT_REPO_URL="https://raw.githubusercontent.com/skk-dev/dict/master"

# Main dictionaries to download
declare -a DICTIONARIES=(
  "SKK-JISYO.L"
  "SKK-JISYO.jinmei"
  "SKK-JISYO.geo"
  "SKK-JISYO.station"
  "SKK-JISYO.propernoun"
)

# Download dictionaries if they don't exist
for dict in "${DICTIONARIES[@]}"; do
  if [ ! -f "$DICT_DIR/$dict" ]; then
    echo "Downloading $dict..."
    curl -fsSL "$DICT_REPO_URL/$dict" -o "$DICT_DIR/$dict" || {
      echo "Failed to download $dict"
      rm -f "$DICT_DIR/$dict" # Remove partial download
    }
  else
    echo "$dict already exists, skipping..."
  fi
done

# Install yaskkserv2
if ! command -v yaskkserv2 &>/dev/null; then
  echo "yaskkserv2 not found installing..."

  # Check if repository already exists
  if [ ! -d ~/src/github.com/wachikun/yaskkserv2 ]; then
    gh get wachikun/yaskkserv2
  fi

  pushd ~/src/github.com/wachikun/yaskkserv2 || exit

  # Build only if binary doesn't exist
  if [ ! -f target/release/yaskkserv2 ]; then
    cargo build --release
  fi

  # Copy only if destination doesn't exist or is different
  if [ ! -f /usr/local/bin/yaskkserv2 ] || ! cmp -s target/release/yaskkserv2 /usr/local/bin/yaskkserv2; then
    sudo cp -av target/release/yaskkserv2 /usr/local/bin/yaskkserv2
  fi

  if [ ! -f ~/.local/bin/yaskkserv2_make_dictionary ] || ! cmp -s target/release/yaskkserv2_make_dictionary ~/.local/bin/yaskkserv2_make_dictionary; then
    mkdir -p ~/.local/bin
    cp -av target/release/yaskkserv2_make_dictionary ~/.local/bin/yaskkserv2_make_dictionary
  fi

  popd || exit
fi
