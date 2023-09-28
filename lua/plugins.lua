-- vim.cmd [[packadd packer.nvim]]
require('packer').startup(function(use)
    -- colorscheme
    use 'nyoom-engineering/oxocarbon.nvim'
    use 'ghifarit53/tokyonight-vim'

    -- completion engine
    use 'hrsh7th/nvim-cmp'

    -- markdown preview
    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    })
    -- cmp sources
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-path'
    -- bar
	use {
	  'nvim-lualine/lualine.nvim',
	  requires = { 'nvim-tree/nvim-web-devicons', opt = true }
	}
    use 'romgrk/barbar.nvim'

    use 'stevearc/aerial.nvim'
    use 'stevearc/oil.nvim'
    use 'nvim-tree/nvim-web-devicons'
    use 'anuvyklack/hydra.nvim'
    use 'unblevable/quick-scope'
	use 'L3MON4D3/LuaSnip'
    use 'neovim/nvim-lspconfig'
    use 'simrat39/rust-tools.nvim'
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

--require('telescope').load_extension('fzf')
--require("luasnip.loaders.from_vscode").lazy_load()
