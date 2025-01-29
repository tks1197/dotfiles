-- copilot.lua(github copilot plugin)
-- https://github.com/zbirenbaum/copilot.lua
return {
	"zbirenbaum/copilot.lua",
	lazy = true,
	cmd = "Copilot",
	build = ":Copilot auth",
	event = "InsertEnter",
	opts = {
		suggestion = { enabled = false },
		panel = { enabled = false },
		filetypes = {
			markdown = true,
			help = true,
		},
	},
}
