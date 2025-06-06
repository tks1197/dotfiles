# XDG Base Directory
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_BIN_HOME="$HOME/.local/bin"

# PATH
export PATH=$PATH:$XDG_BIN_HOME

# less history
export LESSHISTFILE="$XDG_STATE_HOME/.lesshst"

# aws-cli
export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME/aws/credentials"
export AWS_CONFIG_FILE="$XDG_CONFIG_HOME/aws/config"
export AWS_CLI_AUTO_PROMPT=on-partial

# IPython
export IPYTHONDIR="$XDG_CONFIG_HOME/ipython"

# Python
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/startup.py"

# terraform cli
# export TF_CLI_CONFIG_FILE="$XDG_CONFIG_HOME/terraform/config.tfrc"

# disable deno update check
export DENO_NO_UPDATE_CHECK=1

#poetry
export POETRY_VIRTUALENVS_IN_PROJECT=true

export LANG=ja_JP.UTF-8

# sheldon setting file
export SHELDON_CONFIG_DIR=$ZDOTDIR/sheldon

# cargo
export CARGO_HOME=$XDG_DATA_HOME/cargo

# rustup
export RUSTUP_HOME=$XDG_DATA_HOME/rustup

# GO
export GOPATH=$XDG_DATA_HOME/go

# DevPod
export DEVPOD_HOME=$XDG_DATA_HOME/devpod

# Yazi
export YAZI_CONFIG_HOME=$XDG_CONFIG_HOME/yazi

# GNU Parallel
export PARALLEL_HOME=$XDG_CACHE_HOME/parallel

# StarShip
export STARSHIP_CONFIG=$XDG_CONFIG_HOME/starship/starship.toml

# Cookiecutter
## https://cookiecutter.readthedocs.io/en/stable/advanced/user_config.html#user-config
export COOKIECUTTER_CONFIG=$XDG_CONFIG_HOME/cookiecutter/config.yaml

# gh_dash config
export GH_DASH_CONFIG=$XDG_CONFIG_HOME/gh-dash/config.yaml

# fly.io
export FLY_CONFIG_DIR="$XDG_STATE_HOME"/fly

# gnupg
# export GNUPGHOME="$XDG_DATA_HOME"/gnupg

# 1password SSH Agent Setting
# https://developer.1password.com/docs/ssh/get-started
if [[ "$OSTYPE" == "darwin"* ]]; then
  export SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
else
  export SSH_AUTH_SOCK=~/.1password/agent.sock
fi


# read .zshenv.local if exists
if [ -f $XDG_CONFIG_HOME/zsh/.zshenv.local ]; then
    source $XDG_CONFIG_HOME/zsh/.zshenv.local
fi


