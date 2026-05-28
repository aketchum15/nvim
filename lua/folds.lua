-- Start with all folds open (foldlevel 99 = nothing folded)
vim.o.foldlevel = 99
vim.o.foldmethod = 'expr'
-- Default to treesitter-based folding
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
-- Upgrade to LSP-based folding when the server supports it (more accurate for some languages)
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
	assert(client)
    if client:supports_method('textDocument/foldingRange') then
      local win = vim.api.nvim_get_current_win()
      vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
    end
  end,
})
