return {
  'echasnovski/mini.indentscope',
  opts = {},
  config = function()
    local indentscope = require 'mini.indentscope'
    indentscope.setup {
      draw = {
        delay = 20,
        animation = indentscope.gen_animation.none(),
      },
      symbol = '│',
    }
  end,
}
