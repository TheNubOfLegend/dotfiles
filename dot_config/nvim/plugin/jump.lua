vim.pack.add { 'https://github.com/yorickpeterse/nvim-jump' }

vim.api.nvim_set_hl(0, 'JumpLabel', { bg = '#d3869b', fg = '#282828', bold = false })

require('jump').setup {
  labels = 'tnseriaogmplfuwyqbjdhvkzxc',
  label = 'JumpLabel',
}

vim.keymap.set({ 'n', 'x', 'o' }, '/', require('jump').start, {})
