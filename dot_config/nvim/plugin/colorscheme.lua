vim.pack.add { 'https://github.com/sainnhe/gruvbox-material' }
vim.cmd.colorscheme 'gruvbox-material'

local normal_bg = vim.api.nvim_get_hl(0, { name = 'Normal' }).bg
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = normal_bg })
vim.api.nvim_set_hl(0, 'FloatTitle', { bg = normal_bg })
vim.api.nvim_set_hl(0, 'FloatFooter', { bg = normal_bg })
vim.api.nvim_set_hl(0, 'FloatBorder', { bg = normal_bg })
