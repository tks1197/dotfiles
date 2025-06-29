return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  cond = function()
    return not vim.g.vscode
  end,
  keys = {
    {
      'gt',
      function()
        local term = Snacks.terminal.toggle(nil, {
          win = {
            position = 'float',
            border = 'rounded',
          },
        })
      end,
      mode = { 'n', 't' },
      { desc = 'Toggle Terminal' },
    },
  },
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    scratch = { enabled = true },
    input = { enabled = true },
    scroll = { enabled = true },
    bigfile = { enabled = true },
    notifier = { enabled = false },
    bufdelete = { enabled = true },
    terminal = { enabled = true },
    quickfile = { enabled = true },
    -- statuscolumn = { enabled = true },
    words = { enabled = true },
  },
}
