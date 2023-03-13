-- plugin: null-ls.nvim
-- see: https://github.com/jose-elias-alvarez/null-ls.nvim
-- rafi settings

-- install:
-- brew install stylua shellcheck vint markdownlint-cli
-- brew install shfmt shellharden hadolint proselint

local builtins = require("null-ls").builtins
--local on_attach = require('lsp.lspconfig').on_attach

-- neovim 0.8 format on save
local lsp_formatting = function(bufnr)
  vim.lsp.buf.format({
    filter = function(client)
      -- apply whatever logic you want (in this example, we'll only use null-ls)
      return client.name == "null-ls"
    end,
    bufnr = bufnr,
  })
end

-- if you want to set up formatting on save, you can use this as a callback
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- add to your shared on_attach callback
local on_attach = function(client, bufnr)
  Lsp_keymaps(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  --if client.server_capabilities.signatureHelpProvider then
  --  require("lsp.signature").setup(client)
  --end

  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        lsp_formatting(bufnr)
      end,
    })
  end
end

local function has_exec(filename)
  return function(_)
    return vim.fn.executable(filename) == 1
  end
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
require("null-ls").setup({
  -- Ensure key maps are setup
  on_attach = on_attach,
  debug = false,
  debounce = 1000,
  default_timeout = 3000,
  fallback_severity = vim.diagnostic.severity.WARN,
  root_dir = require("lspconfig").util.root_pattern(
    ".null-ls-root",
    "Makefile",
    ".git",
    "go.mod",
    "package.json",
    "tsconfig.json",
    ".neoconf.json"
  ),

  sources = {
    ---- Go
    --builtins.formatting.gofmt.with({
    --	runtime_condition = has_exec("gofmt"),
    --}),
    --builtins.formatting.gofumpt.with({
    --	runtime_condition = has_exec("gofumpt"),
    --}),
    --builtins.formatting.golines.with({
    --	runtime_condition = has_exec("golines"),
    --}),

    -- Lua
    --builtins.formatting.stylua,

    -- SQL
    builtins.formatting.sqlformat,

    -- Shell
    -- builtins.code_actions.shellcheck,
    builtins.diagnostics.shellcheck.with({
      runtime_condition = has_exec("shellcheck"),
      extra_filetypes = { "bash" },
    }),
    builtins.formatting.shfmt.with({
      runtime_condition = has_exec("shfmt"),
      extra_filetypes = { "bash" },
    }),
    builtins.formatting.shellharden.with({
      runtime_condition = has_exec("shellharden"),
      extra_filetypes = { "bash" },
    }),

    -- Docker
    builtins.diagnostics.hadolint.with({
      runtime_condition = has_exec("hadolint"),
    }),

    -- Vim
    --builtins.diagnostics.vint.with({
    --    runtime_condition = has_exec('vint'),
    --}),

    ---- Markdown
    builtins.diagnostics.markdownlint.with({
      runtime_condition = has_exec("markdownlint"),
      extra_filetypes = { "vimwiki" },
    }),
    builtins.diagnostics.proselint.with({
      runtime_condition = has_exec("proselint"),
      extra_filetypes = { "vimwiki" },
    }),
    builtins.code_actions.proselint.with({
      runtime_condition = has_exec("proselint"),
      extra_filetypes = { "vimwiki" },
    }),
    builtins.diagnostics.write_good.with({
      runtime_condition = has_exec("write-good"),
      extra_filetypes = { "vimwiki" },
    }),
    builtins.hover.dictionary.with({ extra_filetypes = { "vimwiki" } }),
    builtins.completion.spell.with({ extra_filetypes = { "vimwiki" } }),

    --builtins.formatting.stylua.with({ extra_args = { "--indent-type", "Spaces", "--indent-width", "2" } }),
    --builtins.diagnostics.eslint_d,
    --builtins.formatting.prettier.with({
    --  extra_args = { "--single-quote", "false" },
    --}),
    --builtins.formatting.terraform_fmt,
    --builtins.formatting.black,
    --builtins.formatting.goimports,
    --builtins.formatting.gofumpt,
    --builtins.formatting.latexindent.with({
    --  extra_args = { "-g", "/dev/null" }, -- https://github.com/cmhughes/latexindent.pl/releases/tag/V3.9.3
    --}),

    --builtins.code_actions.shellcheck,
    ----builtins.diagnostics.vale,
    --builtins.code_actions.gitsigns,
  },
})
