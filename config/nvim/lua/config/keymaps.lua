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

---- floating terminal
--local lazyterm = function()
--  LazyVim.terminal(nil, { cwd = LazyVim.root() })
--end
--vim.keymap.set("n", "<leader>ft", lazyterm, { desc = "Terminal (Root Dir)" })
--vim.keymap.set("n", "<leader>fT", function()
--  LazyVim.terminal()
--end, { desc = "Terminal (cwd)" })
--vim.keymap.set("n", "<c-/>", lazyterm, { desc = "Terminal (Root Dir)" })
--vim.keymap.set("n", "<c-_>", lazyterm, { desc = "which_key_ignore" })
--
---- Terminal Mappings
--vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
--vim.keymap.set("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to left window" })
--vim.keymap.set("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to lower window" })
--vim.keymap.set("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to upper window" })
--vim.keymap.set("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to right window" })
--vim.keymap.set("t", "<C-\\>", "<cmd>close<cr>", { desc = "Hide Terminal" })
