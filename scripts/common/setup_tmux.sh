#! /usr/bin/env bash
set -euxo pipefail
# TPM(Tmux Plugin Manager)
## https://github.com/tmux-plugins/tpm?tab=readme-ov-file#installation
TPM_INSTALL_DIR=$HOME/.local/share/tpm
if [ ! -d "$TPM_INSTALL_DIR" ]; then
  git clone https://github.com/tmux-plugins/tpm "$TPM_INSTALL_DIR"
fi

# tmux catppuccino
CATPUCCHINO_DIR=$HOME/.config/tmux/plugins/catppuccin
if [ ! -d "$CATPUCCHINO_DIR" ]; then
  git clone -b v2.1.2 https://github.com/catppuccin/tmux.git "$CATPUCCHINO_DIR"
fi

# tmuxinator
if ! command -v tmuxinator &>/dev/null; then
  printf 'Install tmuxinator...\n'
  gem install tmuxinator --bindir "$HOME"/.local/bin
fi
