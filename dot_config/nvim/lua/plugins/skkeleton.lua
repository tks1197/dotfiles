-- skkeleton(SKK implements for Vim/Neovim with denops.vim )
-- https://github.com/vim-skk/skkeleton
return {
	"vim-skk/skkeleton",
	event = { "InsertEnter", "CmdlineEnter" },
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
		})
	end,
}
