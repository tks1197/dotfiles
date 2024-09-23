-- hlchunk.nvim
-- https://github.com/sllRaining/hlchunk.nvim
-- インデントガイド用のplugin
return {
  'shellRaining/hlchunk.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    require('hlchunk').setup {
      chunk = {
        enable = true,
        style = '#00ffff',
      },
      indent = {
        enable = true,
      },
      blank = {
        enable = true,
        chars = {
          ' ',
        },
        style = {
          { bg = '#434437' },
          { bg = '#2f4440' },
          { bg = '#433054' },
          { bg = '#284251' },
        },
      },
      line_num = {
        enable = false,
      },
    }
  end,
}
