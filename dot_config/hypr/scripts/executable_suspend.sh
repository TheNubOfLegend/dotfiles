#!/bin/bash

swayidle -w \
  timeout 600 ' hyprlock' \
  timeout 900 ' hyprctl dispatch dpms off' \
  timeout 960 'systemctl suspend' \
    resume ' hyprctl dispatch dpms on' \
  before-sleep ' hyprlock'
