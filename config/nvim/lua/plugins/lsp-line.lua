M = {}

local vim = vim
-- local notify = vim.notify
-- local cmd = vim.cmd
local api = vim.api
local diagnostic = vim.diagnostic

-- 默认使用单行虚拟行，可以使用快捷键进行切换
local is_virtual_text = false
local function toggle_virtual_line()
  if is_virtual_text then
    diagnostic.config({
      virtual_text = false,
      --virtual_lines = { only_current_line = true }
      virtual_lines = true
    })
    is_virtual_text = false
  else
    -- 和lspconfig内一样
    diagnostic.config({
      virtual_text = false,
      virtual_lines = false,
      --virtual_text = {
      --  spacing = 4,
      --  prefix = '●',
      --  source = 'always',
      --  severity = {
      --    min = vim.diagnostic.severity.HINT,
      --  },
      --},
      --virtual_lines = false,
    })
    is_virtual_text = true
  end
end

M.setup = function()
  -- Disable virtual_text since it's redundant due to lsp_lines.
  local ok, lsp_lines = pcall(require, "lsp_lines")
  if not ok then
    return
  end

  lsp_lines.setup()
  toggle_virtual_line()

  api.nvim_create_user_command('ToggleLspVirtualLine', toggle_virtual_line, {})
  -- api.nvim_set_keymap("n", "<leader>vv", "<cmd> ToggleLspVirtualLine <CR>",
  --   { noremap = true, silent = true, desc = "开关诊断增强" })
end

return M
