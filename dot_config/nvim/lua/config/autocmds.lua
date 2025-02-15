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
    if vim.fn.line('\'"') > 0 and vim.fn.line('\'"') <= vim.fn.line('$') then
      vim.fn.execute('normal! g`"zz')
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
      vim.fn.winrestview({ topline = win_view.topline + scrolloff - visual_distance_to_eof })
    end
  end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  desc = 'Autocreate a dir when saving a file',
  group = vim.api.nvim_create_augroup('auto_create_dir', { clear = true }),
  callback = function(event)
    if event.match:match('^%w%w+:[\\/][\\/]') then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
  end,
})
