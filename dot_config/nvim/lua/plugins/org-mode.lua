return {
	{
		"nvim-orgmode/orgmode",
		event = "VeryLazy",
		ft = { "org" },
		config = function()
			-- Setup orgmode
			require("orgmode").setup({
				org_agenda_files = "~/Documents/org/**/*",
				org_default_notes_file = "~/Documents/org/refile.org",
				win_split_mode = "float",
				win_border = "rounded",
				org_startup_folded = "showeverything",
				ui = {
					input = {
						use_vim_ui = true,
					},
				},
				org_capture_templates = {
					t = { description = "Task(Interrupt)", template = "* TODO %?\n" },
					n = { description = "Note", template = "- %<%H:%M:%S> %?" },
				},
				mappings = {
					global = {
						org_capture = "gC",
					},
				},
			})
		end,
	},
	{
		"akinsho/org-bullets.nvim",
		config = true,
		ft = "org",
	},
}
