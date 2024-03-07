" neovim plugin settings vscode-nevoimでの使用を前提としているので編集,
" 操作系のプラグインのみ導入する
source ~/.config/vim/.vimrc
set smartindent
set laststatus=2
set wildmenu
set ruler
set encoding=utf8
set nrformats=
set clipboard+=unnamedplus
" set showmatch
" set matchtime=1

inoremap jj <Esc>
nnoremap Y y$
nnoremap + <C-a>
nnoremap - <C-x>
nmap <Esc><Esc> :nohl<CR>

" let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
" highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
" highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
"
" call jetpack#begin()
" Jetpack 'machakann/vim-sandwich'
" Jetpack 'unblevable/quick-scope'
" Jetpack 'yutkat/wb-only-current-line.nvim'
" Jetpack 'phaazon/hop.nvim'
" call jetpack#end()
"
" lua << EOF
"   require'hop'.setup()
" EOF
"
" nmap <Leader> [hop]
" nnoremap <silent> [hop]w :HopWord<CR>
" nnoremap <silent> [hop]l :HopLine<CR>
" nnoremap <silent> [hop]f :HopChar1<CR>
" nnoremap <silent> [hop]s :HopChar3<CR>

