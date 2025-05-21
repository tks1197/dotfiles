-- https://github.com/echasnovski/mini.nvim
return {
  'echasnovski/mini.nvim',
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [']quote
    --  - ci'  - [C]hange [I]nside [']quote
    local gen_ai_spec = require('mini.extra').gen_ai_spec
    require('mini.ai').setup {
      -- Table with textobject id as fields, textobject specification as values.
      -- Also use this to disable builtin textobjects. See |MiniAi.config|.
      custom_textobjects = {
        {
          B = gen_ai_spec.buffer(),
          D = gen_ai_spec.diagnostic(),
          I = gen_ai_spec.indent(),
          L = gen_ai_spec.line(),
          N = gen_ai_spec.number(),
          J = { { '()%d%d%d%d%-%d%d%-%d%d()', '()%d%d%d%d%/%d%d%/%d%d()' } },
        },
      },
    }

    require('mini.bracketed').setup()
    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup {
      n_lines = 200,
    }
    -- do not load mini.clue, mini.diff, mini.statusline in VSCode
    if not vim.g.vscode then
      local miniclue = require 'mini.clue'
      miniclue.setup {
        window = {
          delay = 200,
          config = {
            width = 45,
            height = 25,
          },
        },
        triggers = {
          -- Leader triggers
          { mode = 'n', keys = '<Leader>' },
          { mode = 'x', keys = '<Leader>' },

          -- Built-in completion
          { mode = 'i', keys = '<C-x>' },

          -- `g` key
          { mode = 'n', keys = 'g' },
          { mode = 'x', keys = 'g' },

          -- Marks
          { mode = 'n', keys = "'" },
          { mode = 'n', keys = '`' },
          { mode = 'x', keys = "'" },
          { mode = 'x', keys = '`' },
          -- Registers
          { mode = 'n', keys = '"' },
          { mode = 'x', keys = '"' },
          { mode = 'i', keys = '<C-r>' },
          { mode = 'c', keys = '<C-r>' },
          -- bracketed commands
          { mode = 'n', keys = '[' },
          { mode = 'n', keys = ']' },
          -- Window commands
          { mode = 'n', keys = '<C-w>' },

          -- `z` key
          { mode = 'n', keys = 'z' },
          { mode = 'x', keys = 'z' },
        },

        clues = {
          -- Enhance this by adding descriptions for <Leader> mapping groups
          miniclue.gen_clues.builtin_completion(),
          miniclue.gen_clues.g(),
          miniclue.gen_clues.marks(),
          miniclue.gen_clues.registers(),
          miniclue.gen_clues.windows(),
          miniclue.gen_clues.z(),
          { mode = 'n', keys = '<Leader>s', desc = '+Search' },
        },
      }

      require('mini.diff').setup()
      --
      -- require('mini.git').setup()

      local ministatusline = require 'mini.statusline'

      ministatusline.custom_section_git = function()
        if vim.fn.exists 'g:loaded_fugitive' == 1 then
          return vim.fn.FugitiveStatusline()
        end
        return ''
      end
      local statusline_config = function()
        local mode, mode_hl = ministatusline.section_mode { trunc_width = 120 }
        local git = ministatusline.custom_section_git()
        -- local diff = ministatusline.section_diff({ trunc_width = 75 })
        -- local diagnostics = ministatusline.section_diagnostics({ trunc_width = 75 })
        -- local lsp = ministatusline.section_lsp({ trunc_width = 75 })
        local filename = ministatusline.section_filename { trunc_width = 140 }
        local fileinfo = ministatusline.section_fileinfo { trunc_width = 75 }
        local location = ministatusline.section_location { trunc_width = 200 }
        local search = ministatusline.section_searchcount { trunc_width = 75 }

        return ministatusline.combine_groups {
          { hl = mode_hl, strings = { mode } },
          { hl = 'MiniStatuslineDevinfo', strings = { git } },
          '%<', -- Mark general truncate point
          { hl = 'MiniStatuslineFilename', strings = { filename } },
          '%=', -- End left alignment
          { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
          { hl = mode_hl, strings = { search, location } },
        }
      end

      ministatusline.setup {
        content = {
          active = statusline_config,
          inactive = statusline_config,
        },
      }
    end

    -- autopairs
    require('mini.pairs').setup {
      -- In which modes mappings from this `config` should be created
      modes = { insert = true, command = false, terminal = false },

      -- Global mappings. Each right hand side should be a pair information, a
      -- table with at least these fields (see more in |MiniPairs.map|):
      -- - <action> - one of "open", "close", "closeopen".
      -- - <pair> - two character string for pair to be used.
      -- By default pair is not inserted after `\`, quotes are not recognized by
      -- `<CR>`, `'` does not insert pair after a letter.
      -- Only parts of tables can be tweaked (others will use these defaults).
      -- Supply `false` instead of table to not map particular key.
      mappings = {
        ['('] = { action = 'open', pair = '()', neigh_pattern = '[^\\].' },
        ['['] = { action = 'open', pair = '[]', neigh_pattern = '[^\\].' },
        ['{'] = { action = 'open', pair = '{}', neigh_pattern = '[^\\].' },

        [')'] = { action = 'close', pair = '()', neigh_pattern = '[^\\].' },
        [']'] = { action = 'close', pair = '[]', neigh_pattern = '[^\\].' },
        ['}'] = { action = 'close', pair = '{}', neigh_pattern = '[^\\].' },

        ['"'] = { action = 'closeopen', pair = '""', neigh_pattern = '[^\\].', register = { cr = false } },
        ["'"] = { action = 'closeopen', pair = "''", neigh_pattern = '[^%a\\].', register = { cr = false } },
        ['`'] = { action = 'closeopen', pair = '``', neigh_pattern = '[^\\].', register = { cr = false } },
      },
    }
  end,
}
