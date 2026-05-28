-- Leader key set to comma for both global and buffer-local mappings
vim.g.mapleader = ','
vim.b.mapleader = ','

-- Line numbers: absolute + relative for easy motion counts
vim.o.number = true
vim.o.relativenumber = true

-- Don't wrap long lines; scroll horizontally instead
vim.o.wrap = false

-- Extra command-line height for messages
vim.o.cmdheight = 2

-- Show signs (git, diagnostics) in the number column to save space
vim.wo.signcolumn = 'number'

-- Indentation: 4 spaces, auto-indent based on syntax
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

-- Search: highlight matches, case-insensitive unless uppercase is used, incremental
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true

-- Keep 5 lines visible above/below cursor when scrolling
vim.o.scrolloff = 5

-- Command-line completion menu; ignore image files
vim.o.wildmenu = true
vim.o.wildignore = "*.jpg,*.png,*.bmp,*.gif,*.jpeg"

-- New splits open below and to the right
vim.o.splitbelow = true
vim.o.splitright = true

-- Use system clipboard for all yank/paste operations
vim.o.clipboard = "unnamedplus"
vim.g.clipbard = "xclip"

-- Enable 24-bit RGB colors in the terminal
vim.o.termguicolors = true

-- Rounded borders on floating windows (nvim 0.11+)
vim.o.winborder = 'rounded'

-- Highlight column 120 as a line-length guide
vim.o.colorcolumn = '120'
