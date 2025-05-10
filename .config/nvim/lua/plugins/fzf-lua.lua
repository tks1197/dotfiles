-- https://github.com/ibhagwan/fzf-lua
return {
  'ibhagwan/fzf-lua',
  event = 'VeryLazy',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local fzf_lua = require 'fzf-lua'
    fzf_lua.setup {
      lsp = {
        -- https://github.com/nvimtools/none-ls.nvim/wiki/Compatibility-with-other-plugins#fzf-lua
        async_or_timeout = 3000,
        code_actions = {
          winopts = {
            relative = 'cursor',
            width = 0.6,
            height = 0.6,
            row = 1,
            preview = { vertical = 'up:70%' },
          },
        },
      },
      files = {
        cwd_prompt = false,
      },
      oldfiles = {
        include_current_session = true,
        stat_file = true,
      },
      previewers = {
        fzf_lua = {
          syntax_limit_b = 1024 * 100, -- 100KB
        },
      },
      keymap = {
        fzf = {
          ['ctrl-q'] = 'select-all+accept',
        },
        fzf_lua = {
          { true, ['<Esc>'] = 'hide' },
        },
      },
    }
    -- https://github.com/ibhagwan/fzf-lua/wiki#automatic-sizing-of-heightwidth-of-vimuiselect
    fzf_lua.register_ui_select(function(_, items)
      local min_h, max_h = 0.15, 0.70
      local h = (#items + 4) / vim.o.lines
      if h < min_h then
        h = min_h
      elseif h > max_h then
        h = max_h
      end
      return { winopts = { height = h, width = 0.60, row = 0.40 } }
    end)
    vim.keymap.set('n', '<leader>sh', fzf_lua.helptags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sm', fzf_lua.marks, { desc = '[S]earch [M]arks' })
    vim.api.nvim_set_keymap('n', '<leader>dm', ':delmarks a-zA-Z0-9<CR>', { noremap = true, silent = true, desc = '[D]elete all [M]arks' })
    vim.keymap.set('n', '<leader>sr', fzf_lua.registers, { desc = '[S]earch [R]egisters' })
    vim.keymap.set('n', '<leader>sf', fzf_lua.files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>sk', fzf_lua.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sg', fzf_lua.live_grep_native, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sb', fzf_lua.buffers, { desc = '[S]earch [B]uffers' })
    vim.keymap.set('n', '<leader>sd', fzf_lua.diagnostics_document, { desc = '[S]earch [D]ocument Diagnostics' })
    vim.keymap.set('n', '<leader>sw', fzf_lua.diagnostics_workspace, { desc = '[S]earch [W]orkspace Diagnostics' })
    vim.keymap.set('n', '<leader>/', function()
      require('fzf-lua').lgrep_curbuf {
        winopts = {
          preview = {
            hidden = 'hidden',
          },
        },
      }
    end, { desc = '[S]earch Current Buffer' })
    vim.keymap.set('n', 'gd', function()
      fzf_lua.lsp_definitions {
        sync = true,
        jump1 = true,
      }
    end, { desc = '[G]oto [D]efinition' })
    -- Find references for the word under your cursor.
    vim.keymap.set('n', 'gr', fzf_lua.lsp_references, { desc = '[G]oto [R]eferences' })
    -- Jump to the implementation of the word under your cursor.
    vim.keymap.set('n', 'gI', fzf_lua.lsp_implementations, { desc = '[G]oto [I]mplementation' })
    -- Jump to the type of the word under your cursor.
    vim.keymap.set('n', '<leader>D', fzf_lua.lsp_typedefs, { desc = 'Type [D]efinition' })
    -- Fuzzy find all the symbols in your current document.
    vim.keymap.set('n', '<leader>ds', fzf_lua.lsp_document_symbols, { desc = '[D]ocument [S]ymbols' })
    -- Fuzzy find all the symbols in your current workspace.
    vim.keymap.set('n', '<leader>ws', fzf_lua.lsp_workspace_symbols, { desc = '[W]orkspace [S]ymbols' })
  end,
}
