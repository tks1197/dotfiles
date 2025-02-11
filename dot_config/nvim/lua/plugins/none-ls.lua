return {
	"nvimtools/none-ls.nvim",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"davidmh/cspell.nvim",
	},
	config = function()
		local cspell = require("cspell")
		local cspell_config = {
			config_file_preferred_name = "cspell.json",
			cspell_config_dirs = { "~/.config/cspell/" },
		}
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				cspell.diagnostics.with({
					config = cspell_config,
					diagnostics_postprocess = function(diagnostic)
						diagnostic.severity = vim.diagnostic.severity.INFO
					end,
				}),
				cspell.code_actions.with({ config = cspell_config }),
				null_ls.builtins.code_actions.textlint.with({
					filetypes = { "markdown", "text", "org" },
					extra_args = { "--config", vim.fn.expand("~/.config/textlint/.textlintrc.json") },
				}),
				null_ls.builtins.diagnostics.textlint.with({
					filetypes = { "markdown", "text", "org" },
					extra_args = { "--config", vim.fn.expand("~/.config/textlint/.textlintrc.json") },
				}),
			},
		})
	end,
}
