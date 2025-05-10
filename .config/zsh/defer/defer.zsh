# alias
##  wget
alias wget=wget --hsts-file="$XDG_DATA_HOME/wget-hsts"
## LazyGit
alias lg="lazygit"
## Neovim
alias v="nvim"
alias gh="EDITOR=nvim gh"
# textlint
alias textlint="textlint --config $HOME/.config/textlint/.textlintrc.json"
## alias BSD commands to GNU commands
case "$OSTYPE" in
    darwin*)
        (( ${+commands[gdate]} )) && alias date='gdate'
        (( ${+commands[gls]} )) && alias ls='gls'
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

case "$OSTYPE" in
    linux*)
        alias open='xdg-open'
    ;;
esac

## ls
alias ls='ls --color=auto'
alias ll='ls -al'

## get my ip address
alias myip='curl https://checkip.amazonaws.com/'

# zxoide
eval "$(zoxide init zsh)"

# tmuxinator
alias mux='EDITOR=nvim tmuxinator'
# zsh keybind
## see docs https://zsh.sourceforge.io/Doc/Release/Zsh-Line-Editor.html#index-binding-keys
bindkey -r '^J' # Ctrl-j
bindkey -r '^G' # Ctrl-g

# Rust
source $XDG_DATA_HOME/cargo/env

# direnv
eval "$(direnv hook zsh)"

# fzf
export FZF_DEFAULT_OPTS='--reverse --border --ansi --bind="ctrl-d:print-query,ctrl-p:replace-query" --inline-info --height 80%'
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

fzf-src () {
    FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS} --reverse --height=50%"
    local repo="$(fd . "$HOME"/src --min-depth=3 --max-depth=3 --type=d | fzf)"
    local dir=${repo}
    [ -n "${dir}" ] && z "${dir}"
    zle accept-line
    zle clear-screen
}

zle -N fzf-src
bindkey '^o' fzf-src

## history_search
function fzf-select-history() {
  BUFFER=$(history -n -r 1 | fzf --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle reset-prompt
}
zle -N fzf-select-history
bindkey '^r' fzf-select-history

fo() {
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && nvim -O "${files[@]}"
}

ff() {
    [[ -n $1 ]] && cd $1 # Go to provided folder or noop
    RG_DEFAULT_COMMAND="rg -i -l --hidden --follow --glob '!{.git,node_modules}/*'"

    files=(
    $( 
        FZF_DEFAULT_COMMAND="rg --files" fzf \
        -m \
        -e \
        --ansi \
        --disabled \
        --reverse \
        --bind "ctrl-a:select-all" \
        --bind "change:reload:$RG_DEFAULT_COMMAND {q} || true" \
        --preview "rg -i --pretty --context 2 {q} {}" | cut -d":" -f1,2
    )
    )
    [[ ${#files[@]} -gt 0 ]] && nvim -O "${files[@]}"
}

# 1password
## enable plugins
source $XDG_CONFIG_HOME/op/plugins.sh
## enable completion
eval "$(op completion zsh)"
compdef _op op

# completion for aws-vault
eval "$(aws-vault --completion-script-zsh)"


# git wrapper(block normal force push)
function git () {
  local ispush
  ispush=0
  local isforce
  isforce=0
  for arg in "$@"; do
    if [[ "$arg" == "push" ]]; then
      ispush=1
    fi
    if [ "$ispush" -eq 1 ]; then
      if [[ "$arg" == '--force' ]] || [[ "$arg" =~ ^\-[^\-]*f.*$ ]]; then
        isforce=1
      fi
    fi
    if [ $isforce -eq 1 ]; then
      >&2 echo "Please use '--force-with-lease' instead of '--force'."
      return 1
    fi
  done
  command git "$@"
}

# zk
export ZK_NOTEBOOK_DIR=~/Documents/notebook

