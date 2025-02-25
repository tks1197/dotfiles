#! /usr/bin/env bash
set -euxo pipefail
mise install

mise use -g terraform@1.9.1
mise use -g ruby@3.3.6
mise use -g node@23.7.0
mise use -g python@3.12.2
mise use -g zig@0.13
mise use -g deno@2.2.1
mise use -g usage@latest
mise use -g yarn@latest
