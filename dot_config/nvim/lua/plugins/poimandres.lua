return {
	"olivercederborg/poimandres.nvim",
	lazy = false,
	enabled = false,
	priority = 1000,
	config = function()
		local p = require("poimandres.palette")
		require("poimandres").setup({
			-- leave this setup function empty for default config
			-- or refer to the configuration section
			-- for configuration options
			--  https://github.com/olivercederborg/poimandres.nvim/issues/44#issue-2354595430
			highlight_groups = {
				LspReferenceText = { bg = p.background1 },
				LspReferenceRead = { bg = p.background1 },
				LspReferenceWrite = { bg = p.background1 },
			},
		})
	end,

	-- optionally set the colorscheme within lazy config
	init = function()
		vim.cmd("colorscheme poimandres")
	end,
}
