return {
	"shaunsingh/nord.nvim",
	lazy = false,
	enabled = false,
	priority = 1000,
	-- optionally set the colorscheme within lazy config
	init = function()
		vim.cmd.colorscheme("nord")
	end,
}
