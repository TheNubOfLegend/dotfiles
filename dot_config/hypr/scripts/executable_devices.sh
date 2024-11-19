#!/bin/sh

if [[ $(cat /etc/hostname) == "nublap" ]]; then
  echo "
monitor=eDP-1,1920x1080,auto,1

bind = , XF86MonBrightnessUp, exec, brightnessctl set +25
bind = , XF86MonBrightnessDown, exec, brightnessctl set 25-

# SUSPEND
bindl=,switch:on:Lid Switch, exec, hyprctl dispatch dpms off && hyprctl dispatch exec hyprlock
bindl=,switch:off:Lid Switch, exec, hyprctl dispatch dpms on

input {
  sensitivity = -0.3
}" > ../devices.conf

elif [[ $(cat /etc/hostname) == "nublap" ]]; then
  echo "
monitor=,2560x1440@144,auto,auto

# SUSPEND
exec-once = ~/.config/hypr/scripts/suspend.sh

env = LIBVA_DRIVER_NAME,nvidia
env = XDG_SESSION_TYPE,wayland
env = GBM_BACKEND,nvidia-drm
env = __GLX_VENDOR_LIBRARY_NAME,nvidia

input {
  sensitivity = -0.7
}" > ../devices.conf
fi
