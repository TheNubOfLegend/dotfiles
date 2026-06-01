vim.pack.add { 'https://github.com/echasnovski/mini.indentscope' }
require('mini.indentscope').setup {
  draw = {
    delay = 0,
    animation = function() return 0 end,
  },
  symbol = '│',
}
