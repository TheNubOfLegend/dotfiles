-- clangd_util.lua
-- Utility functions for clangd configuration

local M = {}

--- Detect if the current project is a PlatformIO project
---@param root_dir string
---@return boolean
local function is_platformio_project(root_dir)
  local platformio_ini = root_dir .. '/platformio.ini'
  return vim.fn.filereadable(platformio_ini) == 1
end

--- Generate .clangd configuration
---@param is_platformio boolean
---@return string
local function generate_clangd_config(is_platformio)
  local config = 'Diagnostics:\n'
  config = config .. '  Suppress:\n'
  config = config .. '    - anon_bitfield_qualifiers\n'

  if is_platformio then
    config = config .. '    - pp_file_not_found\n'
  end

  config = config .. '\n'
  config = config .. 'CompileFlags:\n'
  config = config .. '  CompilationDatabase: .\n'
  config = config .. '  Add:\n'
  config = config .. '    - -ferror-limit=0\n'

  if is_platformio then
    config = config .. '  Remove:\n'
    config = config .. '    - -mlongcalls\n'
    config = config .. '    - -fstrict-volatile-bitfields\n'
    config = config .. '    - -fno-tree-switch-conversion\n'
  end

  return config
end

--- Create .clangd file if it doesn't exist (never overwrites)
---@param root_dir string
---@return boolean success
function M.ensure_clangd_config(root_dir)
  if not root_dir then return false end

  local clangd_file = root_dir .. '/.clangd'

  -- Only create if it doesn't already exist
  if vim.fn.filereadable(clangd_file) == 1 then
    return true
  end

  local config_content = generate_clangd_config(is_platformio_project(root_dir))

  -- Write the .clangd file
  local lines = vim.split(config_content, '\n')
  local success = vim.fn.writefile(lines, clangd_file)

  if success == 0 then
    vim.notify(string.format('[clangd] Generated .clangd config in %s', root_dir), vim.log.levels.INFO)
    return true
  else
    vim.notify(string.format('[clangd] Failed to write .clangd in %s', root_dir), vim.log.levels.WARN)
    return false
  end
end

function M.is_platformio_project(root_dir)
  return is_platformio_project(root_dir)
end

return M
