# mise
eval "$(mise activate zsh)"
eval "$(mise completion zsh)"

# Rust
source $XDG_DATA_HOME/cargo/env

# zoxide
eval "$(zoxide init zsh)"

# direnv
eval "$(direnv hook zsh)"

# fzf
function fzf-select-history() {
  BUFFER=$(history -n -r 1 | fzf --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle reset-prompt
}
zle -N fzf-select-history
bindkey '^r' fzf-select-history

fzf_cd() {
  local serach_dir=${1:-$HOME}
  local target_dir=$(fd --type directory \
    --exclude .git \
    --hidden \
    --no-ignore \
    . $serach_dir | fzf --prompt='CHANGE DIRECTORY > ') &&
    if [ -n "$target_dir" ]; then
      echo "cd $target_dir"
      cd "$target_dir"
    fi
}
zle -N fzf_cd
bindkey '^o' fzf_cd

export FZF_DEFAULT_OPTS='--reverse --border --ansi --bind="ctrl-d:print-query,ctrl-p:replace-query" --inline-info --height 80%'
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'

# 1password
## enable plugins
source $XDG_CONFIG_HOME/op/plugins.sh
## enable completion
eval "$(op completion zsh)"
compdef _op op

# aws-vaultの補完
eval "$(aws-vault --completion-script-zsh)"

# 補完の有効化
autoload -Uz compinit -C && compinit -C

# alias
## nnn
alias n3="nnn"

## Neovim
alias v="nvim"

## MacのBSD系コマンドをGNU系に置き換える。
case "$OSTYPE" in
    darwin*)
        (( ${+commands[gdate]} )) && alias date='gdate'
        (( ${+commands[gls]} )) && alias ls='gls --color=auto'
        (( ${+commands[gmkdir]} )) && alias mkdir='gmkdir'
        (( ${+commands[gcp]} )) && alias cp='gcp'
        (( ${+commands[gmv]} )) && alias mv='gmv'
        (( ${+commands[grm]} )) && alias rm='grm'
        (( ${+commands[gdu]} )) && alias du='gdu'
        (( ${+commands[ghead]} )) && alias head='ghead'
        (( ${+commands[gtail]} )) && alias tail='gtail'
        (( ${+commands[gsed]} )) && alias sed='gsed'
        (( ${+commands[ggrep]} )) && alias grep='ggrep'
        (( ${+commands[gfind]} )) && alias find='gfind'
        (( ${+commands[gdirname]} )) && alias dirname='gdirname'
        (( ${+commands[gxargs]} )) && alias xargs='gxargs'
    ;;
esac

## ls
alias ll='ls -al'

## 自身のIPアドレスを取得
alias myip='curl https://checkip.amazonaws.com/'
