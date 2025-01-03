-- https://github.com/ibhagwan/fzf-lua
return {
	"ibhagwan/fzf-lua",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local fzf_lua = require("fzf-lua")
		fzf_lua.setup({
			files = {
				cwd_prompt = false,
			},
			oldfiles = {
				include_current_session = true,
				stat_file = true,
			},
			previewers = {
				fzf_lua = {
					syntax_limit_b = 1024 * 100, -- 100KB
				},
			},
			keymap = {
				fzf = {
					["ctrl-q"] = "select-all+accept",
				},
				fzf_lua = {
					{ true, ["<Esc>"] = "hide" },
				},
			},
		})
		-- https://github.com/ibhagwan/fzf-lua/wiki#automatic-sizing-of-heightwidth-of-vimuiselect
		fzf_lua.register_ui_select(function(_, items)
			local min_h, max_h = 0.15, 0.70
			local h = (#items + 4) / vim.o.lines
			if h < min_h then
				h = min_h
			elseif h > max_h then
				h = max_h
			end
			return { winopts = { height = h, width = 0.60, row = 0.40 } }
		end)
		vim.keymap.set("n", "<leader>sh", fzf_lua.helptags, { desc = "[S]earch [H]elp" })
		vim.keymap.set("n", "<leader>sf", fzf_lua.files, { desc = "[S]earch [F]iles" })
		vim.keymap.set("n", "<leader>sk", fzf_lua.keymaps, { desc = "[S]earch [K]eymaps" })
		vim.keymap.set("n", "<leader>sg", fzf_lua.live_grep_native, { desc = "[S]earch by [G]rep" })
		vim.keymap.set("n", "<leader>sd", fzf_lua.diagnostics_document, { desc = "[S]earch [D]ocument Diagnostics" })
		vim.keymap.set("n", "<leader>sw", fzf_lua.diagnostics_workspace, { desc = "[S]earch [W]orkspace Diagnostics" })
		vim.keymap.set("n", "<leader>/", function()
			require("fzf-lua").lgrep_curbuf({
				winopts = {
					preview = {
						hidden = "hidden",
					},
				},
			})
		end, { desc = "[S]earch Current Buffer" })
	end,
}
