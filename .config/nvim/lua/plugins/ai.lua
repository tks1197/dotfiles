return {
  {
    'greggh/claude-code.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim', -- Required for git operations
    },
    config = function()
      require('claude-code').setup {
        -- Terminal window settings
        window = {
          split_ratio = 0.4, -- Percentage of screen for the terminal window (height for horizontal, width for vertical splits)
          position = 'vertical', -- Position of the window: "botright", "topleft", "vertical", "rightbelow vsplit", etc.
          enter_insert = true, -- Whether to enter insert mode when opening Claude Code
          hide_numbers = true, -- Hide line numbers in the terminal window
          hide_signcolumn = true, -- Hide the sign column in the terminal window
        },
        -- File refresh settings
        refresh = {
          enable = true, -- Enable file change detection
          updatetime = 100, -- updatetime when Claude Code is active (milliseconds)
          timer_interval = 1000, -- How often to check for file changes (milliseconds)
          show_notifications = true, -- Show notification when files are reloaded
        },
        -- Git project settings
        git = {
          use_git_root = true, -- Set CWD to git root when opening Claude Code (if in git project)
        },
        -- Command settings
        command = 'claude', -- Command used to launch Claude Code
        -- Command variants
        command_variants = {
          -- Conversation management
          continue = '--continue', -- Resume the most recent conversation
          resume = '--resume', -- Display an interactive conversation picker

          -- Output options
          verbose = '--verbose', -- Enable verbose logging with full turn-by-turn output
        },
        -- Keymaps
        keymaps = {
          toggle = {
            normal = '<C-,>', -- Normal mode keymap for toggling Claude Code, false to disable
            terminal = '<C-,>', -- Terminal mode keymap for toggling Claude Code, false to disable
            -- variants = {
            --   continue = '<leader>cC', -- Normal mode keymap for Claude Code with continue flag
            --   verbose = '<leader>cV', -- Normal mode keymap for Claude Code with verbose flag
            -- },
          },
          window_navigation = true, -- Enable window navigation keymaps (<C-h/j/k/l>)
          scrolling = true, -- Enable scrolling keymaps (<C-f/b>) for page up/down
        },
      }
    end,
  },
  {
    'willothy/flatten.nvim',
    config = true,
    -- or pass configuration with
    -- opts = {  }
    -- Ensure that it runs first to minimize delay when opening file from terminal
    lazy = false,
    priority = 1001,
  },
  --- ...,
  {
    'GeorgesAlkhouri/nvim-aider',
    lazy = true,
    cmd = 'Aider',
    cond = function()
      return not vim.g.vscode
    end,
    init = function()
      vim.o.autoread = true
    end,
    dependencies = {
      'folke/snacks.nvim',
    },
    config = function()
      require('nvim_aider').setup {
        auto_reload = true,
        args = {
          '--no-auto-commits',
          '--pretty',
          '--stream',
          '--watch-files',
        },
        win = {
          position = 'left',
        },
      }
    end,
    -- Example key mappings for common actions:
    -- add config
    -- keys = {
    --   { '<leader>a/', '<cmd>Aider toggle<cr>', desc = 'Toggle Aider' },
    --   { '<leader>as', '<cmd>Aider send<cr>', desc = 'Send to Aider', mode = { 'n', 'v' } },
    --   { '<leader>ac', '<cmd>Aider command<cr>', desc = 'Aider Commands' },
    --   { '<leader>ab', '<cmd>Aider buffer<cr>', desc = 'Send Buffer' },
    --   { '<leader>a+', '<cmd>Aider add<cr>', desc = 'Add File' },
    --   { '<leader>a-', '<cmd>Aider drop<cr>', desc = 'Drop File' },
    --   { '<leader>ar', '<cmd>Aider add readonly<cr>', desc = 'Add Read-Only' },
    --   { '<leader>aR', '<cmd>Aider reset<cr>', desc = 'Reset Session' },
    --   -- Example nvim-tree.lua integration if needed
    --   { '<leader>a+', '<cmd>AiderTreeAddFile<cr>', desc = 'Add File from Tree to Aider', ft = 'NvimTree' },
    --   { '<leader>a-', '<cmd>AiderTreeDropFile<cr>', desc = 'Drop File from Tree from Aider', ft = 'NvimTree' },
    -- },
  },
  {
    'zbirenbaum/copilot.lua',
    lazy = true,
    cmd = 'Copilot',
    event = 'InsertEnter',
    build = ':Copilot auth',
    cond = function()
      return not vim.g.vscode
    end,
    config = function()
      require('copilot').setup {
        suggestion = {
          auto_trigger = true,
          hide_during_completion = false,
          keymap = {
            accept = '<Tab>',
          },
        },
        filetypes = {
          org = false,
          markdown = false,
          gitcommit = true,
          ['*'] = function()
            -- disable for files with specific names
            local fname = vim.fs.basename(vim.api.nvim_buf_get_name(0))
            local disable_patterns = { 'env', 'conf', 'local', 'private' }
            return vim.iter(disable_patterns):all(function(pattern)
              return not string.match(fname, pattern)
            end)
          end,
        },
      }
      -- set CopilotSuggestion as underlined comment
      local hl = vim.api.nvim_get_hl(0, { name = 'Comment' })
      vim.api.nvim_set_hl(0, 'CopilotSuggestion', vim.tbl_extend('force', hl, { underline = true }))
    end,
  },
}
