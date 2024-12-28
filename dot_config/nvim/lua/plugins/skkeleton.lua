-- skkeleton(SKK implements for Vim/Neovim with denops.vim )
-- https://github.com/vim-skk/skkeleton
return {
	"vim-skk/skkeleton",
	dependencies = {
		"vim-denops/denops.vim",
	},
	init = function()
		vim.api.nvim_set_keymap("i", "C-<Space>", "<Plug>(skkeleton-toggle)", { noremap = true })
		vim.api.nvim_set_keymap("c", "C-<Space>", "<Plug>(skkeleton-toggle)", { noremap = true })
	end,
	config = function()
		-- see https://github.com/vim-skk/skkeleton/blob/main/doc/skkeleton.jax
		vim.fn["skkeleton#config"]({
			sources = { "skk_server" },
			userDictionary = "~/.local/share/skk/SKK-JISYO-USER.utf8",
		})
	end,
}
