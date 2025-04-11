return {
  'zk-org/zk-nvim',
  config = function()
    local zk = require('zk')
    local commands = require('zk.commands')
    commands.add('ZkDaily', function(options)
      options = vim.tbl_extend(
        'force',
        { dir = 'journal/daily', group = 'daily', template = 'daily.md', edit = true },
        options or {}
      )
      zk.new(options)
    end)
    vim.keymap.set({ 'n' }, '<leader>zd', '<Cmd>ZkDaily<CR>', { desc = 'Open Daily Note' })
    zk.setup()
  end,
}
