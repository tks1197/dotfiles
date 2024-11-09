-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- autosave
-- vim.api.nvim_create_autocmd({ 'FocusLost', 'ModeChanged', 'TextChanged', 'BufEnter' }, { desc = 'autosave', pattern = '*', command = 'silent! update' })

-- lazygitをtoggletermのfloating windowで起動した際に、escを押してLazyGitから抜けられない問題の解消
-- https://github.com/kdheepak/lazygit.nvim/issues/127#issuecomment-2188273880
vim.api.nvim_create_autocmd("TermEnter", {
	callback = function()
		-- If the terminal window is lazygit, we do not make changes to avoid clashes
		if string.find(vim.api.nvim_buf_get_name(0), "lazygit") then
			return
		end

		vim.keymap.set("t", "<ESC>", function()
			vim.cmd("stopinsert")
		end, { buffer = true })
	end,
})
