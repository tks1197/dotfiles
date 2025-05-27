return {
  {
    'm4xshen/hardtime.nvim',
    enabled = false,
    lazy = false,
    dependencies = { 'MunifTanjim/nui.nvim' },
    opts = {},
    cond = function()
      return not vim.g.vscode
    end,
  },
  {
    'tris203/precognition.nvim',
    enabled = false,
    event = 'VeryLazy',
    opts = {
      startVisible = true,
      showBlankVirtLine = true,
    },
    cond = function()
      return not vim.g.vscode
    end,
  },
}
