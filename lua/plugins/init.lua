return {

    {
      "NeogitOrg/neogit",
      dependencies = {
        "nvim-lua/plenary.nvim",         -- required
        "sindrets/diffview.nvim",        -- optional - Diff integration

        -- Only one of these is needed.
        "nvim-telescope/telescope.nvim", -- optional
      },
      config = true
    },

	{
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function()
            vim.fn["mkdp#util#install"]()
        end
    },

	{
        'stevearc/oil.nvim',
        config = true,
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {'nvim-tree/nvim-web-devicons'},
        config = true,
    },

	{
        'unblevable/quick-scope',
        init = function ()
            vim.g.qs_highlight_on_keys = {'f', 'F', 't', 'T'}
        end,
    },
	{
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release \
                && cmake --build build --config Release \
                && cmake --install build --prefix build'
    },
	{
        'nvim-telescope/telescope.nvim',
        opts = {
            extensions = {
                aerial = {},
                fzf = {}
            }
        },
        config = function(_, opts)
            local telescope = require('telescope')
            telescope.setup(opts)
            for extension, _ in pairs(opts.extensions) do
                telescope.load_extension(extension)
            end
        end,
        keys = {
            {'<leader>f', '<cmd>Telescope find_files<cr>', {}},
            {'<leader>F', '<cmd>Telescope aerial<CR>', {}},
            {'<leader>b', '<cmd>Telescope buffers<CR>', {}},
            {'<leader>g', '<cmd>Telescope grep_string<CR>', {}},
        }
    },
	{'nvim-treesitter/nvim-treesitter'},
	{
        'norcalli/nvim-colorizer.lua',
        main = 'colorizer',
        config = true,

    },
	{
        'romgrk/barbar.nvim',
        init = function()
            vim.g.barbar_auto_setup = false
        end,
        opts = {
            auto_hide = true,
            clickable = false,
            insert_at_end = true,
            semantic_letters = false,
            no_name_title = 'New Buffer',
            icons = {
                buffer_index = true,
                button = '',
            },
          },
    },
	{
        'stevearc/aerial.nvim',
        config = true,
    },
}
