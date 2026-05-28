-- Diagnostic display settings
vim.diagnostic.config({
    virtual_text = false,       -- No inline diagnostic text (use floating window instead)
    severity_sort = true,       -- Show most severe diagnostics first
    underline = true,
    float = {
		source = false,
		border = 'rounded',
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = '',
			[vim.diagnostic.severity.WARN] = '',
			[vim.diagnostic.severity.INFO] = '',
			[vim.diagnostic.severity.HINT] = '',
		}
	}
})

return {
	{
        'neovim/nvim-lspconfig',
        opts = {
            servers = {
                -- rust_analyzer = {
                --     diagnostics = {
                --         enable = true;
                --     },
                -- },
                pyright = {},       -- Python
                clangd = {},        -- C/C++
                nil_ls = {},        -- Nix
                lua_ls = {          -- Lua (Neovim config aware)
                    on_init = function(client)
                        -- Skip custom config if project has its own .luarc.json
                        local path = client.workspace_folders[1].name
                        if vim.uv.fs_stat(path..'/.luarc.json') or vim.uv.fs_stat(path..'/.luarc.jsonc') then
                          return
                        end

                        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                          runtime = {
                            -- Tell the language server which version of Lua you're using
                            -- (most likely LuaJIT in the case of Neovim)
                            version = 'LuaJIT'
                          },
                          -- Make the server aware of Neovim runtime files
                            workspatextDocumentce = {
                                checkThirdParty = false,
                                library = {
                                    vim.env.VIMRUNTIME,
                                    -- Depending on the usage, you might want to add additional paths here.
                                    '/usr/share/lua',
                                },
                            },
                      })
                    end,
                    settings = {
                        Lua = {}
                    }
                },
            },

            capabilities = require('cmp_nvim_lsp').default_capabilities()
        },

        config = function(_, opts)
            -- Disable semantic tokens (rely on treesitter highlighting instead)
            vim.api.nvim_create_autocmd('LspAttach', {
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if client then
                        client.server_capabilities.semanticTokensProvider = nil
                    end
                end,
            })

            local lspconfig = require('lspconfig')

            -- Merge nvim-cmp capabilities into the default LSP config
            lspconfig.util.default_config.capabilities = vim.tbl_deep_extend(
                'force',
                lspconfig.util.default_config.capabilities,
                opts.capabilities
            )
            -- Enable each configured server
            for server, config in pairs(opts.servers) do
                if next(config) ~= nil then
                    vim.lsp.config(server, config)
                end
                vim.lsp.enable(server)
            end

            -- Diagnostic navigation and LSP action keymaps
            vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, {})
            vim.keymap.set('n', '<leader>d', function () vim.diagnostic.jump({count=1, float=true}) end, {})
            vim.keymap.set('n', '<leader>D', function () vim.diagnostic.jump({count=-1, float=true}) end, {})
            vim.keymap.set('n', '<leader>r', '<cmd>Lspsaga rename<CR>', {})
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {})
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, {})

        end,
    },
    -- LSP UI enhancements (rename popup, code actions, etc.)
    {
        'nvimdev/lspsaga.nvim',
        opts = {
            ui = {border = 'rounded'},
            code_action = {
                only_in_cursor = false,
                keys = {quit = '<ESC>'}
            },
            lightbulb = {enable = false},
            symbol_in_winbar = {enable = false},
        },
        config = function(_, opts)
            local lspsaga = require('lspsaga')
            lspsaga.setup(opts)
            vim.keymap.set('n', '<leader>ca', '<cmd>Lspsaga code_action<CR>', {})
        end
    },
    -- Haskell tooling (haskell-language-server integration)
	{
		'mrcjkb/haskell-tools.nvim',
		opts = false
	},
    -- Rust tooling (rust-analyzer integration with extra features)
    {
        'mrcjkb/rustaceanvim',
        -- To avoid being surprised by breaking changes,
        -- I recommend you set a version range
        version = '^9',
        -- This plugin implements proper lazy-loading (see :h lua-plugin-lazy).
        -- No need for lazy.nvim to lazy-load it.
        lazy = false,
    }
}
