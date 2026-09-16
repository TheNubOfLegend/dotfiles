-- clangd.lua
-- Minimal clangd configuration with Arduino and C/C++ support.
-- Project-specific settings are handled via .clangd file generation.

local clangd_util = require 'clangd_util'

return {
  cmd = {
    'clangd',
    '--background-index',
    '--clang-tidy',
    '--query-driver=/**/*arduino*/**/bin/*gcc*',
  },
  root_markers = { 'build/compile_commands.json', 'compile_commands.json', '.git' },
  filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'h', 'hpp' },

  on_init = function(client)
    -- Generate .clangd configuration based on project type
    if client.workspace_folders and client.workspace_folders[1] then
      local root_dir = client.workspace_folders[1].name
      clangd_util.ensure_clangd_config(root_dir)
    end
  end,
}
