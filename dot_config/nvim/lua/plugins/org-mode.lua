return {
	{
		"nvim-orgmode/orgmode",
		lazy = true,
		event = "VeryLazy",
		ft = { "org" },
		config = function()
			-- Setup orgmode
			require("orgmode").setup({
				org_agenda_files = "~/Documents/org/**/*",
				org_default_notes_file = "~/Documents/org/refile.org",
				win_split_mode = "horizontal",
				win_border = "rounded",
				org_startup_folded = "showeverything",
				ui = {
					input = {
						use_vim_ui = true,
					},
				},
				org_capture_templates = {
					t = { description = "Task(Interrupt)", template = "** TODO %?\n" },
					n = { description = "Note", template = "- %<%H:%M:%S> %?" },
				},
			})
			vim.keymap.set("n", "gt", function()
				require("orgmode").capture:open_template_by_shortcut("n")
			end, { noremap = true, silent = true, desc = "Org Capture(Note)" })
			vim.keymap.set("n", "gT", function()
				require("orgmode").capture:open_template_by_shortcut("t")
			end, { noremap = true, silent = true, desc = "Open Org Capture(TODO)" })
			vim.keymap.set("n", "gO", function()
				vim.cmd("e " .. vim.fn.expand("~/Documents/org/refile.org"))
			end, { noremap = true, silent = true, desc = "Open Refile" })
			local function _create_org_file(input)
				local org_dir = vim.fn.expand("~/Documents/org/") -- The org directory

				-- Validate the input
				if input == nil or input == "" then
					print("Invalid filename.")
					return
				end

				-- Ensure the filename has the .org extension
				local filename = input:match(".*%.org$") and input or input .. ".org"
				local filepath = org_dir .. filename

				-- Create the file and open it in a new tab
				vim.cmd("tabnew " .. filepath)
				vim.notify("Created new org file in a new tab: " .. filepath)
			end
			local function create_org_file()
				vim.ui.input({ prompt = "Create new org file" }, _create_org_file)
			end
			vim.keymap.set(
				"n",
				"<leader>oc",
				create_org_file,
				{ noremap = true, silent = true, desc = "Create new org file" }
			)
		end,
	},
	{
		"akinsho/org-bullets.nvim",
		config = true,
		ft = "org",
	},
}
