local user_cmd = vim.api.nvim_create_user_command

local map = function(mode, keys, command, opt)
  local options = { noremap = true, silent = true }
  if opt then
    options = vim.tbl_extend("force", options, opt)
  end
  if type(keys) == "table" then
    for _, keymap in ipairs(keys) do
      M.map(mode, keymap, command, opt)
    end
    return
  end
  vim.keymap.set(mode, keys, command, opt)
end

local M = {}
local opt = {}


M.misc = function()
  local function non_config_mappings()
    -- navigation between windows
    map('n', '<C-h>', '<C-w>h')
    map('n', '<C-j>', '<C-w>j')
    map('n', '<C-k>', '<C-w>k')
    map('n', '<C-l>', '<C-w>l')

    -- move cursor within insert mode
    map("i", "<C-h>", "<Left>")
    map("i", "<C-l>", "<Right>")
    map("i", "<C-j>", "<Down>")
    map("i", "<C-k>", "<Up>")
    map("i", "<C-a>", "<ESC>^i")
    map("i", "<C-e>", "<End>")

    -- command line Mode 移动光标
    map('c', '<C-h>', '<Left>', opt)
    map('c', '<C-l>', '<Right>', opt)
    map('c', '<C-j>', '<Down>', opt)
    map('c', '<C-k>', '<Up>', opt)
    map('c', '<C-t>', '[[<C-R>=expand("%:p:h") . "/" <CR>]]', opt)

    -- Move selected line / block of text in visual mode
    map('x', 'K', ':move \'<-2<CR>gv-gv', { noremap = true, silent = true })
    map('x', 'J', ':move \'>+1<CR>gv-gv', { noremap = true, silent = true })

    vim.cmd('vnoremap p "0p')
    vim.cmd('vnoremap P "0P')

    -- map('n', '<C-x>', ':lua require(\'core.utils\').close_buffer() <CR>', {noremap = true, silent = true})

  end

  non_config_mappings()
end

--M.misc()
--M.terms()
return M
