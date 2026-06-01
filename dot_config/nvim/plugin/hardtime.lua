vim.pack.add { 'https://github.com/m4xshen/hardtime.nvim' }
require('hardtime').setup {
  disabled_keys = {
    ['<Up>'] = {},
    ['<Down>'] = {},
    ['<Left>'] = {},
    ['<Right>'] = {},
  },
  restricted_keys = {
    ['<Up>'] = { 'x', 'n' },
    ['<Down>'] = { 'x', 'n' },
    ['<Left>'] = { 'x', 'n' },
    ['<Right>'] = { 'x', 'n' },
  },
  max_count = 3,
}
