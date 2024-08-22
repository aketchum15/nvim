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

vim.g.vimtex_compiler_method = 'tectonic'
vim.g.vimtex_view_method = 'zathura'

vim.g.tokyonight_enable_italic = 1
vim.g.tokyonight_transparent_background = 1
vim.opt.background = 'dark'
vim.cmd.colorscheme('oxocarbon')
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })

require('telescope').setup({
  extensions = {
    aerial = {},
    fzf = {},
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
require('oil').setup()
require'colorizer'.setup()
require('telescope').load_extension('aerial')
require('telescope').load_extension('fzf')
require('lsp')
require('maps')

function ExportColorsKitty()
    local fn = vim.fn
    local filename = os.getenv("HOME") .. "/nvim_export.conf"
    local file = io.open(filename, "w")
    io.output(file)
    io.write("# vim:ft=kitty" .. "\n\n")
    io.write("# exported from " .. vim.g.colors_name .. "\n\n")
    local fg = fn.synIDattr(fn.hlID("Normal"), "fg")
    local bg = fn.synIDattr(fn.hlID("Normal"), "bg")
    io.write("foreground " .. fg .. "\n")
    io.write("background " .. bg .. "\n")
    io.write("selection_foreground " .. bg .. "\n")
    io.write("selection_background " .. fg .. "\n")
    for i = 0,15 do
        local var = "g:terminal_color_" .. tostring(i)
        if fn.exists(var) == 1 then
            local tc = fn.eval(var)
            io.write("color" .. tostring(i) .. " " .. tc .. "\n")
            if i == 2 then
                io.write("cursor " .. tc .. "\n")
            end
        end
    end
    io.close(file)
    print("Colors exported to " .. filename)
end

-- base00 = "#161616",
-- base01 = "#262626",
-- base02 = "#393939",
-- base03 = "#525252",
-- base04 = "#d0d0d0",
-- base05 = "#f2f2f2",
-- base06 = "#ffffff",
-- base07 = "#08bdba",
-- base08 = "#3ddbd9",
-- base09 = "#78a9ff",
-- base10 = "#ee5396",
-- base11 = "#33b1ff",
-- base12 = "#ff7eb6",
-- base13 = "#42be65",
-- base14 = "#be95ff",
-- base15 = "#82cfff",
-- blend = "#131313",
-- none = "NONE"
