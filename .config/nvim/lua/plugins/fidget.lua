return {
  'j-hui/fidget.nvim',
  cond = function()
    return not vim.g.vscode
  end,
  opts = {
    notification = {
      override_vim_notify = true, -- Override vim.notify with Fidget's notification system
    },
  },
}
