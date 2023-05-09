local Util = require("lazy.core.util")

local M = {}

M.autoformat = true

function M.toggle()
  if vim.b.autoformat == false then
    vim.b.autoformat = nil
    M.autoformat = true
  else
    M.autoformat = not M.autoformat
  end
  if M.autoformat then
    Util.info("Enabled format on save", { title = "Format" })
  else
    Util.warn("Disabled format on save", { title = "Format" })
  end
end

local lspbufformat = vim.api.nvim_create_augroup("lsp_buf_format", { clear = true })
local format_acmd_go = function()
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = lspbufformat,
    callback = function()
      --vim.lsp.buf.formatting_sync()
      --vim.lsp.buf.format({ async = true })
      vim.lsp.buf.format()
    end,
  })

  -- https://github.com/neovim/nvim-lspconfig/issues/115#issuecomment-866632451
  -- organize imports aka goimports
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.go" },
    group = lspbufformat,
    callback = function()
      --local params = vim.lsp.util.make_range_params(nil, vim.lsp.util._get_offset_encoding())
      local params = vim.lsp.util.make_range_params(nil, vim.lsp.util._get_offset_encoding())
      params.context = { only = { "source.organizeImports" } }
      local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)
      for _, res in pairs(result or {}) do
        for _, r in pairs(res.result or {}) do
          if r.edit then
            vim.lsp.util.apply_workspace_edit(r.edit, vim.lsp.util._get_offset_encoding())
          else
            vim.lsp.buf.execute_command(r.command)
          end
        end
      end
    end,
  })
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
  if vim.b.autoformat == false and not (opts and opts.force) then
    return
  end
  local ft = vim.bo[buf].filetype
  local have_nls = package.loaded["null-ls"]
      and (#require("null-ls.sources").get_available(ft, "NULL_LS_FORMATTING") > 0)

  vim.lsp.buf.format(vim.tbl_deep_extend("force", {
    bufnr = buf,
    filter = function(client)
      if have_nls then
        return client.name == "null-ls"
      end
      return client.name ~= "null-ls"
    end,
  }, require("utils").opts("nvim-lspconfig").format or {}))
end

function M.on_attach(client, buf)
  -- dont format if client disabled it
  if client.config
      and client.config.capabilities
      and client.config.capabilities.documentFormattingProvider == false
  then
    return
  end

  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("LspFormat." .. buf, {}),
      buffer = buf,
      callback = function()
        local filetype = vim.api.nvim_buf_get_option(0, "filetype")
        --local plg = filetypes_attach[filetype]
        --if filetype == "go" then
        --  format_acmd_go()
        --  return
        --end
        if M.autoformat then
          M.format()
          return
        end
      end,
    })
  end
end

return M
