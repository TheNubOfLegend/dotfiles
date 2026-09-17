-- clangd.lua
-- Auto-configuring clangd for Arduino (PlatformIO) and x86 projects

local clangd_util = require 'clangd_util'

return {
  cmd = {
    'clangd',
    '--background-index',
    '--clang-tidy',
  },
  root_markers = { 'build/compile_commands.json', 'compile_commands.json', '.git', 'platformio.ini' },
  filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'h', 'hpp' },

  on_init = function(client)
    if not client.workspace_folders or not client.workspace_folders[1] then
      return
    end

    local root_dir = client.workspace_folders[1].name

    -- Detect project type and add appropriate clangd args
    if clangd_util.is_platformio_project(root_dir) then
      -- PlatformIO/Arduino project
      table.insert(client.config.cmd, '--pch-storage=memory')
      table.insert(client.config.cmd, '--query-driver=' .. os.getenv('HOME') .. '/.platformio/packages/**/bin/*gcc*')
    else
      -- Regular x86 project
      table.insert(client.config.cmd, '--query-driver=/**/**/bin/*gcc*')
    end

    -- Generate .clangd if needed
    clangd_util.ensure_clangd_config(root_dir)
  end,
}
