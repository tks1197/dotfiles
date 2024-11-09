# https://neovim.io/doc/user/lua.html#vim.loader
vim.loader.enable()

require 'config.options'
require 'config.lazy'
vim.api.nvim_create_autocmd('User', {
  pattern = 'VeryLazy',
  callback = function()
    require 'config.autocmds'
    require 'config.keymaps'
  end,
})

