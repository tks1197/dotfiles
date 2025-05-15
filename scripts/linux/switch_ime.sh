#!/bin/bash
swaymsg -m -t subscribe '["window"]' |
  stdbuf -o L jq -c 'select(.change == "focus")' |
  while read -r string; do
    app_id=$(echo "$string" | jq -r '.container.app_id')
    if [[ "$app_id" == "floorp" ]]; then
      fcitx5-remote -s skk
    fi
  done
