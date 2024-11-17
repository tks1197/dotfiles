-- vim-tpipeline
-- vimのstatuslineをtmuxのstatuslineに埋め込むプラグイン
-- https://github.com/vimpostor/vim-tpipeline
--
return {
	-- https://www.reddit.com/r/neovim/comments/1aredai/vimnvim_status_line_integrated_in_tmux_status_line/
	"vimpostor/vim-tpipeline",
	event = "VeryLazy",
	init = function()
		-- vim.g.tpipeline_autoembed = 0
		-- vim.g.tpipeline_statusline = ""
	end,
	config = function()
		vim.cmd.hi({ "link", "StatusLine", "WinSeparator" })
		vim.g.tpipeline_statusline = ""
		vim.o.laststatus = 0
		vim.o.fillchars = "stl:─,stlnc:─"
	end,
	cond = function()
		return vim.env.TMUX ~= nil
	end,
}
