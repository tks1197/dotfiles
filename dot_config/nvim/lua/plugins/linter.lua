# TODO: refactor this file
return {
	"mfussenegger/nvim-lint",
	event = { "BufEnter", "BufWritePost", "InsertLeave" },
	config = function()
		local lint = require("lint")
		local severities = {
			vim.diagnostic.severity.WARN,
			vim.diagnostic.severity.ERROR,
		}
		lint.linters.textlint = {
			name = "textlint",
			cmd = "textlint",
			stdin = true,
			stream = "stdout",
			args = {
				"--format",
				"json",
				"--stdin",
				"--stdin-filename",
				function()
					return vim.api.nvim_buf_get_name(0)
				end,
				"--config",
				vim.fn.expand("$HOME/.config/textlint/.textlintrc.json"),
			},
			ignore_exitcode = true,
			parser = function(output)
				if output == "" then
					return {}
				end
				local decoded = vim.json.decode(output)
				if decoded == nil then
					return {}
				end
				local diagnostics = {}
				for _, value in ipairs(decoded) do
					for _, item in ipairs(value.messages) do
						table.insert(diagnostics, {
							message = item.message,
							col = item.loc.start.column - 1,
							end_col = item.loc["end"].column - 1,
							lnum = item.loc.start.line - 1,
							end_lnum = item.loc["end"].line - 1,
							code = item.ruleId,
							severity = severities[item.severity],
							source = "textlint",
						})
					end
				end
				return diagnostics
			end,
		}
		lint.linters_by_ft = {
			markdown = {
				"markdownlint-cli2",
				"cspell",
				"textlint",
			},
			yaml = { "yamllint", "cspell" },
			json = { "cspell" },
			ghactions = { "yamllint", "actionlint", "cspell" },
			python = { "ruff", "flake8", "cspell" },
			lua = { "cspell" },
			cpp = { "cspell" },
			rust = { "cspell" },
			gitcommit = { "cspell" },
		}

		local function search_cspell_config()
			-- cspell config file pattern
			-- see https://cspell.org/configuration/
			local cspell_config_patterns = {
				".cspell.json",
				"cspell.json",
				".cSpell.json",
				"cSpell.json",
				"cspell.config.js",
				"cspell.config.cjs",
				"cspell.config.json",
				"cspell.config.yaml",
				"cspell.config.yml",
				"cspell.yaml",
				"cspell.yml",
			}
			local config_file = vim.fs.find(cspell_config_patterns, { upward = true })
			if next(config_file) == nil then
				-- fallback to default config file
				return vim.fn.expand("~/.config/cspell/cspell.config.yaml")
			else
				return config_file[1]
			end
		end

		lint.linters.cspell.args = {
			"lint",
			"--no-color",
			"--no-progress",
			"--no-summary",
			"--config",
			search_cspell_config(),
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
