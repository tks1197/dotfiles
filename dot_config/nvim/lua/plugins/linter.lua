return {
	"mfussenegger/nvim-lint",
	event = { "BufEnter", "BufWritePost", "InsertLeave" },
	config = function()
		local lint = require("lint")
		lint.linters_by_ft = {
			markdown = {
				"markdownlint-cli2",
				"cspell",
			},
			yaml = { "yamllint", "cspell" },
			json = { "cspell" },
			ghactions = { "yamllint", "actionlint", "cspell" },
			python = { "ruff", "flake8", "cspell" },
			lua = { "cspell" },
			cpp = { "cspell" },
			rust = { "cspell" },
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
			lint.try_lint(nil, { ignore_errors = true })
		end
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = augroup,
			callback = _callback,
		})
		vim.keymap.set("n", "<leader>l", _callback, { desc = "Trigger linting for current file" })
	end,
}
