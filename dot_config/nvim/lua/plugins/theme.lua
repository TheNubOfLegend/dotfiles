return {
  'sainnhe/everforest',
  priority = 1000, -- Make sure to load this before all the other start plugins.
  init = function()
    vim.g.everforest_background = 'hard'
    vim.cmd.colorscheme 'everforest'

    -- You can configure highlights by doing something like:
    -- vim.cmd.hi 'Comment gui=none'
  end,
}
