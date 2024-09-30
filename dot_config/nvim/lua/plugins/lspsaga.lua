-- lspsaga
-- https://nvimdev.github.io/lspsaga/
return {
	"nvimdev/lspsaga.nvim",
	event = "LspAttach",

	config = function()
		vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc")
		-- see default config https://github.com/nvimdev/lspsaga.nvim/blob/main/lua/lspsaga/init.lua
		require("lspsaga").setup({
			implement = {
				enable = false,
			},
			hover = {
				-- linuxで開かない場合はxdg-settingsでxdg-openが設定されているか確認すること。
				-- https://wiki.archlinux.org/title/Xdg-utils#xdg-settings
				open_cmd = "!floorp",
			},
			symbol_in_winbar = {
				enable = false,
			},
			lightbulb = {
				enable = false,
			},
		})
	end,
	dependencies = {
		"nvim-treesitter/nvim-treesitter", -- optional
		"nvim-tree/nvim-web-devicons", -- optional
	},
}
