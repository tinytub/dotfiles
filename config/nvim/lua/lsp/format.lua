local Util = require "lazy.core.util"

local M = {}

M.opts = nil

vim.b.autoformat = true

M.custom_format = nil

function M.toggle()
  if vim.b.autoformat == false then
    vim.b.autoformat = nil
    M.opts.autoformat = true
  else
    M.opts.autoformat = not M.opts.autoformat
  end
  if M.opts.autoformat then
    Util.info("Enabled format on save", { title = "Format" })
  else
    Util.warn("Disabled format on save", { title = "Format" })
  end
end

local lspbufformat = vim.api.nvim_create_augroup("lsp_buf_format", { clear = true })
local go_org_imports = function(wait_ms)
  local params = vim.lsp.util.make_range_params()
  params.context = { only = { "source.organizeImports" } }
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
  for cid, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
        vim.lsp.util.apply_workspace_edit(r.edit, enc)
      else
        vim.lsp.buf.execute_command(r.command)
      end
    end
  end
end

function M.format_acmd_go()
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = lspbufformat,
    callback = function()
      --vim.lsp.buf.formatting_sync()
      --vim.lsp.buf.format({ async = true })
      go_org_imports(1000)
      vim.lsp.buf.format()
    end,
  })

  -- https://github.com/neovim/nvim-lspconfig/issues/115#issuecomment-866632451
  -- organize imports aka goimports
  --vim.api.nvim_create_autocmd("BufWritePre", {
  --  pattern = { "*.go" },
  --  group = lspbufformat,
  --  callback = function()
  --    --local params = vim.lsp.util.make_range_params(nil, vim.lsp.util._get_offset_encoding())
  --    local params = vim.lsp.util.make_range_params(nil, vim.lsp.util._get_offset_encoding())
  --    params.context = { only = { "source.organizeImports" } }
  --    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)
  --    for _, res in pairs(result or {}) do
  --      for _, r in pairs(res.result or {}) do
  --        if r.edit then
  --          vim.lsp.util.apply_workspace_edit(r.edit, vim.lsp.util._get_offset_encoding())
  --        else
  --          vim.lsp.buf.execute_command(r.command)
  --        end
  --      end
  --    end
  --  end,
  --})
end

---- Default lsp config for filetypes
--local filetypes_attach = setmetatable({
--  -- v0.7
--  --go = require('lsp.format').OrgImports(1000),
--  -- v0.8
--  go = format_acmd_go,
--}, {
--  __index = function()
--    return function() end
--  end,
--})

---@param opts? {force?:boolean}
function M.format(opts)
  local buf = vim.api.nvim_get_current_buf()
  if vim.b.autoformat == false and not (opts and opts.force) then return end

  if M.custom_format and Util.try(function() return M.custom_format(buf) end, { msg = "Custom formatter failed" }) then
    return
  end

  local formatters = M.get_formatters(buf)
  local client_ids = vim.tbl_map(function(client) return client.id end, formatters.active)

  if #client_ids == 0 then
    if opts and opts.force then
      Util.warn("No formatter available", { title = "LazyVim" })
    end
    return
  end

  vim.lsp.buf.format(vim.tbl_deep_extend("force", {
    bufnr = buf,
    filter = function(client) return vim.tbl_contains(client_ids, client.id) end,
  }, require("utils").opts("nvim-lspconfig").format or {}))
end

-- Gets all lsp clients that support formatting.
-- When a null-ls formatter is available for the current filetype,
-- only null-ls formatters are returned.
function M.get_formatters(bufnr)
  local ft = vim.bo[bufnr].filetype
  -- check if we have any null-ls formatters for the current filetype
  local null_ls = package.loaded["null-ls"] and require("null-ls.sources").get_available(ft, "NULL_LS_FORMATTING") or {}

  ---@class LazyVimFormatters
  local ret = {
    ---@type lsp.Client[]
    active = {},
    ---@type lsp.Client[]
    available = {},
    null_ls = null_ls,
  }

  ---@type lsp.Client[]
  local clients = vim.lsp.get_active_clients { bufnr = bufnr }
  for _, client in ipairs(clients) do
    if M.supports_format(client) then
      if (#null_ls > 0 and client.name == "null-ls") or #null_ls == 0 then
        table.insert(ret.active, client)
      elseif client.name == "copilot" then
        table.insert(ret.available, client)
      else
        table.insert(ret.available, client)
      end
    end
  end

  return ret
end

-- Gets all lsp clients that support formatting
-- and have not disabled it in their client config
---@param client lsp.Client
function M.supports_format(client)
  --function M.on_attach(client, buf)
  -- dont format if client disabled it
  if
      client.config
      and client.config.capabilities
      and client.config.capabilities.documentFormattingProvider == false
  then
    return false
  end

  return client.supports_method "textDocument/formatting" or client.supports_method "textDocument/rangeFormatting"

  --if client.supports_method "textDocument/formatting" then
  --  vim.api.nvim_create_autocmd("BufWritePre", {
  --    group = vim.api.nvim_create_augroup("LspFormat." .. buf, {}),
  --    buffer = buf,
  --    callback = function()
  --      local filetype = vim.api.nvim_buf_get_option(0, "filetype")
  --      if filetype == "go" then
  --        format_acmd_go()
  --        return
  --      end
  --      if M.autoformat then
  --        M.format()
  --        return
  --      end
  --    end,
  --  })
  --end
end

---@param opts PluginLspOpts
function M.setup(opts)
  M.opts = opts
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("LazyVimFormat", {}),
    callback = function()
      --local filetype = vim.api.nvim_buf_get_option(0, "filetype")
      --if filetype == "go" then
      --  M.format_acmd_go()
      --  return
      --end

      if M.opts.autoformat then M.format(opts) end
      --M.format(opts)
    end,
  })
end

function M.enabled() return M.opts.autoformat end

return M
