-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
-- cycle next buffer
vim.keymap.set("n", "<TAB>", "<cmd> BufferLineCycleNext <CR>")
-- cycle prev buffer
vim.keymap.set("n", "<S-Tab>", "<cmd> BufferLineCyclePrev <CR>")

-- "Delete Buffer",
vim.keymap.set("n", "<C-x>", LazyVim.ui.bufremove)

-- remove move up / move down
-- v  <M-k>       * :m '<-2<CR>gv=gv
--                  Move Up
-- v  <M-j>       * :m '>+1<CR>gv=gv
--                  Move Down
vim.keymap.del("", "<M-j>")
vim.keymap.del("", "<M-k>")

-- move cursor within insert mode
vim.keymap.set("i", "<C-h>", "<Left>")
vim.keymap.set("i", "<C-l>", "<Right>")
vim.keymap.set("i", "<C-j>", "<Down>")
vim.keymap.set("i", "<C-k>", "<Up>")
vim.keymap.set("i", "<C-a>", "<ESC>^i")
vim.keymap.set("i", "<C-e>", "<End>")

vim.keymap.set("c", "<C-h>", "<Left>")
vim.keymap.set("c", "<C-l>", "<Right>")
vim.keymap.set("c", "<C-j>", "<Down>")
vim.keymap.set("c", "<C-k>", "<Up>")
vim.keymap.set("c", "<C-t>", '[[<C-R>=expand("%:p:h") . "/" <CR>]]')

vim.keymap.set("n", "<Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
vim.keymap.set("n", "<Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

vim.cmd('vnoremap p "0p')
vim.cmd('vnoremap P "0P')
