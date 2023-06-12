local M = {}
M.opts = nil

-- Borders for LspInfo winodw
local win = require "lspconfig.ui.windows"
local _default_opts = win.default_opts

win.default_opts = function(options)
  local opts = _default_opts(options)
  opts.border = "single"
  return opts
end

-- some from https://github.com/ibhagwan/nvim-lua

-- Create custom keymaps for useful
-- lsp functions
-- The missing functions are most covered whith which-key mappings
-- the `hover()` -> covers even signature_help on functions/methods
-- null-ls also call this
local function make_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  if pcall(require, "cmp_nvim_lsp") then
    --capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
  end
  capabilities.textDocument.completion.completionItem = {
    documentationFormat = { "markdown", "plaintext" },
    snippetSupport = true,
    preselectSupport = true,
    insertReplaceSupport = true,
    labelDetailsSupport = true,
    deprecatedSupport = true,
    commitCharactersSupport = true,
    tagSupport = { valueSet = { 1 } },
    resolveSupport = {
      properties = {
        "documentation",
        "detail",
        "additionalTextEdits",
      },
    },
    workDoneProgress = true,
  }
  -- Code actions
  capabilities.textDocument.codeAction = {
    dynamicRegistration = true,
    codeActionLiteralSupport = {
      codeActionKind = {
        valueSet = (function()
          local res = vim.tbl_values(vim.lsp.protocol.CodeActionKind)
          table.sort(res)
          return res
        end)(),
      },
    },
  }
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  return capabilities
end

-- Manage server with custom setup
local util = require "lspconfig.util"
local servers = {
  lua_ls = require "lsp.servers.sumneko_lua",
  pyright = require "lsp.servers.pyright",
  --emmet_ls = require("user.lsp.settings.emmet_ls"),
  vimls = require "lsp.servers.vimls",
  cssls = {
    css = {
      lint = {
        unknownAtRules = "ignore",
      },
    },
    scss = {
      lint = {
        unknownAtRules = "ignore",
      },
    },
  },
  html = {},
  bashls = {},
  grammarly = {
    filetypes = { "markdown" },
    single_file_support = true,
    autostart = false,
    root_dir = util.find_git_ancestor,
  },
}

-- LSP: Servers Configuration
local function setup(server)
  local cap = make_capabilities()
  local server_opts = vim.tbl_deep_extend("force", {
    --capabilities = vim.deepcopy(capabilities),
    capabilities = vim.deepcopy(cap),
  }, servers[server] or {})

  if M.opts.setup[server] then
    if M.opts.setup[server](server, server_opts) then return end
  elseif M.opts.setup["*"] then
    if M.opts.setup["*"](server, server_opts) then return end
  end
  require("lspconfig")[server].setup(server_opts)
end

--lsp_config.capabilities = capabilities
local lsp_handlers = function()
  -- setup autoformat, default is true
  local opts = M.opts

  require("lsp.format").setup(opts)
  -- setup formatting and keymaps
  require("utils").on_attach(function(client, buffer)
    --require("lsp.format").on_attach(client, buffer)
    require("lsp.keymaps").Lsp_keymaps(client, buffer)
    --Lsp_keymaps(client, buffer)

    vim.api.nvim_buf_set_option(buffer, "omnifunc", "v:lua.vim.lsp.omnifunc")
    require("lsp_signature").on_attach(require("plugins.configs.others").signature_opt())

    local navic = require "nvim-navic"
    navic.attach(client, buffer)
    vim.g.navic_silence = true
  end)

  for name, icon in pairs(require("plugins.configs.lspkind_icons").diagnostics) do
    name = "DiagnosticSign" .. name
    vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
  end

  if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
    opts.diagnostics.virtual_text.prefix = vim.fn.has "nvim-0.10.0" == 0 and "●"
      or function(diagnostic)
        local icons = require("plugins.configs.lspkind_icons").icons.diagnostics
        for d, icon in pairs(icons) do
          if diagnostic.severity == vim.diagnostic.severity[d:upper()] then return icon end
        end
      end
  end

  vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "single",
  })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "single",
  })

  -- get all the servers that are available thourgh mason-lspconfig
  local have_mason, mlsp = pcall(require, "mason-lspconfig")
  local all_mslp_servers = {}
  if have_mason then
    all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
  end

  local ensure_installed = {} ---@type string[]

  -- merge opts servers and local servers define
  servers = vim.tbl_deep_extend("force", opts.servers, servers or {})

  for server, server_opts in pairs(servers) do
    if server_opts then
      server_opts = server_opts == true and {} or server_opts
      -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
      if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
        setup(server)
      else
        ensure_installed[#ensure_installed + 1] = server
      end
    end
  end

  if have_mason then mlsp.setup { ensure_installed = ensure_installed, handlers = { setup } } end

  if require("utils").lsp_get_config "denols" and require("utils").lsp_get_config "tsserver" then
    local is_deno = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc")
    require("utils").lsp_disable("tsserver", is_deno)
    require("utils").lsp_disable("denols", function(root_dir) return not is_deno(root_dir) end)
  end
end

function M.config(opts)
  M.opts = opts
  lsp_handlers()
end

return M
