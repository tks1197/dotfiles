#! /usr/bin/env bash
set -euxo pipefail

GH_EXTENSIONS=(
  "dlvhdr/gh-dash"
  "yusukebe/gh-markdown-preview"
  "seachicken/gh-poi"
)
# install gh extensions
xargs -n 1 gh extension install <<<"${GH_EXTENSIONS[@]}"

# set alias
# shellcheck disable=SC2016
gh alias set --clobber get '!gh repo view "$1" | awk "/^name:/{print \$2}" | xargs -I% gh repo clone "%" ~/src/github.com/"%"'
