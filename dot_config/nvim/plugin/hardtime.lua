vim.pack.add { 'https://github.com/thenuboflegend/hardtime.nvim' }
require('hardtime').setup {
  disabled_keys = {
    ['<Up>'] = { 'i' },
    ['<Down>'] = { 'i' },
    ['<Left>'] = { 'i' },
    ['<Right>'] = { 'i' },
  },
  restricted_keys = {
    ['<Up>'] = { 'x', 'n' },
    ['<Down>'] = { 'x', 'n' },
    ['<Left>'] = { 'x', 'n' },
    ['<Right>'] = { 'x', 'n' },
  },
  max_count = 3,
}
