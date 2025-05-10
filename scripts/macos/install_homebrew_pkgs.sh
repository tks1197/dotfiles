#!/usr/bin/env bash
set -euxo pipefail
# xcode
if ! xcode-select --version; then
  xcode-select --install
fi
# Homebrew
if test ! "$(which brew)"; then
  printf 'Homebrew not found. Installing Homebrew...'
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
else
  printf 'Homebrew found. updateting...'
  brew update
fi
/opt/homebrew/bin/brew bundle --no-lock --file ~/.config/homebrew/Brewfile --force
