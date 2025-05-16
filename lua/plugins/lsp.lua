vim.diagnostic.config({
    virtual_text = false,
    severity_sort = true,
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
                pyright = {},
                clangd = {},
                lua_ls = {
                    on_init = function(client)
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
                texlab = {
                    settings = {
                        texlab = {
                            build = {
                                executable = 'tectonic',
                                args = { '-X', 'compile', '%f', '--synctex', '--keep-logs', '--keep-intermediates' },
                                forwardSearchAfter = true, onSave = true
                            },
                            forwardSearch = {
                                executable = 'zathura',
                                args = { '--synctex-forward', '%l:1:%f', '%p' }
                            }
                        }
                    }
                },
            },

            capabilities = require('cmp_nvim_lsp').default_capabilities()
        },

        config = function(_, opts)
            local lspconfig = require('lspconfig')

            lspconfig.util.default_config.capabilities = vim.tbl_deep_extend(
                'force',
                lspconfig.util.default_config.capabilities,
                opts.capabilities
            )
            for server, config in pairs(opts.servers) do
                lspconfig[server].setup(config)
            end
            vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, {})
            vim.keymap.set('n', '<leader>d', function () vim.diagnostic.jump({count=1, float=true}) end, {})
            vim.keymap.set('n', '<leader>D', function () vim.diagnostic.jump({count=-1, float=true}) end, {})
            vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, {})
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {})
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, {})

        end,
    },
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
	{
		'mrcjkb/haskell-tools.nvim',
		opts = false
	},
	{
		'nvim-flutter/flutter-tools.nvim',
		lazy = false,
		dependencies = {
			'nvim-lua/plenary.nvim',
			'stevearc/dressing.nvim', -- optional for vim.ui.select
		},
		config = true,
	},
}
