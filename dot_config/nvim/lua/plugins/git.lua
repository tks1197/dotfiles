return {
	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
		event = "VeryLazy",
		config = function()
			vim.keymap.set("n", "<leader>hh", "<cmd>DiffviewFileHistory<cr>", { desc = "Repo history" })
			vim.keymap.set("n", "<leader>hf", "<cmd>DiffviewFileHistory --follow .<cr>", { desc = "File history" })
			vim.keymap.set("n", "<leader>hl", "<Cmd>.DiffviewFileHistory --follow<CR>", { desc = "Line history" })
			vim.keymap.set("n", "<leader>hc", "<Cmd>DiffviewClose<CR>", { desc = "Close Diffview" })
			vim.keymap.set("n", "<leader>hd", "<cmd>DiffviewOpen<cr>", { desc = "Repo diff" })
			local function get_default_branch_name()
				local res = vim.system({ "git", "rev-parse", "--verify", "main" }, { capture_output = true }):wait()
				return res.code == 0 and "main" or "master"
			end
			vim.keymap.set("n", "<leader>hm", function()
				vim.cmd("DiffviewOpen " .. get_default_branch_name())
			end, { desc = "Diff against master" })

			vim.keymap.set("n", "<leader>hM", function()
				vim.cmd("DiffviewOpen HEAD..origin/" .. get_default_branch_name())
			end, { desc = "Diff against origin/master" })
		end,
	},
	{ "tpope/vim-fugitive", event = "VeryLazy", cmd = "Git" },
	{ "tpope/vim-rhubarb", event = "VeryLazy" },
}
