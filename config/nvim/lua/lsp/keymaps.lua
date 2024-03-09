local M = {}

---@type LazyKeysLspSpec[]|nil
M._keys = nil

---@alias LazyKeysLspSpec LazyKeysSpec|{has?:string}
---@alias LazyKeysLsp LazyKeys|{has?:string}

---@return LazyKeysLspSpec[]
function M.get()
  if M._keys then
    return M._keys
  end
  -- stylua: ignore
  M._keys = {
    {
      "<leader>cd",
      vim.diagnostic.open_float,
      desc = "Line Diagnostics"
    },
    {
      "<leader>cl",
      "<cmd>LspInfo<cr>",
      desc = "Lsp Info"
    },
    {
      "gd",
      function() require("telescope.builtin").lsp_definitions() end,
      desc = "Goto Definition",
      has = "definition"
    },
    {
      "gr",
      "<cmd>Telescope lsp_references<cr>",
      desc = "References"
    },
    {
      "gD",
      vim.lsp.buf.declaration,
      desc = "Goto Declaration"
    },
    {
      "gI",
      function() require("telescope.builtin").lsp_implementations() end,
      desc = "Goto Implementation"
    },
    {
      "gy",
      function() require("telescope.builtin").lsp_type_definitions() end,
      desc = "Goto T[y]pe Definition"
    },
    {
      "K",
      vim.lsp.buf.hover,
      desc = "Hover"
    },
    {
      "gK",
      vim.lsp.buf.signature_help,
      desc = "Signature Help",
      has = "signatureHelp"
    },
    {
      "<c-k>",
      vim.lsp.buf.signature_help,
      mode = "i",
      desc = "Signature Help",
      has = "signatureHelp"
    },
    {
      "<leader>ca",
      vim.lsp.buf.code_action,
      desc = "Code Action",
      mode = { "n", "v" },
      has = "codeAction"
    },
    { "<leader>cc", vim.lsp.codelens.run, desc = "Run Codelens", mode = { "n", "v" }, has = "codeLens" },
    { "<leader>cC", vim.lsp.codelens.refresh, desc = "Refresh & Display Codelens", mode = { "n" }, has = "codeLens" },
    {
      "<leader>cA",
      function()
        vim.lsp.buf.code_action({
          context = {
            only = {
              "source",
            },
            diagnostics = {},
          },
        })
      end,
      desc = "Source Action",
      has = "codeAction",
    }
  }

  if require("utils").has("inc-rename.nvim") then
    M._keys[#M._keys + 1] = {
      "<leader>cr",
      function()
        local inc_rename = require("inc_rename")
        return ":" .. inc_rename.config.cmd_name .. " " .. vim.fn.expand("<cword>")
      end,
      expr = true,
      desc = "Rename",
      has = "rename",
    }
  else
    M._keys[#M._keys + 1] = { "<leader>cr", vim.lsp.buf.rename, desc = "Rename", has = "rename" }
  end
  return M._keys
end

---@param method string
function M.has(buffer, method)
  method = method:find("/") and method or "textDocument/" .. method
  local clients = require("utils").lsp.get_clients({ bufnr = buffer })
  for _, client in ipairs(clients) do
    if client.supports_method(method) then
      return true
    end
  end
  return false
end

---@return (LazyKeys|{has?:string})[]
function M.resolve(buffer)
  local Keys = require("lazy.core.handler.keys")
  if not Keys.resolve then
    return {}
  end
  local spec = M.get()

  local opts = require("utils").opts("nvim-lspconfig")
  local clients = require("utils").lsp.get_clients({ bufnr = buffer })
  for _, client in ipairs(clients) do
    local maps = opts.servers[client.name] and opts.servers[client.name].keys or {}

    vim.list_extend(spec, maps)
  end
  return Keys.resolve(spec)
end

function M.on_attach(_, buffer)
  local Keys = require("lazy.core.handler.keys")
  local keymaps = M.resolve(buffer)

  for _, keys in pairs(keymaps) do
    if not keys.has or M.has(buffer, keys.has) then
      local opts = Keys.opts(keys)
      opts.has = nil
      opts.silent = opts.silent ~= false
      opts.buffer = buffer
      vim.keymap.set(keys.mode or "n", keys.lhs, keys.rhs, opts)
    end
  end
end

return M
