-- crates.nvim(A neovim plugin that helps managing crates.io dependencies)
-- https://github.com/saecki/crates.nvim
return {
	"Saecki/crates.nvim",
	event = { "BufRead Cargo.toml" },
	opts = {
		completion = {
			crates = {
				enabled = true,
			},
		},
		lsp = {
			enabled = true,
			actions = true,
			completion = true,
			hover = true,
		},
	},
}
