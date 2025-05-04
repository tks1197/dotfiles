return {
  'uga-rosa/translate.nvim',
  lazy = true,
  event = 'VeryLazy',
  config = function()
    vim.keymap.set({ 'n', 'v' }, 'gT', '<cmd>Translate ja<CR>', { noremap = true, desc = 'translate japanese' })
  end,
}
