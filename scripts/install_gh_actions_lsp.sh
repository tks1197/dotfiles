#!/bin/bash
# https://github.com/lttb/gh-actions-language-server
set -euxo pipefail

mkdir -p ~/.local/share/gh-actions-ls

pushd ~/.local/share/gh-actions-ls || exit
npm install --save-dev gh-actions-language-server
popd || exit

ln -sf ~/.local/share/gh-actions-ls/node_modules/.bin/gh-actions-language-server ~/.local/bin/gh-actions-language-server
