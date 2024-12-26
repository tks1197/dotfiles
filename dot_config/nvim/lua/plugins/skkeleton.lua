-- skkeleton(SKK implements for Vim/Neovim with denops.vim )
-- https://github.com/vim-skk/skkeleton
return {
	"vim-skk/skkeleton",
	dependencies = {
		"vim-denops/denops.vim",
	},
	init = function()
		vim.api.nvim_set_keymap("i", "<C-j>", "<Plug>(skkeleton-enable)", { noremap = true })
		vim.api.nvim_set_keymap("c", "<C-j>", "<Plug>(skkeleton-enable)", { noremap = true })
		vim.api.nvim_set_keymap("i", "<C-l>", "<Plug>(skkeleton-disable)", { noremap = true })
		vim.api.nvim_set_keymap("c", "<C-l>", "<Plug>(skkeleton-disable)", { noremap = true })
	end,
	config = function()
		vim.fn["skkeleton#config"]({
			-- https://skk-dev.github.io/dict/
			eggLikeNewline = false,
			keepState = false,
			showCandidatesCount = 2,
			registerConvertResult = true,
			userDictionary = "~/.local/share/skk/SKK-JISYO-USER.euc",
			sources = { "google_japanese_input" },
		})
	end,
}
