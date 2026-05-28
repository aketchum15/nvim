-- Clear search highlighting with <leader><space>
vim.keymap.set('n', '<leader><space>', '<cmd>nohl<cr>', {})

-- Buffer navigation (barbar.nvim tab bar)
vim.keymap.set('n', '<C-n>', '<cmd>BufferNext<CR>', {})
vim.keymap.set('n', '<C-p>', '<cmd>BufferPrevious<CR>', {})
vim.keymap.set('n', '<C-x>', '<cmd>BufferDelete<CR>', {})

-- LSP navigation shortcuts
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {})
vim.keymap.set('n', 'gr', vim.lsp.buf.references, {})


-- Yank relative file path to system clipboard
vim.keymap.set('n', 'yp', function()
    vim.fn.setreg('+', vim.fn.expand('%'))
    vim.notify('copied file path')
end, { desc = 'Yank relative file path' })

-- Yank relative file path + current line number
vim.keymap.set('n', 'yP', function()
    vim.fn.setreg('+', vim.fn.expand('%') .. ':' .. vim.fn.line('.'))
    vim.notify('copied file path + line')
end, { desc = 'Yank relative file path + line' })


local get_gh_link = function(opts)
    local filepath = vim.fn.expand('%:p')

    local remote = vim.fn.system('git remote get-url origin'):gsub('%s+$', '')
    if vim.v.shell_error ~= 0 then
        vim.notify('Not a git repository or no origin remote', vim.log.levels.ERROR)
        return
    end

    local toplevel = vim.fn.system('git rev-parse --show-toplevel'):gsub('%s+$', '')
    local rel_path = filepath:sub(#toplevel + 2)

    -- Convert SSH remote URL to HTTPS format
    local url = remote
        :gsub('git@([^:]+):', 'https://%1/')
        :gsub('%.git$', '')

    local link
    if opts.master then
        link = url .. '/blob/master' .. '/' .. rel_path
    else
        local sha = vim.fn.system('git rev-parse HEAD'):gsub('%s+$', '')
        link = url .. '/blob/' .. sha .. '/' .. rel_path
    end
    if opts.line then
        local line = vim.fn.line('.')
        link = link .. '#L' .. line
    end
    return link
end

-- Yank a permalink to the current file on the git remote (pinned to HEAD SHA)
vim.keymap.set('n', 'yl', function()
    local link = get_gh_link({master = false, line = false})

    vim.fn.setreg('+', link)
    vim.notify('copied git link')
end, { desc = 'Yank git origin link' })

-- Yank a permalink to the current file + line on the git remote
vim.keymap.set('n', 'yL', function()
    local link = get_gh_link({master = true, line = true})

    vim.fn.setreg('+', link)
    vim.notify('copied git origin link line')
end, { desc = 'Yank git origin link + line' })

-- Show git blame info for the current line in a floating window
local function git_blame_line()
  local filepath = vim.fn.expand('%:p')
  local line = vim.fn.line('.')

  if filepath == '' or vim.bo.buftype ~= '' then
    vim.notify('Not a file buffer', vim.log.levels.WARN)
    return
  end

  -- Use --porcelain format for machine-readable blame output
  local cmd = string.format('git blame -L %d,%d --porcelain -- %s', line, line, vim.fn.shellescape(filepath))

  vim.fn.jobstart(cmd, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      if not data or #data == 0 or (data[1] == '' and #data == 1) then
        return
      end

      -- Parse porcelain output into key-value pairs
      local info = {}
      for _, l in ipairs(data) do
        local key, val = l:match('^(%S+)%s(.+)$')
        if key then
          info[key] = val
        end
      end

      local commit = (data[1] or ''):match('^(%x+)')
      local author = info['author'] or 'Unknown'
      local date = info['author-time']
      local summary = info['summary'] or ''

      if date then
        date = os.date('%Y-%m-%d %H:%M', tonumber(date))
      else
        date = 'Unknown'
      end

      -- All-zero commit hash means uncommitted changes
      local is_uncommitted = commit and commit:match('^0+$')
      local lines
      if is_uncommitted then
        lines = { 'Uncommitted changes' }
      else
        lines = {
          'Commit: ' .. (commit or '?'):sub(1, 8),
          'Author: ' .. author,
          'Date:   ' .. date,
          '',
          summary,
        }
      end

      vim.schedule(function()
        vim.lsp.util.open_floating_preview(lines, 'markdown', { border = 'rounded' })
      end)
    end,
    on_stderr = function(_, data)
      if data and data[1] ~= '' then
        vim.schedule(function()
          vim.notify('git blame: ' .. table.concat(data, '\n'), vim.log.levels.ERROR)
        end)
      end
    end,
  })
end

vim.keymap.set('n', '<leader>B', git_blame_line, { desc = 'Git blame current line' })
