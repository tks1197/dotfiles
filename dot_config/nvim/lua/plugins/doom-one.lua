return {
	"NTBBloodbath/doom-one.nvim",
	setup = function()
		-- Add color to cursor
		vim.g.doom_one_cursor_coloring = true
		-- Set :terminal colors
		vim.g.doom_one_terminal_colors = true
		-- Enable italic comments
		vim.g.doom_one_italic_comments = false
		-- Enable TS support
		vim.g.doom_one_enable_treesitter = true
		-- Color whole diagnostic text or only underline
		vim.g.doom_one_diagnostics_text_color = true
		-- Enable transparent background
		vim.g.doom_one_transparent_background = true

		-- Pumblend transparency
		vim.g.doom_one_pumblend_enable = true
		vim.g.doom_one_pumblend_transparency = 50

		-- Plugins integration
		vim.g.doom_one_plugin_neorg = false
		vim.g.doom_one_plugin_barbar = false
		vim.g.doom_one_plugin_telescope = false
		vim.g.doom_one_plugin_neogit = false
		vim.g.doom_one_plugin_nvim_tree = false
		vim.g.doom_one_plugin_dashboard = false
		vim.g.doom_one_plugin_startify = false
		vim.g.doom_one_plugin_whichkey = true
		vim.g.doom_one_plugin_indent_blankline = false
		vim.g.doom_one_plugin_vim_illuminate = false
		vim.g.doom_one_plugin_lspsaga = false
	end,
	config = function()
		vim.cmd("colorscheme doom-one")
	end,
}
