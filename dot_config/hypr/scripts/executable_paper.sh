#!/bin/sh

declare CURR=$(( $(date +%k) / 3 % 7 + 1 ))
declare MON
if [[ $(cat /etc/hostname) == "nublap" ]]; then
  MON="eDP-1"
elif [[ $(cat /etc/hostname) == "nubdesk" ]]; then
  MON="HDMI-A-1"
fi
hyprctl hyprpaper preload "~/.config/hypr/paper/${CURR}.jpg"
hyprctl hyprpaper wallpaper "${MON},~/.config/hypr/paper/${CURR}.jpg"

while [ true ]; do
  if [ $(( $(date +%k) / 3 % 7 + 1 )) -ne ${CURR} ]; then
    hyprctl hyprpaper preload "~/.config/hypr/paper/$(( $(date +%k) / 3 % 7 + 1 )).jpg"
    hyprctl hyprpaper wallpaper "${MON},~/.config/hypr/paper/$(( $(date +%k) / 3 % 7 + 1 )).jpg"
    hyprctl hyprpaper unload "~/.config/hypr/paper/${CURR}.jpg"
  fi
  CURR=$(( $(date +%k) / 3 % 7 + 1 ))
  sleep 60
done
