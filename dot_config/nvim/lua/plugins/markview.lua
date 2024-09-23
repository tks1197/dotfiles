-- markview.nvim
-- markdownファイルのpreviewをするためのプラグイン。
-- https://github.com/OXY2DEV/markview.nvim
return {
  'OXY2DEV/markview.nvim',
  lazy = false, -- Recommended
  enabled = false,
  -- ft = "markdown" -- If you decide to lazy-load anyway
  modes = { 'n', 'no', 'c' }, -- Change these modes
  -- to what you need

  hybrid_modes = { 'n' }, -- Uses this feature on
  -- normal mode

  -- This is nice to have
  callbacks = {
    on_enable = function(_, win)
      vim.wo[win].conceallevel = 2
      vim.wo[win].concealcursor = 'c'
    end,
  },
  dependencies = {
    -- You will not need this if you installed the
    -- parsers manually
    -- Or if the parsers are in your $RUNTIMEPATH
    'nvim-treesitter/nvim-treesitter',

    'nvim-tree/nvim-web-devicons',
  },
}
