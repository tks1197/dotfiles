return {
	"aserowy/tmux.nvim",
	config = function()
		require("tmux").setup({
			copy_sync = {
				redirect_to_clipboard = true,
			},
		})
	end,
}
