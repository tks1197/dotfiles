-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('BufReadPost', {
  desc = 'Recover previous cursor position in buffer',
  pattern = { '*' },
  callback = function()
    if vim.fn.line '\'"' > 0 and vim.fn.line '\'"' <= vim.fn.line '$' then
      vim.fn.execute 'normal! g`"zz'
    end
  end,
})

-- Keep the cursor position when yanking
local cursorPreYank

vim.keymap.set({ 'n', 'x' }, 'y', function()
  cursorPreYank = vim.api.nvim_win_get_cursor(0)
  return 'y'
end, { expr = true })

vim.keymap.set('n', 'Y', function()
  cursorPreYank = vim.api.nvim_win_get_cursor(0)
  return 'yg_'
end, { expr = true })

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    if vim.v.event.operator == 'y' and cursorPreYank then
      vim.api.nvim_win_set_cursor(0, cursorPreYank)
    end
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  desc = 'Automatically Split help Buffers to the right',
  pattern = 'help',
  command = 'wincmd L',
})

vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI', 'WinScrolled' }, {
  desc = 'Fix scrolloff when you are at the EOF',
  group = vim.api.nvim_create_augroup('ScrollEOF', { clear = true }),
  callback = function()
    if vim.api.nvim_win_get_config(0).relative ~= '' then
      return -- Ignore floating windows
    end

    local win_height = vim.fn.winheight(0)
    local scrolloff = math.min(vim.o.scrolloff, math.floor(win_height / 2))
    local visual_distance_to_eof = win_height - vim.fn.winline()

    if visual_distance_to_eof < scrolloff then
      local win_view = vim.fn.winsaveview()
      vim.fn.winrestview { topline = win_view.topline + scrolloff - visual_distance_to_eof }
    end
  end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  desc = 'Autocreate a dir when saving a file',
  group = vim.api.nvim_create_augroup('auto_create_dir', { clear = true }),
  callback = function(event)
    if event.match:match '^%w%w+:[\\/][\\/]' then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
  end,
})

local ime_group = vim.api.nvim_create_augroup('ime', { clear = true })
vim.api.nvim_create_autocmd('InsertEnter', {
  desc = 'switch to US keyboard layout',
  group = ime_group,
  callback = function()
    if vim.fn.has('linux') == 1 then
      vim.fn.jobstart('fcitx5-remote -s keyboard-us')
    elseif vim.fn.has('mac') == 1 then
      vim.fn.jobstart('macism com.apple.keylayout.ABC')
    end
  end,
})

vim.api.nvim_create_autocmd('InsertLeave', {
  desc = 'switch to SKK input method',
  group = ime_group,
  callback = function()
    if vim.fn.has('linux') == 1 then
      vim.fn.jobstart('fcitx5-remote -s skk')
    elseif vim.fn.has('mac') == 1 then
      vim.fn.jobstart('macism jp.sourceforge.inputmethod.aquaskk')
    end
  end,
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client:supports_method 'textDocument/foldingRange' then
      local win = vim.api.nvim_get_current_win()
      vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
    end
  end,
})

vim.cmd [[
function! YankShift()
  call setreg(0, getreg('"'))
  for i in range(9, 1, -1)
    call setreg(i, getreg(i - 1))
  endfor
endfunction

au TextYankPost * if v:event.operator == 'y' | call YankShift() | endif
au TextYankPost * if v:event.operator == 'd' | call YankShift() | endif
]]

vim.api.nvim_create_autocmd({ 'RecordingEnter', 'CmdlineEnter' }, {
  pattern = '*',
  callback = function()
    vim.opt.cmdheight = 1
  end,
})
vim.api.nvim_create_autocmd('RecordingLeave', {
  pattern = '*',
  callback = function()
    vim.opt.cmdheight = 0
  end,
})
vim.api.nvim_create_autocmd('CmdlineLeave', {
  pattern = '*',
  callback = function()
    if vim.fn.reg_recording() == '' then
      vim.opt.cmdheight = 0
    end
  end,
})
--
-- vim.api.nvim_create_autocmd('TermClose', {
--   pattern = '*',
--   callback = function()
--     vim.schedule(function()
--       if vim.bo.buftype == 'terminal' and vim.v.shell_error == 0 then
--         vim.cmd('bdelete! ' .. vim.fn.expand('<abuf>'))
--       end
--     end)
--   end,
-- })
