local Utils = require "utils"

--local map = function(mode, keys, command, opts)
--  local options = { noremap = true, silent = true }
--  if opts then options = vim.tbl_extend("force", options, opts) end
--  if type(keys) == "table" then
--    for _, keymap in ipairs(keys) do
--      M.map(mode, keymap, command, opts)
--    end
--    return
--  end
--  opts = opts or {}
--  opts.silent = opts.silent ~= false
--  vim.keymap.set(mode, keys, command, opts)
--end
local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    if opts.remap and not vim.g.vscode then
      opts.remap = nil
    end
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

local opt = {}

-- better up/down
map({ "n", "v" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "v" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- move cursor within insert mode
map("i", "<C-h>", "<Left>")
map("i", "<C-l>", "<Right>")
map("i", "<C-j>", "<Down>")
map("i", "<C-k>", "<Up>")
map("i", "<C-a>", "<ESC>^i")
map("i", "<C-e>", "<End>")

-- command line Mode 移动光标
map("c", "<C-h>", "<Left>", opt)
map("c", "<C-l>", "<Right>", opt)
map("c", "<C-j>", "<Down>", opt)
map("c", "<C-k>", "<Up>", opt)
map("c", "<C-t>", '[[<C-R>=expand("%:p:h") . "/" <CR>]]', opt)

vim.cmd 'vnoremap p "0p'
vim.cmd 'vnoremap P "0P'

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Move Lines
--map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
--map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
--map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
--map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
--map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
--map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- map('n', '<C-x>', ':lua require(\'core.utils\').close_buffer() <CR>', {noremap = true, silent = true})

-- buffers
if Utils.has "bufferline.nvim" then
  map("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
  map("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
  map("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
  map("n", "]b", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
else
  map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
  map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
  map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
  map("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
end
--map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
--map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
map(
  "n",
  "<leader>ur",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / clear hlsearch / diff update" }
)

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
map(
  "n",
  "<leader>ur",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / clear hlsearch / diff update" }
)

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- lazy
map("n", "<leader>L", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- new file
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

-- toggle options
map("n", "<leader>uf", require("lsp.format").toggle, { desc = "Toggle format on Save" })
map("n", "<leader>us", function() Utils.toggle("spell") end, { desc = "Toggle Spelling" })
map("n", "<leader>uw", function() Utils.toggle("wrap") end, { desc = "Toggle Word Wrap" })
map("n", "<leader>ul", function() Utils.toggle_number() end, { desc = "Toggle Line Numbers" })
map("n", "<leader>ud", Utils.toggle_diagnostics, { desc = "Toggle Diagnostics" })
local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
map("n", "<leader>uc", function() Utils.toggle("conceallevel", false, { 0, conceallevel }) end,
  { desc = "Toggle Conceal" })
if vim.lsp.inlay_hint then
  map("n", "<leader>uh", function() vim.lsp.inlay_hint(0, nil) end, { desc = "Toggle Inlay Hints" })
end


map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

-- floating terminal
local lazyterm = function() Utils.float_term(nil, { cwd = Utils.get_root() }) end
--map("n", "<leader>ft", lazyterm, { desc = "Terminal (root dir)" })
map("n", "<leader>w", lazyterm, { desc = "Terminal (root dir)" })
map("n", "<leader>fT", function() Utils.float_term() end, { desc = "Terminal (cwd)" })
map("n", "<c-/>", lazyterm, { desc = "Terminal (root dir)" })
map("n", "<c-_>", lazyterm, { desc = "which_key_ignore" })

-- Terminal Mappings
map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
map("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to left window" })
map("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to lower window" })
map("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to upper window" })
map("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to right window" })
map("t", "<C-\\>", "<cmd>close<cr>", { desc = "Hide Terminal" })
map("t", "<c-_>", "<c-/>", { remap = true, desc = "which_key_ignore" })

map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
