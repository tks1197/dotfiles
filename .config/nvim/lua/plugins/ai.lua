return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    lary = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
      -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    cond = function()
      return not vim.g.vscode
    end,
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
    opts = function(_, opts)
      vim.keymap.set('n', 'gn', '<cmd>Neotree float toggle<CR>', { desc = 'Toggle Neotree' })
      opts.filesystem = {
        hijack_netrw_behavior = 'open_current',
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
      }
      require('nvim_aider.neo_tree').setup(opts)
    end,
  },
  {
    'GeorgesAlkhouri/nvim-aider',
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
    keys = {
      { '<leader>a/', '<cmd>Aider toggle<cr>', desc = 'Toggle Aider' },
      { '<leader>as', '<cmd>Aider send<cr>', desc = 'Send to Aider', mode = { 'n', 'v' } },
      { '<leader>ac', '<cmd>Aider command<cr>', desc = 'Aider Commands' },
      { '<leader>ab', '<cmd>Aider buffer<cr>', desc = 'Send Buffer' },
      { '<leader>a+', '<cmd>Aider add<cr>', desc = 'Add File' },
      { '<leader>a-', '<cmd>Aider drop<cr>', desc = 'Drop File' },
      { '<leader>ar', '<cmd>Aider add readonly<cr>', desc = 'Add Read-Only' },
      { '<leader>aR', '<cmd>Aider reset<cr>', desc = 'Reset Session' },
      -- Example nvim-tree.lua integration if needed
      { '<leader>a+', '<cmd>AiderTreeAddFile<cr>', desc = 'Add File from Tree to Aider', ft = 'NvimTree' },
      { '<leader>a-', '<cmd>AiderTreeDropFile<cr>', desc = 'Drop File from Tree from Aider', ft = 'NvimTree' },
    },
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
