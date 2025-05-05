return {
  {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    -- version = '*', -- Never set this value to "*"! Never!
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = 'make',
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      --- The below dependencies are optional,
      'ibhagwan/fzf-lua', -- for file_selector provider fzf
      'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
      'zbirenbaum/copilot.lua', -- for providers='copilot'
      'ravitemer/mcphub.nvim',
    },
    opts = {
      -- add any opts here
      -- for example
      provider = 'copilot',
      copilot = {
        model = 'claude-3.7-sonnet', -- your desired model (or use gpt-4o, etc.)
        timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
        temperature = 0,
        max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
        --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
      },
      openai = {
        endpoint = 'https://api.openai.com/v1',
        model = 'gpt-4o', -- your desired model (or use gpt-4o, etc.)
        timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
        temperature = 0,
        max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
        --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
      },
      -- The system_prompt type supports both a string and a function that returns a string. Using a function here allows dynamically updating the prompt with mcphub
      system_prompt = function()
        local hub = require('mcphub').get_hub_instance()
        return hub:get_active_servers_prompt()
      end,
      -- The custom_tools type supports both a list and a function that returns a list. Using a function here prevents requiring mcphub before it's loaded
      custom_tools = function()
        return {
          require('mcphub.extensions.avante').mcp_tool(),
        }
      end,
      disabled_tools = {
        'list_files',
        'search_files',
        'read_file',
        'create_file',
        'rename_file',
        'delete_file',
        'create_dir',
        'rename_dir',
        'delete_dir',
        'bash',
      },
      selector = {
        --- @alias avante.SelectorProvider "native" | "fzf_lua" | "mini_pick" | "snacks" | "telescope" | fun(selector: avante.ui.Selector): nil
        provider = 'fzf_lua',
        -- Options override for custom providers
        provider_opts = {},
      },
    },
  },
  -- {
  --   'olimorris/codecompanion.nvim',
  --   enabled = true,
  --   dependencies = {
  --     'j-hui/fidget.nvim',
  --     'nvim-lua/plenary.nvim',
  --     'ravitemer/mcphub.nvim',
  --     'nvim-treesitter/nvim-treesitter',
  --     'Davidyz/VectorCode',
  --   },
  --   cmd = { 'CodeCompanion', 'CodeCompanionActions', 'CodeCompanionChat' },
  --   keys = {
  --     { '<Space>cc', '<Cmd>CodeCompanionChat Toggle<CR>', mode = { 'n' } },
  --     { '<Space>cc', '<Cmd>CodeCompanionChat<CR>', mode = { 'v' } },
  --     { '<Space>ca', '<Cmd>CodeCompanionActions<CR>', mode = { 'n', 'x' } },
  --   },
  --   config = function()
  --     require('codecompanion.fidget-spinner'):init()
  --     require('codecompanion').setup {
  --       opts = {
  --         language = 'Japanese',
  --       },
  --       display = {
  --         chat = {
  --           auto_scroll = false,
  --           show_header_separator = true,
  --         },
  --       },
  --       cmd = {
  --         adapter = 'copilot',
  --       },
  --       adapters = {
  --         copilot = function()
  --           return require('codecompanion.adapters').extend('copilot', {
  --             schema = {
  --               model = {
  --                 default = 'claude-3.7-sonnet',
  --               },
  --             },
  --           })
  --         end,
  --       },
  --       strategies = {
  --         chat = {
  --           adapter = 'copilot',
  --           slash_commands = {
  --             -- add the vectorcode command here.
  --             codebase = require('vectorcode.integrations').codecompanion.chat.make_slash_command(),
  --           },
  --           roles = {
  --             llm = function(adapter)
  --               return '  CodeCompanion (' .. adapter.formatted_name .. ')'
  --             end,
  --             user = '  Me',
  --           },
  --         },
  --         inline = {
  --           adapter = 'copilot',
  --           keymaps = {
  --             accept_change = {
  --               modes = { n = 'ga' },
  --               description = 'Accept the suggested change',
  --             },
  --             reject_change = {
  --               modes = { n = 'gr' },
  --               description = 'Reject the suggested change',
  --             },
  --           },
  --         },
  --       },
  --       extensions = {
  --         mcphub = {
  --           callback = 'mcphub.extensions.codecompanion',
  --           opts = {
  --             show_result_in_chat = true, -- Show mcp tool results in chat
  --             make_vars = true, -- Convert resources to #variables
  --             make_slash_commands = true, -- Add prompts as /slash commands
  --           },
  --         },
  --         vectorcode = {
  --           opts = { add_tool = true, add_slash_command = true, tool_opts = {} },
  --         },
  --       },
  --     }
  --   end,
  -- },
  -- -- copilot.lua(github copilot plugin)
  -- -- https://github.com/zbirenbaum/copilot.lua
  -- {
  --   'zbirenbaum/copilot.lua',
  --   lazy = true,
  --   cmd = 'Copilot',
  --   build = ':Copilot auth',
  --   event = 'InsertEnter',
  --   opts = {
  --     suggestion = { enabled = false },
  --     panel = { enabled = false },
  --   },
  -- },
  -- {
  --   'Davidyz/VectorCode',
  --   version = '*', -- optional, depending on whether you're on nightly or release
  --   build = 'uv tool upgrade vectorcode', -- optional but recommended. This keeps your CLI up-to-date.
  --   dependencies = { 'nvim-lua/plenary.nvim' },
  -- },
  {
    'ravitemer/mcphub.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim', -- Required for Job and HTTP requests
    },
    cmd = 'MCPHub', -- lazily start the hub when `MCPHub` is called
    build = 'npm install -g mcp-hub@latest', -- Installs required mcp-hub npm module
    config = true,
  },
}
