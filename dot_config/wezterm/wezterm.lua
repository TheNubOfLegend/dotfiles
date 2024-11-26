local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.enable_wayland = false
config.enable_tab_bar = false

config.font = wezterm.font('JetBrains Mono', { weight = 'Medium' })
config.font_size = 9

config.colors = {
  foreground = "#d3c6aa",
  background = "272e33",

  cursor_bg = "d3c6aa",
  cursor_fg = "272e33",

  ansi = {
    '#2e383c',
    '#e67e80',
    '#a7c080',
    '#dbbc7f',
    '#7fbbb3',
    '#d699b6',
    '#83c092',
    '#d3c6aa',
  },
  brights = {
    '#5c6a72',
    '#f85552',
    '#8da101',
    '#dfa000',
    '#3a94c5',
    '#df69ba',
    '#35a77c',
    '#dfddc8',
  },
}

return config
