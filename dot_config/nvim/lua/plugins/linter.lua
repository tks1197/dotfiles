return {
	"mfussenegger/nvim-lint",
	event = { "BufEnter", "BufWritePost", "InsertLeave" },
	config = function()
		local lint = require("lint")

		local severities = {
			High = vim.diagnostic.severity.ERROR,
			Medium = vim.diagnostic.severity.WARN,
		}

		lint.linters.zizmor = {
			name = "zizmor",
			cmd = "zizmor",
			args = { "--format", "json" },
			stdin = false,
			ignore_exitcode = true, -- 14

			parser = function(output, _)
				local items = {}

				if output == "" then
					return items
				end

				local decoded = vim.json.decode(output) or {}
				local bufpath = vim.fn.expand("%:p")

				for _, diag in ipairs(decoded) do
					if diag.locations[1].symbolic.key.Local.given_path == bufpath then
						table.insert(items, {
							source = "zizmor",
							lnum = diag.locations[1].concrete.location.start_point.row,
							col = diag.locations[1].concrete.location.start_point.column,
							end_lnum = diag.locations[1].concrete.location.end_point.row - 1,
							end_col = diag.locations[1].concrete.location.end_point.column,
							message = diag.desc,
							severity = assert(
								severities[diag.determinations.severity],
								"missing mapping for severity " .. diag.determinations.severity
							),
						})
					end
				end

				return items
			end,
		}
		lint.linters_by_ft = {
			markdown = {
				"markdownlint-cli2",
			},
			yaml = { "yamllint" },
			ghactions = { "yamllint", "actionlint", "zizmor" },
			python = { "ruff", "flake8" },
		}
		local augroup = vim.api.nvim_create_augroup("lint", { clear = true })
		local _callback = function()
			lint.try_lint(nil, { ignore_errors = false })
		end
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = augroup,
			callback = _callback,
		})
		vim.keymap.set("n", "<leader>l", _callback, { desc = "Trigger linting for current file" })
	end,
}
