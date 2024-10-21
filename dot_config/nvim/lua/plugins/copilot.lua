-- copilot.lua
-- https://github.com/zbirenbaum/copilot.lua
-- NeovimでGitHub Copilotを利用するためのplugin
return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	config = function()
		require("copilot").setup({
			suggestion = {
				auto_trigger = true,
			},
			filetypes = {
				yaml = true,
			},
		})
	end,
}
