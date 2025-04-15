local cmp_setup = function()
    local cmp = require('cmp')
    local luasnip = require('luasnip')

    cmp.setup({
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered()
        },
        sources = {
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
            { name = 'buffer' },
            { name = 'path' },
        },
        snippet = {
            expand = function(args)
              luasnip.lsp_expand(args.body)
            end
        },
        formatting = {
          fields = {'menu', 'abbr', 'kind'},
          format = function(entry, item)
            local menu_icon = {
              nvim_lsp = '',
              luasnip = '',
              buffer = '',
              path = ''
            }

            item.menu = menu_icon[entry.source.name]
            return item
          end,
        },
        mapping = {
            ['<CR>'] = cmp.mapping.confirm({select = false}),

            ['<C-p>'] = cmp.mapping(function(fallback)
                if luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, {'i', 's'}),
            ['<C-n>'] = cmp.mapping(function(fallback)
                if luasnip.jumpable(1) then
                    luasnip.jump(1)
                else
                    fallback()
                end
            end, {'i', 's'}),
            ['<space><space>'] = cmp.mapping(function(fallback)
                if luasnip.jumpable(1) then
                    luasnip.jump(1)
                else
                    fallback()
                end
            end, {'i', 's'}),

            ['<Tab>'] = cmp.mapping(function(fallback)
              local col = vim.fn.col('.') - 1
              if cmp.visible() then
                cmp.select_next_item()
              elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
                fallback()
              else
                cmp.complete()
              end
            end, {'i', 's'}),

            ['<S-Tab>'] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              else
                fallback()
              end
            end, {'i', 's'}),
        }
    })
end

return {
    {
        'hrsh7th/nvim-cmp',
        opts = cmp_setup,
        dependencies = {
            'L3MON4D3/LuaSnip',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
        },
    }
}
