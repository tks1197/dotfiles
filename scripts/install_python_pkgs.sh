#! /usr/bin/env bash
set -euxo pipefail

PYTHON_PKGS=(
  cfn-lint
  yamllint
  aws-sam-cli
  terraform-local
  cookiecutter
  zizmor
  pyright
  gitingest
  vectorcode
  basedpyright
)
xargs -n 1 uv tool install <<<"${PYTHON_PKGS[@]}"
