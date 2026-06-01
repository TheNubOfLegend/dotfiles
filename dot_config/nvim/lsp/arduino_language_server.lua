---@type vim.lsp.Config
return {
    filetypes = { 'ino', 'arduino' },
  root_markers = { '*.ino' },
  cmd = {
    'arduino-language-server',
        '-clangd ', os.getenv('HOME') .. '/.local/share/nvim/mason/bin/clangd',
        '-cli /usr/bin/arduino-cli',
        '-cli-config', os.getenv('HOME') .. '/.arduino15/arduino-cli.yaml',
        '-fqbn arduino:avr:mega'
  },
  capabilities = {
    textDocument = {
      ---@diagnostic disable-next-line: assign-type-mismatch
      semanticTokens = vim.NIL,
    },
    workspace = {
      ---@diagnostic disable-next-line: assign-type-mismatch
      semanticTokens = vim.NIL,
    },
  },
}
