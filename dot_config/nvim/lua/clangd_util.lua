-- clangd_util.lua
-- Utility functions for clangd configuration and .clangd file generation

local M = {}

--- Detect if the current project is an Arduino project
---@param root_dir string
---@return boolean
local function is_arduino_project(root_dir)
  local arduino_markers = {
    'arduino.json',
    '.arduino.json',
    'hardware',
    '*.ino',
  }

  for _, marker in ipairs(arduino_markers) do
    if marker:match '%.ino$' then
      -- Check for .ino files
      local ino_files = vim.fn.glob(root_dir .. '/**/*.ino')
      if ino_files ~= '' then return true end
    else
      -- Check for marker files/directories
      local marker_path = root_dir .. '/' .. marker
      if vim.fn.filereadable(marker_path) == 1 or vim.fn.isdirectory(marker_path) == 1 then return true end
    end
  end

  return false
end

--- Generate .clangd configuration for C/C++ projects
---@param is_arduino boolean
---@return string
local function generate_clangd_config(is_arduino)
  local config = 'Diagnostics:\n'

  if is_arduino then
    -- Arduino-specific diagnostic suppressions
    config = config .. '  Suppress:\n'
    config = config .. '    - anon_bitfield_qualifiers\n'
    config = config .. '    - unknown_attributes\n'
  end

  config = config .. 'CompileFlags:\n'
  config = config .. '  Add:\n'
  config = config .. '    - -ferror-limit=0\n'

  if is_arduino then
    config = config .. '    - -fpermissive\n'
  end

  config = config .. '    - -std=c++17\n'

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

  local is_arduino = is_arduino_project(root_dir)
  local config_content = generate_clangd_config(is_arduino)

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

return M
