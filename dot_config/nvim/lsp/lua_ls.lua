-- File: ~/.config/nvim/lsp/lua_ls.lua

---@type vim.lsp.Config
return {
  -- NATIVE CONFIG REQUIRED: Tell Neovim what binary to execute
  cmd = { 'lua-language-server' },

  -- NATIVE CONFIG REQUIRED: Tell Neovim when to trigger this server
  filetypes = { 'lua' },

  -- NATIVE CONFIG REQUIRED: Use root_markers instead of root_dir
  root_markers = { '.luarc.json', '.luarc.jsonc', '.git' },

  on_init = function(client)
    -- Disable formatting safely (handled by stylua)
    client.server_capabilities.documentFormattingProvider = false

    -- Check if project-specific configuration files exist to avoid overriding them
    if client.workspace_folders and client.workspace_folders[1] then
      local path = client.workspace_folders[1].name
      if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then return end
    end

    -- Inject Neovim runtime and Luajit definitions safely into the client session
    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua or {}, {
      runtime = {
        version = 'LuaJIT',
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          -- Pulls in your config path directory for full autocomplete profiles
          vim.fn.stdpath 'config' .. '/lua',
        },
      },
    })
  end,

  settings = {
    Lua = {
      format = { enable = false }, -- Disable internal language server formatter
      telemetry = { enable = false },
    },
  },
}
