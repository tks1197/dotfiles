-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- 何に使うんだろう?
vim.g.netrw_liststyle = 3
-- nerd系のfontを使っているならtrue
vim.g.have_nerd_font = true

local opt = vim.opt

-- turn off swapfile
opt.swapfile = false

-- change childa line
opt.fillchars = { eob = ' ' }

-- Make line numbers default
opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
-- vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
opt.clipboard = 'unnamedplus'

-- Enable break indent
opt.breakindent = true

-- Save undo history
opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
opt.ignorecase = true
opt.smartcase = true

-- Keep signcolumn on by default
opt.signcolumn = 'yes'

-- Decrease update time
opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
opt.timeoutlen = 300

-- Configure how new splits should be opened
opt.splitright = true
opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
opt.inccommand = 'split'

-- Show which line your cursor is on
opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
opt.scrolloff = 10

-- Set highlight on search, but clear on pressing <Esc> in normal mode
opt.hlsearch = true

-- TODO これはおそらく上記の設定と被ってるので見直す
-- 24ビットRGBカラー有効化
vim.api.nvim_set_option('termguicolors', true)
-- ファイル末尾に移動した際に4行分の余白設定
vim.api.nvim_set_option('scrolloff', 4)
-- 検索時に大文字小文字無視
vim.api.nvim_set_option('ignorecase', true)
-- 検索時に大文字が含まれていたらignorecaseを無効化
vim.api.nvim_set_option('smartcase', true)
-- 置換時に画面下部に検索結果を表示
vim.api.nvim_set_option('inccommand', 'split')
-- クリップボードの有効化
vim.api.nvim_set_option('clipboard', 'unnamedplus')

-- window
-- 行番号表示
vim.api.nvim_win_set_option(0, 'number', true)
-- 相対行番号表示
-- vim.api.nvim_win_set_option(0, 'relativenumber', true)
-- カーソル行を強調
vim.api.nvim_win_set_option(0, 'cursorline', true)
-- 標識のためのスペースを最左列に設ける
vim.api.nvim_win_set_option(0, 'signcolumn', 'yes:1')
-- テキストの折り返しを無効化
vim.api.nvim_win_set_option(0, 'wrap', false)
-- 非表示文字の可視化
vim.api.nvim_win_set_option(0, 'list', true)
-- 指定したカラム列を強調
-- vim.api.nvim_win_set_option(0, 'colorcolumn', '100')
