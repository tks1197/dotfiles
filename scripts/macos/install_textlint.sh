#!/bin/bash
# https://github.com/textlint/textlint
set -euxo pipefail

mkdir -p ~/.local/share/textlint

pushd ~/.local/share/textlint || exit
npm install --save-dev textlint
# install required plugins for org-mode
npm install --save-dev textlint-plugin-org traverse @textlint/ast-node-types
# install rules
jq -r '.rules | keys[]' ~/.config/textlint/.textlintrc.json |
  sed -e 's/\//\/textlint-rule-/' -e t -e 's/^/textlint-rule-/' -e t |
  xargs -rn 1 npm install --save-dev
popd || exit

ln -sf ~/.local/share/textlint/node_modules/.bin/textlint ~/.local/bin/textlint
