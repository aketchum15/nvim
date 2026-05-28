-- Entry point: load core config modules in order
require('options')        -- Editor settings (indentation, search, display)
require('package_manager') -- Bootstrap and configure lazy.nvim plugin manager

require('keymaps')        -- Custom key mappings
require('folds')          -- Code folding (treesitter/LSP)

require('reload')         -- Auto-reload config on save
