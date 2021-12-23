local ok, null_ls = pcall(require, "null-ls")

if not ok then
   return
end

local b = null_ls.builtins

local sources = {

   -- JS html css stuff
   b.formatting.prettierd.with {
      filetypes = { "html", "json", "markdown", "css", "javascript", "javascriptreact" },
   },
   b.diagnostics.eslint.with {
      command = "eslint_d",
   },

   -- Golang
   --b.formatting.golines.with {
   --    filetypes = { "go" },
   --    command = "golines",
   --    args = {}
   --},
   --b.formatting.goimports.with {
   -- filetypes = { "go" },
   -- command = "goimports",
   -- args = {}
   --},
   --b.formatting.gofmt.with {
   -- filetypes = { "go" },
   -- command = "gofmt",
   -- args = {}
   --},

   -- Lua
   b.formatting.stylua,
   --b.diagnostics.luacheck.with { extra_args = { "--global vim" } },

   -- Shell
   b.formatting.shfmt,
   b.diagnostics.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },
   b.formatting.shfmt.with {
    	filetypes = { "sh", "bash" },
   },
   b.formatting.autopep8,
   b.formatting.rustfmt,
   b.diagnostics.yamllint,
   b.code_actions.gitsigns,
   b.code_actions.proselint,
   b.code_actions.refactoring,
   b.formatting.prettier,
}

local M = {}

M.setup = function()
    local function exist(bin)
       return vim.fn.exepath(bin) ~= ""
    end

    table.insert(
      sources,
      null_ls.builtins.formatting.golines.with({
        extra_args = {
          "--max-len=120",
          "--base-formatter=gofumpt",
        },
      })
    )


    -- shell script
    if exist("shellcheck") then
      table.insert(sources, null_ls.builtins.diagnostics.shellcheck)
    end

    -- shell script
    if exist("shfmt") then
      table.insert(sources, null_ls.builtins.formatting.shfmt)
    end

    -- golang
    if exist("golangci-lint") then
      table.insert(sources, null_ls.builtins.diagnostics.golangci_lint)
    end

    if exist("revive") then
      table.insert(sources, null_ls.builtins.diagnostics.revive)
    end

    -- docker
    if exist("hadolint") then
      table.insert(sources, null_ls.builtins.diagnostics.hadolint)
    end

    if exist("eslint_d") then
      table.insert(sources, null_ls.builtins.diagnostics.eslint_d)
    end
    -- js, ts
    if exist("prettierd") then
      table.insert(sources, null_ls.builtins.formatting.prettierd)
    end
    -- lua
    if exist("selene") then
      table.insert(sources, null_ls.builtins.diagnostics.selene)
    end

    if exist("stylua") then
      table.insert(
        sources,
        null_ls.builtins.formatting.stylua.with({
          extra_args = { "--indent-type", "Spaces", "--indent-width", "2" },
        })
      )
    end

    table.insert(sources, null_ls.builtins.formatting.trim_newlines)
    table.insert(sources, null_ls.builtins.formatting.trim_whitespace)

    table.insert(
      sources,
      require("null-ls.helpers").make_builtin({
        method = require("null-ls.methods").internal.DIAGNOSTICS,
        filetypes = { "java" },
        generator_opts = {
          command = "java",
          args = { "$FILENAME" },
          to_stdin = false,
          format = "raw",
          from_stderr = true,
          on_output = require("null-ls.helpers").diagnostics.from_errorformat([[%f:%l: %trror: %m]], "java"),
        },
        factory = require("null-ls.helpers").generator_factory,
      })
    )
   --require("lspconfig")["null-ls"].setup({ on_attach = require("lsp.init").on_attach })
    null_ls.setup({
       sources = sources,
       debounce = 1000,
       root_dir = require("lspconfig").util.root_pattern(
         ".null-ls-root",
         "Makefile",
         ".git",
         "go.mod",
         "package.json",
         "tsconfig.json"
       ),
       on_attach = require("lsp.init").on_attach
    })
end

return M
