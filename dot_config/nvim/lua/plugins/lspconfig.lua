-- https://github.com/neovim/nvim-lspconfig
return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'saghen/blink.cmp',
    'folke/lazydev.nvim',
  },
  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-config-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        -- Rename the variable under your cursor.
        --  Most Language Servers support renaming across files, etc.
        map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

        -- Execute a code action, usually your cursor needs to be on top of an error
        -- or a suggestion from your LSP for this to activate.
        map('<leader>cA', function()
          require('fzf-lua').lsp_code_actions()
        end, '[C]ode [A]ction')

        -- Opens a popup that displays documentation about the word under your cursor
        --  See `:help K` for why this keymap.
        map('K', vim.lsp.buf.hover, 'Hover Documentation')

        -- WARN: This is not Goto Definition, this is Goto Declaration.
        --  For example, in C this would take you to the header.
        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client == nil then
          return
        end
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
              vim.api.nvim_clear_autocmds({ group = 'lsp-highlight', buffer = event2.buf })
            end,
          })
        end

        if client.name == 'ruff' then
          client.server_capabilities.hoverProvider = false
        end
        -- The following autocommand is used to enable inlay hints in your
        -- code, if the language server you are using supports them
        --
        -- This may be unwanted, since they displace some of your code
        if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
          map('<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
          end, '[T]oggle Inlay [H]ints')
        end
      end,
    })
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities())
    local servers = {
      -- clangd = {},
      -- gopls = {},
      jsonls = {},
      -- taplo(toml lsp)
      -- https://taplo.tamasfe.dev/cli/usage/language-server.html
      taplo = {},
      terraformls = {},
      -- (ruff)python lsp
      -- https://github.com/astral-sh/ruff-lsp
      -- ruff = {},
      pyright = {
        settings = {
          pyright = {
            disableOrganizeImports = true, -- Using Ruff
          },
        },
      },
      -- https://github.com/tekumara/typos-lsp
      -- typos_lsp = {
      -- 	{
      -- 		-- Logging level of the language server. Logs appear in :LspLog. Defaults to error.
      -- 		cmd_env = { RUST_LOG = "error" },
      -- 		init_options = {
      -- 			-- Custom config. Used together with a config file found in the workspace or its parents,
      -- 			-- taking precedence for settings declared in both.
      -- 			-- Equivalent to the typos `--config` cli argument.
      -- 			config = "~/.config/typos_lsp/typos.toml",
      -- 			-- How typos are rendered in the editor, can be one of an Error, Warning, Info or Hint.
      -- 			-- Defaults to error.
      -- 			diagnosticSeverity = "Error",
      -- 		},
      -- 	},
      -- },
      -- rust_analyzer = {},
      -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
      --
      -- Some languages (like typescript) have entire language plugins that can be useful:
      --    https://github.com/pmizio/typescript-tools.nvim
      --
      -- But for many setups, the LSP (`tsserver`) will work just fine
      -- tsserver = {},
      -- markdown_oxide = {
      --   capabilities = {
      --     workspace = {
      --       didChangeWatchedFiles = {
      --         dynamicRegistration = true,
      --       },
      --     },
      --   },
      -- },
      -- marksman = {},
      -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#bashls
      bashls = {},
      -- https://github.com/redhat-developer/yaml-language-server
      yamlls = {
        filetypes = { 'yaml', 'yaml.docker-compose', 'yaml.gitlab', 'ghactions' },
        settings = {
          yaml = {
            schemas = {
              ['https://raw.githubusercontent.com/aws/amazon-states-language-service/refs/heads/master/src/json-schema/bundled.json'] = '*.asl.{json,yml,yaml}',
            },
            validate = true,
            -- for cloudformation tags
            customTags = {
              '!And',
              '!And sequence',
              '!If',
              '!If sequence',
              '!Not',
              '!Not sequence',
              '!Equals',
              '!Equals sequence',
              '!Or',
              '!Or sequence',
              '!FindInMap',
              '!FindInMap sequence',
              '!Base64',
              '!Join',
              '!Join sequence',
              '!Cidr',
              '!Ref',
              '!Sub',
              '!Sub sequence',
              '!GetAtt',
              '!GetAZs',
              '!ImportValue',
              '!ImportValue sequence',
              '!Select',
              '!Select sequence',
              '!Split',
              '!Split sequence',
            },
            format = {
              enable = true,
            },
          },
        },
      },
      lua_ls = {
        -- cmd = {...},
        -- filetypes = { ...},
        -- capabilities = {},
        settings = {
          format = {
            enable = false,
          },
          Lua = {
            completion = {
              callSnippet = 'Replace',
            },
            -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
            -- diagnostics = { disable = { 'missing-fields' } },
          },
        },
      },
      -- ccls = {},
      clangd = {
        capabilities = {
          offsetEncoding = { 'utf-16' },
          textDocument = {
            completion = {
              editsNearCursor = true,
            },
          },
        },
      },
    }
    local lsp_config = require('lspconfig')
    for server_name, server in pairs(servers) do
      server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
      lsp_config[server_name].setup(server)
    end
  end,
}
