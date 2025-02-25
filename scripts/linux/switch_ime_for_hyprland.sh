#!/bin/bash
handle() {
  if [[ $1 == activewindowv2* ]]; then
    return
  fi
  if [[ $1 == activewindow* ]]; then
    app_id=$(echo $1 | grep -oP '(?<=>>)[^, ]*')
    if [ "$app_id" = "zen-beta" ] || [ "$app_id" = "com.mitchellh.ghostty" ]; then
      fcitx5-remote -s skk
    else
      fcitx5-remote -s keyboard-us
    fi
  fi
}
# see https://wiki.hyprland.org/IPC/#how-to-use-socket2-with-bash
socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done
