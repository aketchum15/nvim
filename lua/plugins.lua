local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
	"git",
	"clone",
	"--filter=blob:none",
	"https://github.com/folke/lazy.nvim.git",
	"--branch=stable", -- latest stable release
	lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

	{'anuvyklack/hydra.nvim'},

	-- cmp sources
	{'hrsh7th/cmp-buffer'},
	{'hrsh7th/cmp-cmdline'},
	{'hrsh7th/cmp-nvim-lsp'},
	{'hrsh7th/cmp-path'},

	-- completion engine
	{'hrsh7th/nvim-cmp'},

	-- markdown
	{"iamcco/markdown-preview.nvim", cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" }, ft = { "markdown" }, build = function() vim.fn["mkdp#util#install"]() end},


	-- snippets
	{'L3MON4D3/LuaSnip'},

	-- haskell
	{ 'mrcjkb/haskell-tools.nvim', version = '^3', ft = { 'haskell', 'lhaskell', 'cabal', 'cabalproject' }, },

	{ 'NeogitOrg/neogit', dependencies = { 'nvim-lua/plenary.nvim'}, config = true },

	-- lsp shit
	{'neovim/nvim-lspconfig'},
	{'nvimdev/lspsaga.nvim'},

	-- bar
	{'nvim-lualine/lualine.nvim', dependencies = {'nvim-tree/nvim-web-devicons'}},

	{'nvim-lua/plenary.nvim'},
	{'nvim-lua/popup.nvim'},
	{'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'},
	{'nvim-telescope/telescope.nvim'},
	{'nvim-tree/nvim-web-devicons'},
	{'nvim-treesitter/nvim-treesitter'},

	-- colorscheme
	{'nyoom-engineering/oxocarbon.nvim'},

	{'norcalli/nvim-colorizer.lua'},

	-- tabs 
	{'romgrk/barbar.nvim'},
	{'stevearc/aerial.nvim'},

    {
      'mrcjkb/rustaceanvim',
      version = '^4', -- Recommended
      ft = { 'rust' },
    },

	{
	  "rust-lang/rust.vim",
	  ft = "rust",
	  init = function ()
		vim.g.rustfmt_autosave = 1
	  end
  	},

	-- filesystem
	{'stevearc/oil.nvim'},

	-- hints for f and t 
	{'unblevable/quick-scope', init = function () vim.g.qs_highlight_on_keys = {'f', 'F', 't', 'T'} end, lazy=false},

	-- mason
	{'williamboman/mason-lspconfig.nvim'},
	{'williamboman/mason.nvim'}
})

