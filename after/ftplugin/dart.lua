
vim.o.tabstop = 2
vim.o.shiftwidth = 2

vim.keymap.set('n', '<leader>R', '<cmd>FlutterRestart<CR>', {})

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.dart",
  callback = function()
    vim.cmd("FlutterReload")
  end,
})
