vim.loader.enable()

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require 'core.options'
require 'core.lazy'
vim.api.nvim_create_autocmd('User', {
  pattern = 'VeryLazy',
  callback = function()
    require 'core.autocmd'
    require 'core.keymaps'
  end,
})
