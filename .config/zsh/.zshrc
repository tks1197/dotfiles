umask 022
# 重複するpathを追加しない
typeset -U path cdpath fpath manpath

# zsh options
# see docs https://zsh.sourceforge.io/Doc/Release/Options.html
## history
HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE="$XDG_STATE_HOME/zsh_history"
LISTMAX=0

setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt GLOBDOTS
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_NO_STORE
setopt INTERACTIVE_COMMENTS
setopt MAGIC_EQUAL_SUBST
setopt PRINT_EIGHT_BIT
setopt NO_FLOW_CONTROL
setopt SHARE_HISTORY
setopt AUTO_PARAM_KEYS
setopt LIST_PACKED
setopt NO_BEEP

unsetopt BG_NICE
unsetopt LIST_TYPES

# 特定コマンドの実行時に履歴に残さない
zshaddhistory() {
  local line="${1%%$'\n'}"
  [[ ! "$line" =~ "^(cd|jj?|la|ll|ls|rm|rmdir)($| )" ]]
}

# 正常終了以外のコマンドを履歴に残さない
__update_history() {
  local last_status="$?"

[[ -d "$XDG_STATE_HOME" ]] || mkdir -p "$XDG_STATE_HOME"
[[ -f "$XDG_STATE_HOME/zsh_history" ]] || touch "$XDG_STATE_HOME/zsh_history"
  local HISTFILE="$XDG_STATE_HOME/zsh_history"
  
  fc -W
  if [[ ${last_status} -ne 0 ]]; then
    ed -s ${HISTFILE} <<EOF >/dev/null
d
w
q
EOF
  fi
}
precmd_functions+=(__update_history)

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

case "$OSTYPE" in
    darwin*)
      # Homebrew
      eval "$(/opt/homebrew/bin/brew shellenv)"

      if type brew &>/dev/null; then
        FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
      fi
      # homebrew bundle file
      export HOMEBREW_BUNDLE_FILE="$XDG_CONFIG_HOME/homebrew/Brewfile"
    ;;
esac

# sheldon
eval "$(sheldon source)"
# tmuxinator resolve window issue
## https://github.com/tmuxinator/tmuxinator?tab=readme-ov-file#window-names-are-not-displaying-properly
export DISABLE_AUTO_TITLE=true

# LANG
export LC_TIME=en_US.UTF-8

# mise
eval "$(mise activate zsh)"
# eval "$(mise completion zsh)"

# fpath
fpath+=~/.local/share/zsh/zfunc/
# defer zsh
zsh-defer source "$ZDOTDIR/defer/defer.zsh"
