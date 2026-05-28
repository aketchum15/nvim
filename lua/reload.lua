-- Hot-reload: unload all modules under lua/ then re-source init.lua
local function reload_config()
  local config_dir = vim.fn.stdpath('config') .. '/lua/'
  for name, _ in pairs(package.loaded) do
    local path = package.searchpath(name, package.path)
    if path and path:find(config_dir, 1, true) then
      package.loaded[name] = nil
    end
  end
  dofile(vim.env.MYVIMRC)
  vim.notify('Config reloaded', vim.log.levels.INFO)
end

-- :Reload command for manual use
vim.api.nvim_create_user_command('Reload', reload_config, {})

-- Auto-reload on save: any .lua file under the config directory triggers a reload
local config_path = vim.fn.stdpath('config')
local watch_group = vim.api.nvim_create_augroup('ConfigReload', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  group = watch_group,
  pattern = config_path .. '/**/*.lua',
  callback = function()
    vim.schedule(reload_config)
  end,
})
