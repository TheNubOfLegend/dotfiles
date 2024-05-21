return {
  'ggandor/leap.nvim',
  config = function()
    vim.keymap.set({'n', 'x', 'o'}, 'l',  '<Plug>(leap-forward)')
    vim.keymap.set({'n', 'x', 'o'}, 'L',  '<Plug>(leap-backward)')
    vim.keymap.set({'n', 'x', 'o'}, 'gl', '<Plug>(leap-from-window)')
    require('leap.user').set_repeat_keys('<enter>', '<backspace>')
  end,
  opts = {
    equivalence_classes = { ' \t\r\n', '([{', ')]}', '\'"`' },
    special_keys = {
      prev_target = '<backspace>',
      prev_group = '<backspace>',
    }
  },
}
