-- https://github.com/echasnovski/mini.nvim
return {
	"echasnovski/mini.nvim",
	config = function()
		-- Better Around/Inside textobjects
		--
		-- Examples:
		--  - va)  - [V]isually select [A]round [)]paren
		--  - yinq - [Y]ank [I]nside [N]ext [']quote
		--  - ci'  - [C]hange [I]nside [']quote
		require("mini.ai").setup({ n_lines = 500 })

		-- Add/delete/replace surroundings (brackets, quotes, etc.)
		--
		-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
		-- - sd'   - [S]urround [D]elete [']quotes
		-- - sr)'  - [S]urround [R]eplace [)] [']
		require("mini.surround").setup({
			n_lines = 200,
		})

		local miniclue = require("mini.clue")
		miniclue.setup({
			window = {
				delay = 200,
				config = {
					width = 50,
					height = 15,
				},
			},
			triggers = {
				-- Leader triggers
				{ mode = "n", keys = "<Leader>" },
				{ mode = "x", keys = "<Leader>" },

				-- Built-in completion
				{ mode = "i", keys = "<C-x>" },

				-- `g` key
				{ mode = "n", keys = "g" },
				{ mode = "x", keys = "g" },

				-- Marks
				{ mode = "n", keys = "'" },
				{ mode = "n", keys = "`" },
				{ mode = "x", keys = "'" },
				{ mode = "x", keys = "`" },
				-- Registers
				{ mode = "n", keys = '"' },
				{ mode = "x", keys = '"' },
				{ mode = "i", keys = "<C-r>" },
				{ mode = "c", keys = "<C-r>" },

				-- Window commands
				{ mode = "n", keys = "<C-w>" },

				-- `z` key
				{ mode = "n", keys = "z" },
				{ mode = "x", keys = "z" },
			},

			clues = {
				-- Enhance this by adding descriptions for <Leader> mapping groups
				miniclue.gen_clues.builtin_completion(),
				miniclue.gen_clues.g(),
				miniclue.gen_clues.marks(),
				miniclue.gen_clues.registers(),
				miniclue.gen_clues.windows(),
				miniclue.gen_clues.z(),
				{ mode = "n", keys = "<Leader>s", desc = "+Search" },
			},
		})

		require("mini.files").setup({
			mappings = {
				go_in = "<CR>",
				go_in_plus = "J",
				go_out = "<BS>",
				reset = "R",
			},
			windows = {
				preview = true,
			},
		})
		require("mini.diff").setup()

		local ministatusline = require("mini.statusline")
		local statusline_config = function()
			local mode, mode_hl = ministatusline.section_mode({ trunc_width = 120 })
			local git = ministatusline.section_git({ trunc_width = 40 })
			local diff = ministatusline.section_diff({ trunc_width = 75 })
			local diagnostics = ministatusline.section_diagnostics({ trunc_width = 75 })
			local lsp = ministatusline.section_lsp({ trunc_width = 75 })
			-- local filename = ministatusline.section_filename({ trunc_width = 250 })
			local fileinfo = ministatusline.section_fileinfo({ trunc_width = 180 })
			local location = ministatusline.section_location({ trunc_width = 250 })
			-- local search = ministatusline.section_searchcount({ trunc_width = 75 })

			return ministatusline.combine_groups({
				{ hl = mode_hl, strings = { mode } },
				{ hl = "ministatuslineDevinfo", strings = { git, diff, diagnostics, lsp } },
				"%<", -- Mark general truncate point
				--		{ hl = "ministatuslineFilename", strings = { filename } },
				"%=", -- End left alignment
				{ hl = "ministatuslineFileinfo", strings = { fileinfo } },
				{ hl = "ministatuslineLocation", strings = { location } },
			})
		end
		ministatusline.setup({
			content = {
				active = statusline_config,
				inactive = statusline_config,
			},
		})

		-- indentscope
		-- require('mini.indentscope').setup()
		-- autopairs
		require("mini.pairs").setup()
	end,
}
