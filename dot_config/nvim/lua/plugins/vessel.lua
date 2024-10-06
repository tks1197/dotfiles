-- [GitHub - gcmt/vessel.nvim: Interactive mark and jump list window](https://github.com/gcmt/vessel.nvim)
return {
	"gcmt/vessel.nvim",
	enabled = true,
	config = function()
		require("vessel").setup({
			create_commands = true,
		})
		-- vim.keymap.set("n", "gl", "<Plug>(VesselViewLocalJumps)")
		vim.keymap.set("n", "gl", "<Plug>(VesselViewMarks)")
		vim.keymap.set("n", "gL", "<Plug>(VesselViewExternalJumps)")
		vim.keymap.set("n", "gm", "<plug>(VesselViewBufferMarks)")
		vim.keymap.set("n", "gM", "<plug>(VesselViewExternalMarks)")
		vim.keymap.set("n", "gB", "<plug>(VesselSetLocalMark)")
		vim.keymap.set("n", "gb", "<plug>(VesselSetGlobalMark)")
	end,
}
