return {
  {
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewFileHistory' },
    enabled = false,
    event = 'VeryLazy',
    init = function()
      vim.opt.diffopt = {
        'internal',
        'filler',
        'closeoff',
        'context:12',
        'algorithm:histogram',
        'linematch:200',
        'indent-heuristic',
      }
    end,
    config = function()
      local function toggle_diffview(cmd)
        if next(require('diffview.lib').views) == nil then
          vim.cmd(cmd)
        else
          vim.cmd('DiffviewClose')
        end
      end
      vim.keymap.set('n', '<leader>hh', function()
        toggle_diffview('DiffviewFileHistory')
      end, { desc = 'Repo history' })
      vim.keymap.set('n', '<leader>hf', function()
        toggle_diffview('DiffviewFileHistory --follow .')
      end, { desc = 'File history' })
      vim.keymap.set('n', '<leader>hl', function()
        toggle_diffview('DiffviewFileHistory --follow')
      end, { desc = 'Line history' })
      vim.keymap.set('n', '<leader>hd', function()
        toggle_diffview('DiffviewOpen')
      end, { desc = 'Repo diff' })
      vim.keymap.set('n', '<leader>hc', '<Cmd>DiffviewClose<CR>', { desc = 'Close Diffview' })

      local function get_default_branch_name()
        local res = vim.system({ 'git', 'rev-parse', '--verify', 'main' }, { capture_output = true }):wait()
        return res.code == 0 and 'main' or 'master'
      end
      vim.keymap.set('n', '<leader>hm', function()
        toggle_diffview('DiffviewOpen ' .. get_default_branch_name())
      end, { desc = 'Diff against master' })

      vim.keymap.set('n', '<leader>hM', function()
        toggle_diffview('DiffviewOpen HEAD..origin/' .. get_default_branch_name())
      end, { desc = 'Diff against origin/master' })
    end,
  },
  { 'tpope/vim-fugitive', event = 'VeryLazy', cmd = 'Git' },
  -- { 'tpope/vim-rhubarb', event = 'VeryLazy' },
}
