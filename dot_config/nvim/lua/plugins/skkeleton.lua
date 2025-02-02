-- skkeleton(SKK implements for Vim/Neovim with denops.vim )
-- https://github.com/vim-skk/skkeleton
return {
	"vim-skk/skkeleton",
	lazy = false,
	dependencies = {
		"vim-denops/denops.vim",
	},
	config = function()
		-- see https://github.com/vim-skk/skkeleton/blob/main/doc/skkeleton.jax
		vim.fn["skkeleton#config"]({
			globalDictionaries = {
				"~/.local/share/skk/SKK-JISYO-USER.euc",
				"~/.local/share/skk/SKK-JISYO.L",
				"~/.local/share/skk/SKK-JISYO.station",
				"~/.local/share/skk/SKK-JISYO.jinmei",
				"~/.local/share/skk/SKK-JISYO.propernoun",
				"~/.local/share/skk/SKK-JISYO.geo",
			},
			sources = { "skk_dictionary", "skk_server" },
			userDictionary = "~/.local/share/skkeleton/SKK-JISYO-USER.utf8",
			eggLikeNewline = true,
		})
		vim.fn["skkeleton#initialize"]()
		vim.keymap.set({ "t", "i", "c" }, "<C-j>", "<Plug>(skkeleton-enable)")
		vim.keymap.set({ "t", "i", "c" }, "<l>", "<Plug>(skkeleton-disable)")
	end,
}
