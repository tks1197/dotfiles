return {
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
