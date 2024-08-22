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
-- helper function to determine if in git repo or not
project_files = function()
  local opts = {} -- define here if you want to define something

  local cwd = vim.fn.getcwd()
  if is_inside_work_tree[cwd] == nil then
    vim.fn.system("git rev-parse --is-inside-work-tree")
    is_inside_work_tree[cwd] = vim.v.shell_error == 0
  end

  if is_inside_work_tree[cwd] then
    builtin.git_files(opts)
  else
    builtin.find_files(opts)
  end
end
-- find files
map('n', '<leader>f', '<cmd>Telescope git_files<CR>')
map('n', '<leader>F', '<cmd>Telescope aerial<CR>')
map('n', '<leader>b', '<cmd>Telescope buffers<CR>')

-- grep the string under the cursor
map('n', '<leader>g', '<cmd>Telescope grep_string<CR>')

-- buffer movement
map('n', '<C-n>', '<cmd>BufferNext<CR>')
map('n', '<C-p>', '<cmd>BufferPrevious<CR>')
map('n', '<C-x>', '<cmd>BufferDelete<CR>')

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

-- code actions
map('n', '<leader>ca', '<cmd>Lspsaga code_action<CR>')
