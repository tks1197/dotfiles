#!/bin/bash
# https://github.com/streetsidesoftware/cspell
set -euxo pipefail

mkdir -p ~/.local/share/cspell

pushd ~/.local/share/cspell || exit
npm install --save-dev git+https://github.com/streetsidesoftware/cspell-cli
jq -r '.import[]' ~/.config/cspell/cspell.json |
  cut -d '/' -f 1-2 |
  xargs -n 1 npm install --save-dev
popd || exit

ln -sf ~/.local/share/cspell/node_modules/.bin/cspell ~/.local/bin/cspell
