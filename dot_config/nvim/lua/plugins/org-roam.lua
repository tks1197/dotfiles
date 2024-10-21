return {
	"chipsenkbeil/org-roam.nvim",
	dependencies = {
		{
			"nvim-orgmode/orgmode",
		},
	},
	config = function()
		require("org-roam").setup({
			directory = "~/Documents/org-roam-files",
			-- org_files = {
			-- 	"~/another_org_dir",
			-- 	"~/some/folder/*.org",
			-- 	"~/a/single/org_file.org",
			-- },
			extensions = {
				dailies = {
					templates = {
						t = {
							description = "daily note",
							template = "- %<%H:%M> %?",
							target = "%<%Y-%m-%d>.org",
						},
					},
				},
			},
		})
	end,
}
