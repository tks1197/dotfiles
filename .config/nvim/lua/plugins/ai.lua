return {
  {
    'ravitemer/mcphub.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim', -- Required for Job and HTTP requests
    },
    cmd = 'MCPHub', -- lazily start the hub when `MCPHub` is called
    build = 'npm install -g mcp-hub@latest', -- Installs required mcp-hub npm module
    config = function()
      require('mcphub').setup {
        auto_approve = true,
      }
    end,
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
      -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    init = function()
      -- the remote file handling part
      vim.api.nvim_create_autocmd('BufEnter', {
        group = vim.api.nvim_create_augroup('RemoteFileInit', { clear = true }),
        callback = function()
          local f = vim.fn.expand '%:p'
          for _, v in ipairs { 'dav', 'fetch', 'ftp', 'http', 'rcp', 'rsync', 'scp', 'sftp' } do
            local p = v .. '://'
            if f:sub(1, #p) == p then
              vim.cmd [[
              unlet g:loaded_netrw
              unlet g:loaded_netrwPlugin
              runtime! plugin/netrwPlugin.vim
              silent Explore %
            ]]
              break
            end
          end
          vim.api.nvim_clear_autocmds { group = 'RemoteFileInit' }
        end,
      })
      vim.api.nvim_create_autocmd('BufEnter', {
        group = vim.api.nvim_create_augroup('NeoTreeInit', { clear = true }),
        callback = function()
          local f = vim.fn.expand '%:p'
          if vim.fn.isdirectory(f) ~= 0 then
            vim.cmd('Neotree current dir=' .. f)
            vim.api.nvim_clear_autocmds { group = 'NeoTreeInit' }
          end
        end,
      })
      -- keymaps
    end,
    config = function()
      vim.keymap.set('n', 'gn', '<cmd>Neotree toggle<CR>', { desc = 'Toggle Neotree' })
      require('neo-tree').setup {
        filesystem = {
          hijack_netrw_behavior = 'open_current',
          commands = {
            avante_add_files = function(state)
              local node = state.tree:get_node()
              local filepath = node:get_id()
              local relative_path = require('avante.utils').relative_path(filepath)

              local sidebar = require('avante').get()

              local open = sidebar:is_open()
              -- ensure avante sidebar is open
              if not open then
                require('avante.api').ask()
                sidebar = require('avante').get()
              end

              sidebar.file_selector:add_selected_file(relative_path)

              -- remove neo tree buffer
              if not open then
                sidebar.file_selector:remove_selected_file 'neo-tree filesystem [1]'
              end
            end,
          },
          follow_current_file = {
            enabled = true, -- This will find and focus the file in the active buffer every time
            --               -- the current file is changed while the tree is open.
            leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
          },
          filtered_items = {
            visible = true,
          },
          window = {
            mappings = {
              ['oa'] = 'avante_add_files',
              h = function(state)
                local node = state.tree:get_node()
                if (node.type == 'directory' or node:has_children()) and node:is_expanded() then
                  state.commands.toggle_node(state)
                else
                  require('neo-tree.ui.renderer').focus_node(state, node:get_parent_id())
                end
              end,
              l = function(state)
                local node = state.tree:get_node()
                if node.type == 'directory' or node:has_children() then
                  if not node:is_expanded() then
                    state.commands.toggle_node(state)
                  else
                    require('neo-tree.ui.renderer').focus_node(state, node:get_child_ids()[1])
                  end
                end
              end,
              ['<tab>'] = function(state)
                local node = state.tree:get_node()
                if require('neo-tree.utils').is_expandable(node) then
                  state.commands['toggle_node'](state)
                else
                  state.commands['open'](state)
                  vim.cmd 'Neotree reveal'
                end
              end,
            },
          },
        },
      }
    end,
  },
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
        model = 'gpt-4o', -- your desired model (or use gpt-4o, etc.)
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
      windows = {
        ---@type "right" | "left" | "top" | "bottom"
        position = 'right', -- the position of the sidebar
        wrap = true, -- similar to vim.o.wrap
        width = 50, -- default % based on available width
        sidebar_header = {
          enabled = false, -- true, false to enable/disable the header
          align = 'left', -- left, center, right for title
          rounded = false,
        },
        input = {
          prefix = '> ',
          height = 8, -- Height of the input window in vertical layout
        },
        edit = {
          border = 'rounded',
          start_insert = false, -- Start insert mode when opening the edit window
        },
        ask = {
          floating = false, -- Open the 'AvanteAsk' prompt in a floating window
          start_insert = false, -- Start insert mode when opening the ask window
          border = 'rounded',
          ---@type "ours" | "theirs"
          focus_on_apply = 'ours', -- which diff to focus after applying
        },
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
  {
    'zbirenbaum/copilot.lua',
    lazy = true,
    cmd = 'Copilot',
    build = ':Copilot auth',
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
    },
  },
}
