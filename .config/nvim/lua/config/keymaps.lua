-- keymaps definitions (built-in only)
local keymap = vim.keymap
keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- jj as <Esc>
keymap.set('i', 'jj', '<Esc>', { desc = 'escape' })

-- Diagnostic keymaps
keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- substitute keymaps
vim.keymap.set('n', '<leader>rb', ':%s/\\V\\<<C-r><C-w>\\>//g<Left><Left>', { noremap = true, silent = false })
vim.keymap.set('x', '<leader>rv', '"zy:%s/\\V<C-r><C-r>=escape(@z,"/\\\\")<CR>//gce<Left><Left><Left><Left>', { noremap = true, silent = false })
keymap.set('n', '<leader>r*', '*``cgn', { desc = 'edit asterisk focus words' })

keymap.set('n', 'ycc', 'yygccp', { remap = true })
keymap.set('n', 'J', 'mzJ`z:delmarks z<cr>')

keymap.set('n', 'Y', 'y$', { noremap = true, silent = true })

vim.keymap.set('n', 'p', ']p`]', { noremap = true, silent = true })
vim.keymap.set('n', 'P', ']P`]', { noremap = true, silent = true })
vim.keymap.set('x', 'p', 'P', { noremap = true, silent = true })
