-- copilot.lua(github copilot plugin)
-- https://github.com/zbirenbaum/copilot.lua
return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	config = function()
		require("copilot").setup({
			suggestion = {
				auto_trigger = true,
				keymap = {
					accept = "<Tab>",
				},
			},
			filetypes = {
				yaml = true,
			},
		})
	end,
}
