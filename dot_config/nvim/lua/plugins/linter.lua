return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			markdown = {
				"markdownlint-cli2",
			},
			yaml = { "yamllint" },
			ghactions = { "yamllint", "actionlint" },
			python = { "ruff", "flake8" },
		}
		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint(nil, { ignore_errors = true })
			end,
		})

		vim.keymap.set("n", "<leader>l", function()
			lint.try_lint(nil, { ignore_errors = true })
		end, { desc = "Trigger linting for current file" })
	end,
}
