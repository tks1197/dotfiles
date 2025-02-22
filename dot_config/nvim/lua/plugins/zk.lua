return {
  'zk-org/zk-nvim',
  enabled = true,
  config = function()
    require('zk').setup({
      -- See Setup section below
    })
  end,
}
