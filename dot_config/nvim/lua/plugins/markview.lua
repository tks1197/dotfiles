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
	lazy = false, -- Recommended
	-- ft = "markdown" -- If you decide to lazy-load anyway
	modes = { "n", "no", "c" }, -- Change these modes
	-- to what you need
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
	hybrid_modes = { "n" }, -- Uses this feature on
	-- normal mode

	-- This is nice to have
	callbacks = {
		on_enable = function(_, win)
			vim.wo[win].conceallevel = 2
			vim.wo[win].concealcursor = "c"
		end,
	},
	dependencies = {
		-- You will not need this if you installed the
		-- parsers manually
		-- Or if the parsers are in your $RUNTIMEPATH
		"nvim-treesitter/nvim-treesitter",

		"nvim-tree/nvim-web-devicons",
	},
}
