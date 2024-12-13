return {
	"rmagatti/auto-session",
	lazy = false,
	---@module "auto-session"
	---@type AutoSession.Config
	opts = {
		suppress_dirs = { "~/", "~/Downloads", "~/Documents", "~/Desktop/" },
		auto_restore = true,
	},
	config = function()
		local keymap = vim.keymap
		keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" }) -- restore last workspace session for current directory
		keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save session for auto session root dir" }) -- save workspace session for current working directory
	end,
}
