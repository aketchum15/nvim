local Hydra = require('hydra')
local telescope = require('telescope')

local buf_hint = [[
 ^^  Focus     ^^   Move     ^^   Order   
 ^^----------  ^^----------  ^^----------
   _j_ _k_         _J_  _K_        _od_  _ol_ 
 ^^^^^^                         dir  lang

 ^^_d_: close  _p_: pin  _b_: Telescope 
]]

Hydra({
   name = 'Barbar',
   config = {
      invoke_on_body = true,
      on_key = function()
         -- Preserve animation
         vim.wait(200, function() vim.cmd 'redraw' end, 30, false)
      end
   },
   body = '<leader>b',
   hint = buf_hint,
   heads = {
      { 'b', function () vim.cmd('Telescope buffers') end, { exit = true, on_key = false } },
      { 'j', function() vim.cmd('BufferPrevious') end, { on_key = false } },
      { 'k', function() vim.cmd('BufferNext') end, { desc = 'choose', on_key = false } },

      { 'J', function() vim.cmd('BufferMovePrevious') end },
      { 'K', function() vim.cmd('BufferMoveNext') end, { desc = 'move' } },

      { 'p', function() vim.cmd('BufferPin') end, { desc = 'pin' } },

      { 'd', function() vim.cmd('BufferClose') end, { desc = 'close' } },

      { 'od', function() vim.cmd('BufferOrderByDirectory') end, { desc = 'by directory' } },
      { 'ol', function() vim.cmd('BufferOrderByLanguage') end,  { desc = 'by language' } },
      { '<Esc>', nil, { exit = true } }
   }
})

local function choose_buffer()
   if #vim.fn.getbufinfo({ buflisted = true }) > 1 then
      buffer_hydra:activate()
   end
end

vim.keymap.set('n', 'gb', choose_buffer)


