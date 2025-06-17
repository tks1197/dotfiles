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
            on_win = function(self)
              -- Send bindkey command only when terminal is first created
              vim.schedule(function()
                if self.buf and vim.api.nvim_buf_is_valid(self.buf) then
                  local job_id = vim.b[self.buf].terminal_job_id
                  if job_id and not vim.b[self.buf].bindkey_sent then
                    -- Send the bindkey command for zsh autosuggestion
                    vim.fn.chansend(job_id, "bindkey '^F' autosuggest-accept\n")
                    vim.b[self.buf].bindkey_sent = true
                  end
                end
              end)
            end,
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
