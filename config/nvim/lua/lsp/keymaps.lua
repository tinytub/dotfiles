local M = {}
function M.Lsp_keymaps(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  -- Mappings.
  local opts = { noremap = true, silent = true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  buf_set_keymap("n", "gk", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
  buf_set_keymap("n", "<space>lt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  --buf_set_keymap('n', '<leader>lc', '<cmd>lua vim.diagnostic.reset()<CR>',
  --  { desc = "clear diagnostics [LSP]" })
  --buf_set_keymap('n', '<leader>ll', '<cmd>lua vim.diagnostic.open_float(0, { scope = "line", border = "rounded" })<CR>'
  --  , { desc = "show line diagnostic [LSP]" })
  --buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  --buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references({includeDeclaration = false} )<CR>", opts)
  buf_set_keymap("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
  buf_set_keymap(
    "n",
    "ge",
    '<cmd>lua vim.diagnostic.open_float(0, { scope = "line", header = false, focus = false })<CR>',
    opts
  )
  --buf_set_keymap("n", "[e", '<cmd>lua vim.lsp.diagnostic.goto_prev({ popup_opts = { border = "single" }})<CR>', opts)
  --buf_set_keymap("n", "]e", '<cmd>lua vim.lsp.diagnostic.goto_next({ popup_opts = { border = "single" }})<CR>', opts)
  buf_set_keymap("n", "[e", '<cmd>lua vim.diagnostic.goto_prev({ float = { border = "rounded" } })<CR>', opts)
  buf_set_keymap("n", "]e", '<cmd>lua vim.diagnostic.goto_next({ float = { border = "rounded" } })<CR>', opts)
  buf_set_keymap("n", "<space>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
  buf_set_keymap("n", "<space>lf", "<cmd>lua vim.lsp.buf.format()<cr>", opts)
  buf_set_keymap("v", "<space>la", "<cmd>lua vim.lsp.buf.range_code_action()<CR>", opts)
end

---@type PluginLspKeys
M._keys = nil

---@return (LazyKeys|{has?:string})[]
function M.get()
  local format = function()
    require("lsp.format").format({ force = true })
  end
  if not M._keys then
    ---@class PluginLspKeys
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
        "]d",
        M.diagnostic_goto(true),
        desc = "Next Diagnostic"
      },
      {
        "[d",
        M.diagnostic_goto(false),
        desc = "Prev Diagnostic"
      },
      {
        "]e",
        M.diagnostic_goto(true, "ERROR"),
        desc = "Next Error"
      },
      {
        "[e",
        M.diagnostic_goto(false, "ERROR"),
        desc = "Prev Error"
      },
      {
        "]w",
        M.diagnostic_goto(true, "WARN"),
        desc = "Next Warning"
      },
      {
        "[w",
        M.diagnostic_goto(false, "WARN"),
        desc = "Prev Warning"
      },
      {
        "<leader>cf",
        format,
        desc = "Format Document",
        has = "formatting"
      },
      {
        "<leader>cf",
        format,
        desc = "Format Range",
        mode = "v",
        has = "rangeFormatting"
      },
      {
        "<leader>ca",
        vim.lsp.buf.code_action,
        desc = "Code Action",
        mode = { "n", "v" },
        has = "codeAction"
      },
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
  end
  return M._keys
end

---@param method string
function M.has(buffer, method)
  method = method:find("/") and method or "textDocument/" .. method
  local clients = vim.lsp.get_active_clients({ bufnr = buffer })
  for _, client in ipairs(clients) do
    if client.supports_method(method) then
      return true
    end
  end
  return false
end

function M.resolve(buffer)
  local Keys = require("lazy.core.handler.keys")
  local keymaps = {} ---@type table<string,LazyKeys|{has?:string}>

  local function add(keymap)
    local keys = Keys.parse(keymap)
    if keys[2] == false then
      keymaps[keys.id] = nil
    else
      keymaps[keys.id] = keys
    end
  end
  for _, keymap in ipairs(M.get()) do
    add(keymap)
  end

  local opts = require("utils").opts("nvim-lspconfig")
  local clients = vim.lsp.get_active_clients({ bufnr = buffer })
  for _, client in ipairs(clients) do
    local maps = opts.servers[client.name] and opts.servers[client.name].keys or {}
    for _, keymap in ipairs(maps) do
      add(keymap)
    end
  end
  return keymaps
end

function M.on_attach(client, buffer)
  local Keys = require("lazy.core.handler.keys")
  local keymaps = M.resolve(buffer)

  for _, keys in pairs(keymaps) do
    if not keys.has or M.has(buffer, keys.has) then
      local opts = Keys.opts(keys)
      ---@diagnostic disable-next-line: no-unknown
      opts.has = nil
      opts.silent = opts.silent ~= false
      opts.buffer = buffer
      vim.keymap.set(keys.mode or "n", keys[1], keys[2], opts)
    end
  end
end

function M.diagnostic_goto(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end

return M
