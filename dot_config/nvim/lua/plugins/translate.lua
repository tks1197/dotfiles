return {
  'uga-rosa/translate.nvim',
  lazy = true,
  cmd = 'VeryLazy',
  config = function()
    vim.keymap.set({ 'n', 'v' }, 'gT', ":'<,'>Translate ja<CR>", { noremap = true, desc = 'translate japanese' })
  end,
}
