local lspconfig = require 'lspconfig'

-- Borders for LspInfo winodw
local win = require("lspconfig.ui.windows")
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
function Lsp_keymaps(client, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

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
  buf_set_keymap("n", "ge", '<cmd>lua vim.diagnostic.open_float(0, { scope = "line", header = false, focus = false })<CR>', opts)
  --buf_set_keymap("n", "[e", '<cmd>lua vim.lsp.diagnostic.goto_prev({ popup_opts = { border = "single" }})<CR>', opts)
  --buf_set_keymap("n", "]e", '<cmd>lua vim.lsp.diagnostic.goto_next({ popup_opts = { border = "single" }})<CR>', opts)
  buf_set_keymap("n", "[e", '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap("n", "]e", '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap("n", "<space>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
  buf_set_keymap("n", "<space>lf", "<cmd>lua vim.lsp.buf.format()<cr>", opts)
  buf_set_keymap("v", "<space>la", "<cmd>lua vim.lsp.buf.range_code_action()<CR>", opts)

  client.server_capabilities.documentFormattingProvider = true
  client.server_capabilities.documentRangeFormattingProvider = true
  -- neovim 0.8?
  --if client.server_capabilities.documentFormattingProvider then
  --  --vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { unpack(opts), desc = "LSP format" })
  --  vim.api.nvim_buf_create_user_command(
  --    bufnr,
  --    "LspFormat",
  --    vim.lsp.buf.format,
  --    { range = false, desc = "LSP format" }
  --  )
  --end

  --if client.server_capabilities.documentRangeFormattingProvider then
  --  vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr(#{timeout_ms:250})")
  --  --vim.keymap.set("x", "<leader>lf", vim.lsp.buf.range_formatting, { unpack(opts), desc = "LSP range format" })
  --  vim.api.nvim_buf_create_user_command(
  --    bufnr,
  --    "LspRangeFormat",
  --    --vim.lsp.buf.range_formatting,
  --    vim.lsp.buf.format,
  --    { range = true, desc = "LSP range format" }
  --  )
  --end

end

local function make_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  if pcall(require, 'cmp_nvim_lsp') then
    --capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
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

--lsp_config.capabilities = capabilities
local lsp_handlers = function()
  local opts = {
    diagnostics = {
      virtual_text = {
        spacing = 4,
        source = "if_many",
        prefix = "●",
        -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
        -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
        -- prefix = "icons",
      },
      signs = true,
      severity_sort = true,
      underline = true,
      update_in_insert = false, -- update diagnostics insert mode
      float = {
        --  focused = false,
        --  style = "minimal",
        border = "rounded",
        --  source = "always",
        --  header = "",
        --  prefix = "",
      },
    },
  }

  -- setup autoformat, default is true
  --require("lazyvim.plugins.lsp.format").autoformat = opts.autoformat

  -- setup formatting and keymaps
  require("utils").on_attach(function(client, buffer)
    require("lsp.format").on_attach(client, buffer)
    Lsp_keymaps(client, buffer)

    vim.api.nvim_buf_set_option(buffer, "omnifunc", "v:lua.vim.lsp.omnifunc")
    require("lsp_signature").on_attach(require("plugins.configs.others").signature_opt())

    local navic = require("nvim-navic")
    navic.attach(client, buffer)
    vim.g.navic_silence = true

  end)

  for name, icon in pairs(require("plugins.configs.lspkind_icons").diagnostics) do
    name = "DiagnosticSign" .. name
    vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
  end

  if opts.diagnostics.virtual_text.prefix == "icons" then
    opts.diagnostics.virtual_text.prefix = vim.fn.has("nvim-0.10.0") == 0 and "●"
        or function(diagnostic)
          local icons = require("plugins.configs.lspkind_icons").icons.diagnostics
          for d, icon in pairs(icons) do
            if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
              return icon
            end
          end
        end
  end

  vim.diagnostic.config(opts.diagnostics)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "single",
  })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "single",
  })

end


local lspbufformat = vim.api.nvim_create_augroup("lsp_buf_format", { clear = true })
local format_acmd = function()
  --vim.notify("create format acmd")
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = lspbufformat,
    callback = function()
      --vim.lsp.buf.format({ async = true })
      vim.lsp.buf.format()
    end,
  })
end

-- Manage server with custom setup
local util = require("lspconfig.util")
local servers = {
  lua_ls = require("lsp.servers.sumneko_lua"),
  pyright = require("lsp.servers.pyright"),
  jsonls = require("lsp.servers.jsonls"),
  --emmet_ls = require("user.lsp.settings.emmet_ls"),
  vimls = require("lsp.servers.vimls"),
  gopls = require("lsp.servers.gopls"),
  --yamlls = {},

  tsserver = require("lsp.servers.tsserver"),
  tailwindcss = {
    tailwindCSS = {
      lint = {
        cssConflict = "warning",
        invalidApply = "error",
        invalidConfigPath = "error",
        invalidScreen = "error",
        invalidTailwindDirective = "error",
        invalidVariant = "error",
        recommendedVariantOrder = "warning"
      },
      experimental = {
        classRegex = {
          "tw`([^`]*)",
          "tw=\"([^\"]*)",
          "tw={\"([^\"}]*)",
          "tw\\.\\w+`([^`]*)",
          "tw\\(.*?\\)`([^`]*)",
          { "clsx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
          { "classnames\\(([^)]*)\\)", "'([^']*)'" }
        }
      },
      validate = true
    }
  },
  cssls = {
    css = {
      lint = {
        unknownAtRules = 'ignore',
      },
    },
    scss = {
      lint = {
        unknownAtRules = 'ignore',
      },
    },
  },
  html = {},
  bashls = {},
  --  cmd = { "bash-language-server", "start" },
  --  cmd_env = {
  --    GLOB_PATTERN = "*@(.sh|.inc|.bash|.command)",
  --  },
  --  filetypes = { "sh", "zsh" },
  --  root_dir = util.find_git_ancestor,
  --  single_file_support = true,
  --},
  grammarly = {
    filetypes = { "markdown" },
    single_file_support = true,
    autostart = false,
    root_dir = util.find_git_ancestor,
  },
}

-- LSP: Servers Configuration
local setup_server = function(server, config)
  if not config then
    vim.notify(
      " No configuration passed to server < " .. server .. " >",
      "Warn",
      { title = "LSP: Servers Configuration" }
    )
    return
  end

  if type(config) ~= "table" then
    config = {}
  end

  config = vim.tbl_deep_extend("force", {
    --on_init = custom_init,
    --on_attach = custom_attach,
    --capabilities = updated_capabilities,
    capabilities = make_capabilities(),
    flags = {
      debounce_text_changes = nil,
    },
  }, config)
  lspconfig[server].setup(config)
end

lsp_handlers()

for server, config in pairs(servers) do
  setup_server(server, config)
end
