return { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
        -- Automatically install LSPs and related tools to stdpath for Neovim
        { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
        'williamboman/mason-lspconfig.nvim',
        'WhoIsSethDaniel/mason-tool-installer.nvim',

        -- Useful status updates for LSP.
        -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
        { 'j-hui/fidget.nvim', opts = {} },

        -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
        -- used for completion, annotations and signatures of Neovim apis
        { 'folke/neodev.nvim', opts = {} },
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', {clear = true}),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          --  To jump back, press <C-t>.
          map('gd', vim.lsp.buf.definition(), '[G]oto [D]efinition')

          -- Find references for the word under your cursor.
          map('gr', vim.lsp.buf.references(), '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gI', vim.lsp.buf.implementation(), '[G]oto [I]mplementation')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('<leader>D', vim.lsp.buf.type_definition(), 'Type [D]efinition')

          -- TODO: put these in picker if necessary
          -- -- Fuzzy find all the symbols in your current document.
          -- --  Symbols are things like variables, functions, types, etc.
          -- map('<leader>ds', vim.lsp.buf.document_symbol(), '[D]ocument [S]ymbols')
          --
          -- -- Fuzzy find all the symbols in your current workspace.
          -- --  Similar to document symbols, except searches over your entire project.
          -- map('<leader>ws', vim.lsp.buf.dynamic_workspace_symbols(), '[W]orkspace [S]ymbols')

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('<leader>rn', vim.lsp.buf.rename(), '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('<leader>ca', vim.lsp.buf.code_action(), '[C]ode [A]ction')

          -- Opens a popup that displays documentation about the word under your cursor
          --  See `:help K` for why this keymap.
          map('K', vim.lsp.buf.hover(), 'Hover Documentation')

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('gD', vim.lsp.buf.declaration(), '[G]oto [D]eclaration')

          -- Highlight references on rest, clear on move
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          local capabilities = vim.lsp.protocol.make_client_capabilities()
          capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities())

          local servers = {
            -- clangd = {},
            gopls = {},
            rust_analyzer = {},
            lua_ls = {
              settings = {
                Lua = {
                  completion = {
                    callSnippet = 'Replace',
                  },
                  -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                  diagnostics = { disable = { 'missing-fields' } },
                },
              },
            },
          }

          require('mason').setup()

          -- You can add other tools here that you want Mason to install
          -- for you, so that they are available from within Neovim.
          local ensure_installed = vim.tbl_keys(servers or {})
          vim.list_extend(ensure_installed, {
            'stylua', -- Used to format Lua code
          })
          require('mason-tool-installer').setup { ensure_installed = ensure_installed }

          require('mason-lspconfig').setup {
            handlers = {
                function(server_name)
                    local server = servers[server_name] or {}
                    -- This handles overriding only values explicitly passed
                    -- by the server configuration above. Useful when disabling
                    -- certain features of an LSP (for example, turning off formatting for tsserver)
                    server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
                    require('lspconfig')[server_name].setup(server)
                end,
            },
        }
        end,
      })
    end,
}
