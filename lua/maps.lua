local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- clear highlighting
map('n', '<space><space>', '<cmd>noh<CR>', {silent = true})
-- yank until end of line instead of yank whole line
map('n', 'Y', 'y$')

-- Telescope

-- find files
map('n', '<leader>f', '<cmd>Telescope git_files<CR>')
map('n', '<leader>F', '<cmd>Telescope aerial<CR>')

-- grep the string under the cursor
map('n', '<leader>g', '<cmd>Telescope grep_string<CR>')

-- lsp

-- goto declaration/definition 
map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', { silent = true })
map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { silent = true })

-- show hover info about the symbol
map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', { silent = true })
-- list all implementations 
map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', { silent = true })
-- show functions signature help
map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { silent = true })

-- bulk rename
map('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>', { silent = true })

-- list references
map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', { silent = true })

-- jump to errors
map('n', '<leader>d', '<cmd>lua vim.diagnostic.goto_next()<CR>', { silent = true })
map('n', '<leader>D', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { silent = true })

-- show diagnostics
map('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<cr>')
