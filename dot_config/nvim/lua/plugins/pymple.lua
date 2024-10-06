-- pymple.nvim
-- Refactor Python imports on file move/rename in Neovim
-- https://github.com/alexpasmantier/pymple.nvim
return {
	{
		"alexpasmantier/pymple.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			-- optional (nicer ui)
			"stevearc/dressing.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		build = ":PympleBuild",
		config = function()
			require("pymple").setup()
		end,
	},
}
