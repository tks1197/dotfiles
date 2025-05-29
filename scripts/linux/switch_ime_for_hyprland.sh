#!/bin/bash
handle() {
  if [[ $1 == activewindowv2* ]]; then
    return
  fi
  if [[ $1 == activewindow* ]]; then
    app_id=$(echo $1 | grep -oP '(?<=>>)[^, ]*')

    case "$app_id" in
    "zen-beta" | "floorp" | "kitty" | "code" | "dev.zed.Zed")
      fcitx5-remote -s keyboard-us
      ;;
    *)
      fcitx5-remote -s hazkey
      ;;
    esac
  fi
}
# see https://wiki.hyprland.org/IPC/#how-to-use-socket2-with-bash
socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done
