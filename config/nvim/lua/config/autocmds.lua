-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
-- close some filetypes with <q>

local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q_extend"),
  pattern = {
    "fugitive",
    "git",
    "fugitiveblame",
    "kitty-scrollback",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- disable markdown spell check
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "txt" },
  callback = function()
    vim.opt_local.spell = false
  end,
})

local function disable_yaml_template_formatting(buf)
  if vim.bo[buf].filetype == "yaml" and table.concat(vim.api.nvim_buf_get_lines(buf, 0, -1, false), "\n"):find("{{", 1, true) then
    vim.b[buf].autoformat = false
  end
end

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("disable_yaml_template_formatting"),
  pattern = "yaml",
  callback = function(event)
    disable_yaml_template_formatting(event.buf)
  end,
})

for _, buf in ipairs(vim.api.nvim_list_bufs()) do
  disable_yaml_template_formatting(buf)
end
