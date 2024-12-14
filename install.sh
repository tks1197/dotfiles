#!/usr/bin/env sh

sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$HOME/.local/bin" \
    init --apply --verbose --no-tty tks1197 --promptString email=test@example.com,name=user1
