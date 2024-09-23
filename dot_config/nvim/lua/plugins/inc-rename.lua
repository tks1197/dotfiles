-- inc-rename.nvim
-- https://github.com/smjonas/inc-rename.nvim
-- lspのrenameをpreviewするプラグイン。
return {
  'smjonas/inc-rename.nvim',
  config = function()
    require('inc_rename').setup {
      input_buffer_type = 'dressing',
    }
    vim.keymap.set('n', '<leader>rn', function()
      return ':IncRename ' .. vim.fn.expand '<cword>'
    end, { expr = true })
  end,
}
