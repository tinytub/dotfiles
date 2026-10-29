-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

if vim.g.vscode then
  -- 定义一个简单的调用函数提高可读性
  local function vscode_call(cmd)
    return function()
      require("vscode").call(cmd)
    end
  end

  -- 跳转到定义 (Go to Definition)
  vim.keymap.set("n", "gd", vscode_call("editor.action.revealDefinition"))

  -- 查看引用 (Go to References)
  -- VSCode 默认 gr 可能没映射，或者你想用 VSCode 的引用面板
  vim.keymap.set("n", "gr", vscode_call("editor.action.goToReferences"))

  -- 额外建议：查看类型定义 (Go to Type Definition)
  vim.keymap.set("n", "gy", vscode_call("editor.action.goToTypeDefinition"))

  -- 额外建议：符号重命名 (Rename)
  vim.keymap.set("n", "<leader>cr", vscode_call("editor.action.rename"))

  -- 额外建议：悬浮文档 (Hover)
  vim.keymap.set("n", "K", vscode_call("editor.action.showHover"))
end

-- cycle next buffer
vim.keymap.set("n", "<TAB>", "<cmd> BufferLineCycleNext <CR>")
-- cycle prev buffer
vim.keymap.set("n", "<S-Tab>", "<cmd> BufferLineCyclePrev <CR>")

-- "Delete Buffer",
-- vim.keymap.set("n", "<C-x>", LazyVim.ui.bufremove)

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
