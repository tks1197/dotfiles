return {
  'aserowy/tmux.nvim',
  event = 'VeryLazy',
  config = function()
    require('tmux').setup({
      copy_sync = {
        redirect_to_clipboard = true,
      },
    })
  end,
}
