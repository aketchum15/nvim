require('packer').startup(function(use)
    -- colorscheme
    use 'ghifarit53/tokyonight-vim'

    -- cmp sources
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-path'

    -- completion engine
    use 'hrsh7th/nvim-cmp'

    -- bar
    use 'itchyny/lightline.vim'

	use 'L3MON4D3/LuaSnip'
    use 'neovim/nvim-lspconfig'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-lua/popup.nvim'
    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
    }
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-tree/nvim-web-devicons'
    use 'nvim-treesitter/nvim-treesitter'
    use 'wbthomason/packer.nvim'
    use {
        "williamboman/mason.nvim",
        run = ':MasonUpdate'
    }
    use 'williamboman/mason-lspconfig.nvim'
end)

require('telescope').load_extension('fzf')
require("luasnip.loaders.from_vscode").lazy_load()
