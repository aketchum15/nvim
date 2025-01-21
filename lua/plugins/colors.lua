local landscape = {
    base00 = '#080D12', base01 = '#202B15', base02 = '#045CA0', base03 = '#486588',
    base04 = '#0279C5', base05 = '#388EAB', base06 = '#1891CE', base07 = '#a7c8e0',
    base08 = '#748c9c', base09 = '#8D826E', base10 = '#045CA0', base11 = '#486588',
    base12 = '#0279C5', base13 = '#388EAB', base14 = '#1891CE', base15 = '#a7c8e0',
}
return {
    {
        'RRethy/base16-nvim',
        main = 'base16-colorscheme',
        opts = 'base16-tokyo-night-dark',
        config = function (_, opts)
            if #opts > 1 then
                require('base16-colorscheme').setup(opts)
            else
                vim.cmd('colorscheme ' .. opts[1])
            end

        end
    }
}
