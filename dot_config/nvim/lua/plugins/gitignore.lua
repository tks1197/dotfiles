-- gitignore.nvim
-- https://github.com/wintermute-cell/gitignore.nvim
-- gitignore.ioをソースにgitignoreを生成するプラグイン。
return {
	"wintermute-cell/gitignore.nvim",
	config = function()
		local gitignore = require("gitignore")
		vim.keymap.set("n", "<leader>gi", gitignore.generate, { desc = "generate gitignore file." })
	end,
}
