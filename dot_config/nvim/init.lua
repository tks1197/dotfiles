vim.loader.enable()

require("config.options")
require("config.filetypes")
require("config.lazy")
vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		require("config.autocmds")
		require("config.keymaps")
	end,
})
