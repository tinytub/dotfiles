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
  if client.server_capabilities.documentFormattingProvider then
    --vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { unpack(opts), desc = "LSP format" })
    vim.api.nvim_buf_create_user_command(
      bufnr,
      "LspFormat",
      vim.lsp.buf.format,
      { range = false, desc = "LSP format" }
    )
  end

  if client.server_capabilities.documentRangeFormattingProvider then
    vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr(#{timeout_ms:250})")
    --vim.keymap.set("x", "<leader>lf", vim.lsp.buf.range_formatting, { unpack(opts), desc = "LSP range format" })
    vim.api.nvim_buf_create_user_command(
      bufnr,
      "LspRangeFormat",
      --vim.lsp.buf.range_formatting,
      vim.lsp.buf.format,
      { range = true, desc = "LSP range format" }
    )
  end

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

local function make_ts_capabilities()
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.preselectSupport = true
  capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
  capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
  capabilities.textDocument.completion.completionItem.deprecatedSupport = true
  capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
  capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      'documentation',
      'detail',
      'additionalTextEdits',
    }
  }
  capabilities.textDocument.codeAction = {
    dynamicRegistration = false,
    codeActionLiteralSupport = {
      codeActionKind = {
        valueSet = {
          "",
          "quickfix",
          "refactor",
          "refactor.extract",
          "refactor.inline",
          "refactor.rewrite",
          "source",
          "source.organizeImports",
        },
      },
    },
  }
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
  }

end

--lsp_config.capabilities = capabilities

local lsp_handlers = function()
  local function lspSymbol(name, icon)
    --vim.fn.sign_define("LspDiagnosticsSign" .. name, {text = icon })
    local hl = "DiagnosticSign" .. name
    vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
  end

  lspSymbol("Error", "")
  lspSymbol("Info", "")
  lspSymbol("Hint", "")
  lspSymbol("Warn", "")

  --lspSymbol("Error", "")
  --lspSymbol("Info", "")
  --lspSymbol("Hint", "")
  --lspSymbol("Warn", "")

  --vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  --virtual_text = {
  --   prefix = "",
  --   spacing = 0,
  --},
  vim.diagnostic.config({
    --virtual_text = {
    --    prefix = "",
    --},
    --virtual_text = { spacing = 4, prefix = '●' },
    virtual_text = false,
    --virtual_text = {
    --  spacing = 4,
    --  prefix = '●',
    --  source = 'always',
    --  severity = {
    --    min = vim.diagnostic.severity.HINT,
    --  },
    --},
    signs = true,
    severity_sort = true,
    --underline = true,
    update_in_insert = false, -- update diagnostics insert mode
    --float = {
    --  show_header = false,
    --  source = 'always',
    --  border = 'rounded',
    --},
    float = {
      focused = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  })
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "single",
  })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "single",
  })

  --vim.lsp.handlers['textDocument/references'] = function(_, _, _)
  --  require('telescope.builtin').lsp_references()
  --end

  -- suppress error messages from lang servers
  --vim.notify = function(msg, log_level)
  --  if msg:match("exit code") then
  --    return
  --  end
  --  if log_level == vim.log.levels.ERROR then
  --    vim.api.nvim_err_writeln(msg)
  --  else
  --    vim.api.nvim_echo({ { msg } }, true, {})
  --  end
  --end
end

lsp_handlers()

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

local format_acmd_go = function()
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = lspbufformat,
    callback = function()
      --vim.lsp.buf.formatting_sync()
      vim.lsp.buf.format({ async = true })

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



-- Default lsp config for filetypes
local filetype_attach = setmetatable({
  -- v0.7
  --go = require('lsp.format').OrgImports(1000),
  -- v0.8
  go = format_acmd_go,
  lua = format_acmd,
  javascript = format_acmd,
  --yaml = format_acmd,
  json = format_acmd,
  py = format_acmd,
}, {
  __index = function()
    return function() end
  end,
})

local custom_init = function(client)
  client.config.flags = client.config.flags or {}
  client.config.flags.allow_incremental_sync = true
end

local custom_attach = function(client, bufnr)
  if client.config
      and client.config.capabilities
      and client.config.capabilities.documentFormattingProvider == false
  then
    -- dont format if client disabled it
  else
    local filetype = vim.api.nvim_buf_get_option(0, "filetype")
    --filetype_attach[filetype](client)
    local plg = filetype_attach[filetype]
    if plg == nil then
      format_acmd()
    else
      plg(client)
    end
  end

  Lsp_keymaps(client, bufnr)

  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")


  --if client.server_capabilities.signatureHelpProvider then
  --  require("lsp.signature").setup(client)
  --end
  --lsp_highlight_document(client)

  require("lsp_signature").on_attach(require("plugins.configs.others").signature_opt())

  local navic = require("nvim-navic")
  navic.attach(client, bufnr)
  vim.g.navic_silence = true
  --lsp_highlight_document(client)
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
    on_init = custom_init,
    on_attach = custom_attach,
    --capabilities = updated_capabilities,
    capabilities = make_capabilities(),
    flags = {
      debounce_text_changes = nil,
    },
  }, config)
  if server == "tsserver" then
    --config.settings = require('lsp.servers.tsserver')
    config.capabilities = make_ts_capabilities()
    require("typescript").setup({
      disable_commands = false, -- prevent the plugin from creating Vim commands
      debug = false, -- enable debug logging for commands
      go_to_source_definition = {
        fallback = true, -- fall back to standard LSP definition on failure
      },

      server = config })
  else
    lspconfig[server].setup(config)
  end
end

for server, config in pairs(servers) do
  --    local ok, lsp_installer = pcall(require, "nvim-lsp-installer")
  --	local server_is_found, theserver = lsp_installer.get_server(server)
  --	if server_is_found and not theserver:is_installed() then
  --		print("Installing " .. server)
  --		--server:install()
  --	end
  setup_server(server, config)
end

--return lsp_config
return {
  on_init = custom_init,
  on_attach = custom_attach,
  capabilities = make_capabilities(),
}
