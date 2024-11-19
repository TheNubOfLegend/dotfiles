#!/bin/sh

declare CURR=$(( $(date +%k) / 3 % 7 + 1 ))
hyprctl hyprpaper preload "~/.config/hypr/paper/${CURR}.jpg"
hyprctl hyprpaper wallpaper "HDMI-A-1,~/.config/hypr/paper/${CURR}.jpg"

while [ true ]; do
  if [ $(( $(date +%k) / 3 % 7 + 1 )) -ne ${CURR} ]; then
    hyprctl hyprpaper preload "~/.config/hypr/paper/$(( $(date +%k) / 3 % 7 + 1 )).jpg"
    hyprctl hyprpaper wallpaper "HDMI-A-1,~/.config/hypr/paper/$(( $(date +%k) / 3 % 7 + 1 )).jpg"
    hyprctl hyprpaper unload "~/.config/hypr/paper/${CURR}.jpg"
  fi
  CURR=$(( $(date +%k) / 3 % 7 + 1 ))
  sleep 900
done
