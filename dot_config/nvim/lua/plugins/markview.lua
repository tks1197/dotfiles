-- markview.nvim
-- markdownファイルのpreviewをするためのプラグイン。
-- https://github.com/OXY2DEV/markview.nvim
--[[
Tips:
commandでMarkView: splitToggleとすれば現在のバッファーではなく、分割されたwindowでpreviewできる。
https://github.com/OXY2DEV/markview.nvim/issues/131
--]]
return {
	"OXY2DEV/markview.nvim",
	lazy = true,
	ft = "markdown",
	modes = { "n", "no", "c" },
	config = function()
		require("markview").setup({
			list_item = {
				marker_plus = {
					add_padding = true,

					marker = "•",
					marker_hl = "rainbow2",
				},
			},
		})
	end,
	hybrid_modes = { "n" },
	callbacks = {
		on_enable = function(_, win)
			vim.wo[win].conceallevel = 2
			vim.wo[win].concealcursor = "c"
		end,
	},
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
}
