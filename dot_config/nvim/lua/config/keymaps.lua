-- keymaps definitions (built-in only)
local keymap = vim.keymap
keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- jj as <Esc>
keymap.set('i', 'jj', '<Esc>', { desc = 'escape' })

-- Diagnostic keymaps
keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- substitute keymaps
keymap.set('x', '<leader>rb', 'y:%s/<C-r><C-r>"//g<Left><Left>')
keymap.set('n', '<leader>rb', 'yiw:%s/<C-r><C-r>"//g<Left><Left>')
keymap.set('n', '<leader>*', '*``cgn', { desc = 'edit asterisk focus words' })

keymap.set('n', 'ycc', 'yygccp', { remap = true })
keymap.set('n', 'J', 'mzJ`z:delmarks z<cr>')

keymap.set('n', 'Y', 'y$', { noremap = true, silent = true })
