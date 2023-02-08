local user_cmd = vim.api.nvim_create_user_command

local map = function(mode, keys, command, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  if type(keys) == "table" then
    for _, keymap in ipairs(keys) do
      M.map(mode, keymap, command, opts)
    end
    return
  end
  opts = opts or {}
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, keys, command, opts)
end

local M = {}
local opt = {}



M.misc = function()
  local function non_config_mappings()

    -- better up/down
    map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
    map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
    -- Move to window using the <ctrl> hjkl keys
    map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
    map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
    map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
    map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

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

    -- Resize window using <ctrl> arrow keys
    map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
    map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
    map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
    map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

    -- map('n', '<C-x>', ':lua require(\'core.utils\').close_buffer() <CR>', {noremap = true, silent = true})

  end

  non_config_mappings()
end

--M.misc()
--M.terms()
return M
