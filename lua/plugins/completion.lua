-- Completion engine configuration
local cmp_setup = function()
    local cmp = require('cmp')
    local luasnip = require('luasnip')

    cmp.setup({
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered()
        },
        -- Completion sources in priority order
        sources = {
            { name = 'nvim_lsp' },  -- LSP suggestions
            { name = 'luasnip' },   -- Snippet expansions
            { name = 'buffer' },    -- Words from open buffers
            { name = 'path' },      -- Filesystem paths
        },
        snippet = {
            expand = function(args)
              luasnip.lsp_expand(args.body)
            end
        },
        -- Show source icon in the menu column
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
            -- Confirm selection (must explicitly select first; no auto-select)
            ['<CR>'] = cmp.mapping.confirm({select = false}),

            -- Snippet jump backward
            ['<C-p>'] = cmp.mapping(function(fallback)
                if luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, {'i', 's'}),
            -- Snippet jump forward
            ['<C-n>'] = cmp.mapping(function(fallback)
                if luasnip.jumpable(1) then
                    luasnip.jump(1)
                else
                    fallback()
                end
            end, {'i', 's'}),
            -- Double-space also jumps forward in snippets
            ['<space><space>'] = cmp.mapping(function(fallback)
                if luasnip.jumpable(1) then
                    luasnip.jump(1)
                else
                    fallback()
                end
            end, {'i', 's'}),

            -- Tab: cycle through completion menu, or trigger completion if mid-word
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

            -- Shift-Tab: cycle backward through completion menu
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
            'L3MON4D3/LuaSnip',         -- Snippet engine
            'hrsh7th/cmp-buffer',        -- Buffer word source
            'hrsh7th/cmp-cmdline',       -- Command-line completion
            'hrsh7th/cmp-nvim-lsp',      -- LSP source
            'hrsh7th/cmp-path',          -- Path source
        },
    }
}
