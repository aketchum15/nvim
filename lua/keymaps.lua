vim.keymap.set('n', '<leader><space>', '<cmd>nohl<cr>', {})

vim.keymap.set('n', '<C-n>', '<cmd>BufferNext<CR>', {})
vim.keymap.set('n', '<C-p>', '<cmd>BufferPrevious<CR>', {})
vim.keymap.set('n', '<C-x>', '<cmd>BufferDelete<CR>', {})

vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {})
vim.keymap.set('n', 'gr', vim.lsp.buf.references, {})

