vim.g.mapleader = ','
vim.b.mapleader = ','
require('plugins')

vim.wo.number = true
vim.wo.relativenumber = true

vim.wo.wrap = false

vim.o.cmdheight = 2

vim.wo.signcolumn = 'number'

vim.bo.autoindent = true
vim.bo.smartindent = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.bo.expandtab = true

vim.g.qs_highlight_on_keys = {'f', 'F', 't', 'T'}

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

vim.g.tokyonight_enable_italic = 1
vim.g.tokyonight_transparent_background = 1
vim.opt.background = 'dark'
vim.cmd.colorscheme('oxocarbon')

require('telescope').setup({
  extensions = {
    aerial = {}
  }
})
vim.g.barbar_auto_setup = false -- disable auto-setup

require'barbar'.setup {
  -- Enable/disable auto-hiding the tab bar when there is a single buffer
  auto_hide = true,

  clickable = false,

  icons = {
    buffer_index = true,
    button = '',
  },

  insert_at_end = true,

  semantic_letters = false,

  no_name_title = 'New Buffer',
}
require('lualine').setup()
require('aerial').setup()
require("oil").setup()
require('telescope').load_extension('aerial')
require('lsp')
require('maps')
require('hydras')
