-- [[ Setting options ]]
-- See `:help vim.opt`
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.netrw_liststyle = 3
vim.g.have_nerd_font = true

local opt = vim.opt
-- enable all tfplugins
vim.cmd 'filetype plugin indent on'
-- auto-session.nvim recommended setting
opt.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'
-- turn off swapfile
opt.swapfile = false

-- 共通の設定（VSCodeでも適用する設定）
-- Change childa line
opt.fillchars:append { eob = ' ' }
-- Make line numbers default
opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
opt.mouse = 'a'

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
opt.ignorecase = true
opt.incsearch = true
opt.smartcase = true
opt.infercase = true
opt.smartindent = true

-- Save undo history
opt.undofile = true
opt.writebackup = false

-- Configure how new splits should be opened
opt.splitright = true
opt.splitbelow = true

-- Minimal number of screen lines to keep above and below the cursor.
opt.scrolloff = 10

vim.schedule(function()
  opt.clipboard:append 'unnamedplus,unnamed'
end)

if not vim.g.vscode then
  -- Don't show the mode, since it's already in the status line
  opt.showmode = false
  -- https://neovim.io/doc/user/options.html#'laststatus'
  opt.laststatus = 3

  -- Enable break indent
  opt.breakindent = true

  opt.completeopt = 'menuone,noinsert,noselect'
  opt.virtualedit = 'block'
  opt.formatoptions = 'qjl1'

  -- Keep signcolumn on by default
  opt.signcolumn = 'yes'

  -- Decrease update time
  opt.updatetime = 250

  -- Decrease mapped sequence wait time
  -- Displays which-key popup sooner
  opt.timeoutlen = 300

  -- Sets how neovim will display certain whitespace characters in the editor.
  --  See `:help 'list'`
  --  and `:help 'listchars'`
  opt.list = true
  opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

  -- Preview substitutions live, as you type!
  opt.inccommand = 'split'

  -- Show which line your cursor is on
  opt.cursorline = true

  -- Set highlight on search, but clear on pressing <Esc> in normal mode
  opt.hlsearch = true

  -- enable true colors
  opt.termguicolors = true
  -- disable line wrap
  opt.wrap = false

  opt.showmode = false
  opt.ruler = false

  opt.conceallevel = 1

  opt.jumpoptions = 'stack,view'

  opt.foldenable = true
  opt.foldlevel = 99
  opt.foldmethod = 'expr'
  opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
  opt.foldtext = ''
  opt.foldcolumn = '0'
  opt.fillchars:append { fold = ' ' }

  opt.cmdheight = 0
end

opt.expandtab = true
opt.shiftround = true
opt.whichwrap = 'b,s,h,l,<,>,[,],~'
