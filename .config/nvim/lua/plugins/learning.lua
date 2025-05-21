return {
  {
    'm4xshen/hardtime.nvim',
    lazy = false,
    dependencies = { 'MunifTanjim/nui.nvim' },
    opts = {},
    cond = function()
      return not vim.g.vscode
    end,
  },
  {
    'tris203/precognition.nvim',
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
