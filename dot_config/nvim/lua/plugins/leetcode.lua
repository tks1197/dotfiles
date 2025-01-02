local leet_arg = "leetcode.nvim"
return {
	"kawre/leetcode.nvim",
	build = ":TSUpdate html",
	cmd = "Leet",
	lazy = leet_arg ~= vim.fn.argv(0, -1),
	dependencies = {
		"MunifTanjim/nui.nvim",
		"ibhagwan/fzf-lua",
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	opts = { arg = leet_arg, lang = "python3" },
}
