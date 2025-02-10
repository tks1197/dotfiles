-- https://github.com/OXY2DEV/markview.nvim
return {
	"OXY2DEV/markview.nvim",
	lazy = false,
	config = function()
		local presets = require("markview.presets")

		require("markview").setup({
			markdown = {
				headings = presets.headings.glow,
				horizontal_rules = presets.horizontal_rules.dashed,
				table = presets.tables.rounded,
			},
		})
	end,
}
