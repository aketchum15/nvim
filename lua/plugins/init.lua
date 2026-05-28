return {

    -- Git UI (magit-like interface)
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

    -- File explorer that edits the filesystem like a buffer
    {
        'stevearc/oil.nvim',
        config = true,
    },
    -- Statusline with aerial symbol breadcrumbs
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {'nvim-tree/nvim-web-devicons'},
        config = true,
        opts = {
            sections = {
                lualine_c = {'filename', 'aerial'},
            },
        },
    },

    -- Highlight unique characters for f/F/t/T motions
	{
        'unblevable/quick-scope',
        init = function ()
            vim.g.qs_highlight_on_keys = {'f', 'F', 't', 'T'}
        end,
    },
    -- Native FZF sorter for telescope (faster filtering)
	{
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
    },
    -- Fuzzy finder for files, buffers, symbols, and grep
	{
        'nvim-telescope/telescope.nvim',
        opts = {
            defaults = {
                border = true,
                borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
            },
            extensions = {
                aerial = {
                    show_columns = 'symbols'
                },
                fzf = {}
            }
        },
        config = function(_, opts)
            local telescope = require('telescope')
            telescope.setup(opts)
            -- Auto-load all extensions defined in opts
            for extension, _ in pairs(opts.extensions) do
                telescope.load_extension(extension)
            end
        end,
        keys = {
            {'<leader>f', '<cmd>Telescope find_files<cr>', {}},
            {'<leader>F', '<cmd>Telescope aerial<CR>', {}},
            {'<leader>b', '<cmd>Telescope buffers<CR>', {}},
            {'<leader>g', '<cmd>Telescope grep_string<CR>', {}},
            {'<leader>g', function()
                local start_pos = vim.fn.getpos('v')
                local end_pos = vim.fn.getpos('.')
                local lines = vim.api.nvim_buf_get_text(0, start_pos[2] - 1, start_pos[3] - 1, end_pos[2] - 1, end_pos[3], {})
                local text = table.concat(lines, '\n')
                require('telescope.builtin').grep_string({ search = text })
            end, mode = 'v'},
        }
    },
    -- Treesitter: syntax highlighting, folds, and text objects
	{'nvim-treesitter/nvim-treesitter'},
    -- Inline color previews (hex codes, etc.)
	{
        'norcalli/nvim-colorizer.lua',
        main = 'colorizer',
        config = true,

    },
    -- Tab bar for open buffers with index labels
	{
        'romgrk/barbar.nvim',
        init = function()
            vim.g.barbar_auto_setup = false
        end,
        opts = {
            auto_hide = true,       -- Hide bar when only one buffer is open
            clickable = false,
            insert_at_end = true,   -- New buffers appear on the right
            semantic_letters = false,
            no_name_title = 'New Buffer',
            icons = {
                buffer_index = true,
                button = '',
            },
          },
    },
    -- Code outline / symbol tree (used by lualine and telescope)
	{
        'stevearc/aerial.nvim',
        config = true,
    },
    -- Session persistence: auto-save/restore sessions per directory
    {
      "folke/persistence.nvim",
      event = "BufReadPre", -- this will only start session saving when an actual file was opened
      opts = {
        -- add any custom options here
      }
    },
}
