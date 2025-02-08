#!/bin/bash
# https://github.com/textlint/textlint
set -euxo pipefail

mkdir -p ~/.local/share/textlint

pushd ~/.local/share/textlint || exit
npm install --save-dev textlint
jq -r '.rules | keys[]' ~/.config/textlint/.textlintrc.json | xargs --max-proc 4 -I {} npm install --save-dev textlint-rule-{}
popd || exit

ln -sf ~/.local/share/textlint/node_modules/.bin/textlint ~/.local/bin/textlint
