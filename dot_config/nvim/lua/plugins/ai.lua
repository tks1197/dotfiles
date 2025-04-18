return {
  {
    'olimorris/codecompanion.nvim',
    enabled = true,
    dependencies = {
      'j-hui/fidget.nvim',
      'nvim-lua/plenary.nvim',
      'ravitemer/mcphub.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    cmd = { 'CodeCompanion', 'CodeCompanionActions', 'CodeCompanionChat' },
    keys = {
      { '<Space>cc', '<Cmd>CodeCompanionChat Toggle<CR>', mode = { 'n' } },
      { '<Space>cc', '<Cmd>CodeCompanionChat<CR>', mode = { 'v' } },
      { '<Space>ca', '<Cmd>CodeCompanionActions<CR>', mode = { 'n', 'x' } },
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
            tools = {
              ['mcp'] = {
                callback = function()
                  return require('mcphub.extensions.codecompanion')
                end,
                description = 'Call tools and resources from the MCP Servers',
              },
            },
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
  {
    'ravitemer/mcphub.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim', -- Required for Job and HTTP requests
    },
    -- cmd = "MCPHub", -- lazily start the hub when `MCPHub` is called
    build = 'npm install -g mcp-hub@latest', -- Installs required mcp-hub npm module
    config = function()
      require('mcphub').setup({
        extentions = {
          codecompanion = {
            -- Show the mcp tool result in the chat buffer
            show_result_in_chat = false,
            -- Make chat #variables from MCP server resources
            make_vars = true,
          },
        },
        -- Required options
        port = 3000, -- Port for MCP Hub server
        config = vim.fn.expand('~/.config/mcphub/servers.json'), -- Absolute path to config file

        -- Optional options
        on_ready = function(hub)
          -- Called when hub is ready
        end,
        on_error = function(err)
          -- Called on errors
        end,
        log = {
          level = vim.log.levels.WARN,
          to_file = false,
          file_path = nil,
          prefix = 'MCPHub',
        },
      })
    end,
  },
}
