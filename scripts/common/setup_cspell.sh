#!/bin/bash
# https://github.com/streetsidesoftware/cspell
set -euxo pipefail

mkdir -p ~/.local/share/cspell

pushd ~/.local/share/cspell || exit
npm install --save-dev git+https://github.com/streetsidesoftware/cspell-cli
popd || exit

ln -sf ~/.local/share/cspell/node_modules/.bin/cspell ~/.local/bin/cspell
