#!/bin/sh

while [ true ]; do
  hyprctl hyprpaper wallpaper "eDP-1,~/.config/hypr/paper/$(( $(date +%H) / 3 % 7 + 1 )).jpg"
  sleep 600
done
