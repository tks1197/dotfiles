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

vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = vim.fn.expand '$ZK_NOTEBOOK_DIR' .. '/*.md',
  callback = function(event)
    local result = vim.api.nvim_exec2("!yq --front-matter='extract' 'has(\"updated\")' " .. event.match, { output = true }).output
    local output = vim.split(result, '\n')[3]
    if output == 'true' then
      vim.api.nvim_exec2('silent !yq -i --front-matter=process \'.updated = now | .updated style="double"\' ' .. event.match, { output = false })
    end
  end,
})

vim.api.nvim_create_autocmd('VimEnter', {
  pattern = vim.fn.expand '$ZK_NOTEBOOK_DIR' .. '/*.md',
  callback = function()
    local mini_pair = require 'mini.pairs'
    mini_pair.unmap('i', '[', '')
  end,
})

-- vim.api.nvim_create_autocmd('FileType', {
--   pattern = 'markdown',
--   callback = function(args)
--     vim.lsp.start({
--       name = 'iwes',
--       cmd = { 'iwes' },
--       root_dir = vim.fs.root(args.buf, { '.iwe' }),
--       flags = {
--         debounce_text_changes = 500,
--       },
--     })
--   end,
-- })
--
local ime_group = vim.api.nvim_create_augroup('ime', { clear = true })
if vim.fn.has 'linux' then
  vim.api.nvim_create_autocmd('InsertEnter', {
    desc = 'switch to us',
    group = ime_group,
    callback = function()
      vim.fn.jobstart 'fcitx5-remote -s keyboard-us'
    end,
  })

  vim.api.nvim_create_autocmd('InsertLeave', {
    desc = 'switch to skk',
    group = ime_group,
    callback = function()
      vim.fn.jobstart 'fcitx5-remote -s skk'
    end,
  })
end

if vim.fn.has 'mac' then
  vim.api.nvim_create_autocmd({ 'InsertEnter' }, {
    desc = 'switch to us',
    group = ime_group,
    callback = function()
      vim.fn.jobstart 'macism com.apple.keylayout.ABC'
    end,
  })

  vim.api.nvim_create_autocmd('InsertLeave', {
    desc = 'switch to skk',
    group = ime_group,
    callback = function()
      vim.fn.jobstart 'macism jp.sourceforge.inputmethod.aquaskk'
    end,
  })
end

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
