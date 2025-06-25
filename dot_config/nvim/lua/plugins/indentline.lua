return {
  'echasnovski/mini.indentscope',
  opts = {
    draw = {
      delay = 20,
      animation = require('mini.indentscope').gen_animation.linear { duration = 10, unit = 'total' },
    },
    symbol = '│',
  },
}
