return {
  {
    'olimorris/codecompanion.nvim',
    enabled = true,
    dependencies = {
      'j-hui/fidget.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    keys = {
      {
        '<Space>cf',
        ':CodeCompanion<CR>',
        mode = { 'n', 'v' },
        desc = 'CodeCompanion',
        silent = true,
      },
      {
        '<Space>cc',
        ':CodeCompanionChat<CR>',
        mode = { 'n', 'v' },
        desc = 'CodeCompanionChat',
        silent = true,
      },
      {
        '<Space>ca',
        ':CodeCompanionAction<CR>',
        mode = { 'n', 'v' },
        desc = 'CodeCompanionAction',
        silent = true,
      },
    },
    config = function()
      require('codecompanion.fidget-spinner'):init()
      require('codecompanion').setup({
        opts = {
          language = 'Japanese',
        },
        display = {
          chat = {
            auto_scroll = false,
            show_header_separator = true,
          },
        },
        cmd = {
          adapter = 'copilot',
        },
        adapters = {
          copilot = function()
            return require('codecompanion.adapters').extend('copilot', {
              schema = {
                model = {
                  default = 'claude-3.7-sonnet',
                },
              },
            })
          end,
        },
        strategies = {
          chat = {
            adapter = 'copilot',
            roles = {
              llm = function(adapter)
                return '  CodeCompanion (' .. adapter.formatted_name .. ')'
              end,
              user = '  Me',
            },
          },
          inline = {
            adapter = 'copilot',
            keymaps = {
              accept_change = {
                modes = { n = 'ga' },
                description = 'Accept the suggested change',
              },
              reject_change = {
                modes = { n = 'gr' },
                description = 'Reject the suggested change',
              },
            },
          },
        },
      })
    end,
  },
  -- copilot.lua(github copilot plugin)
  -- https://github.com/zbirenbaum/copilot.lua
  {
    'zbirenbaum/copilot.lua',
    lazy = true,
    cmd = 'Copilot',
    build = ':Copilot auth',
    event = 'InsertEnter',
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
    },
  },
}
