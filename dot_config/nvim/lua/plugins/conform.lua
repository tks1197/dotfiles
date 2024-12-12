-- conform.nvim(autoformat plugin)
-- https://github.com/stevearc/conform.nvim/
return {
	"stevearc/conform.nvim",
	event = "BufWritePre",
	cmd = "ConformInfo",
	lazy = true,
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = "",
			desc = "[F]ormat buffer",
		},
	},
	config = function()
		vim.api.nvim_create_user_command("FormatDisable", function(args)
			if args.bang then
				-- FormatDisable! will disable formatting just for this buffer
				vim.b.disable_autoformat = true
			else
				vim.g.disable_autoformat = true
			end
		end, {
			desc = "Disable autoformat-on-save",
			bang = true,
		})
		vim.api.nvim_create_user_command("FormatEnable", function()
			vim.b.disable_autoformat = false
			vim.g.disable_autoformat = false
		end, {
			desc = "Re-enable autoformat-on-save",
		})
		require("conform").setup({
			notify_on_error = false,
			format_on_save = function(bufnr)
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end
				local disable_filetypes = { c = true, cpp = true }
				return {
					timeout_ms = 2500,
					lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
				}
			end,
			formatters_by_ft = {
				sh = { "shfmt" },
				json = { "jq" },
				lua = { "stylua" },
				python = { "ruff_fix", "ruff_format" },
				markdown = { "markdownlint-cli2" },
			},
			formatters = {
				shfmt = {
					prepend_args = { "-i", "2" },
				},
			},
		})
	end,
}
