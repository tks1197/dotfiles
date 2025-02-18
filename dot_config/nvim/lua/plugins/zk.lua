return {
  'zk-org/zk-nvim',
  enabled = false,
  config = function()
    require('zk').setup({
      -- See Setup section below
    })
  end,
}
