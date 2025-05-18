return {
  {
    'tpope/vim-fugitive',
    -- lazy = true,
    cmd = { 'G', 'Git' },
    config = function()
      -- :Git -c pager.diff=delta diff
      vim.api.nvim_create_user_command('GDelta', function(args)
        local vimCmd = 'Git -c pager.diff=delta diff'
        if args['args'] then
          vimCmd = vimCmd .. ' ' .. args['args']
        end
        vim.cmd(vimCmd)
      end, { desc = 'Git Diff for Delta', nargs = '*' })
    end,
  },
  -- { 'tpope/vim-rhubarb', event = 'VeryLazy' },
}
