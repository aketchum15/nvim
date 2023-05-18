vim.g.mapleader = ','
vim.b.mapleader = ','

vim.wo.number = true
vim.wo.relativenumber = true

vim.wo.wrap = false

vim.o.cmdheight = 2

vim.wo.signcolumn = 'number'

vim.bo.autoindent = true
vim.bo.smartindent = true
vim.bo.tabstop = 4
vim.bo.shiftwidth = 4
vim.bo.expandtab = true

vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true

vim.o.scrolloff = 5

vim.o.wildmenu = true
vim.o.wildignore = "*.jpg,*.png,*.bmp,*.gif,*.jpeg"

vim.o.splitbelow = true
vim.o.splitright = true

vim.o.clipboard = "unnamedplus"

vim.o.termguicolors = true

vim.o.completeopt = "menuone,noselect"

vim.g.syntax_on = true
vim.cmd.colorscheme('tokyonight')

vim.g.tokyonight_enable_italic = 1
vim.g.tokyonight_transparent_background = 1
vim.g.lightline = {colorscheme = 'tokyonight'}

require('plugins')
require('lsp')
require('maps')
