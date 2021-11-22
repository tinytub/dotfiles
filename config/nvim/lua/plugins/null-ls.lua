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
   b.formatting.golines.with {
       filetypes = { "go" },
       command = "golines",
       args = {}
   },
   b.formatting.goimports.with {
    filetypes = { "go" },
    command = "goimports",
    args = {}
   },
   b.formatting.gofmt.with {
    filetypes = { "go" },
    command = "gofmt",
    args = {}
   },

   -- Lua
   b.formatting.stylua,
   b.diagnostics.luacheck.with { extra_args = { "--global vim" } },

   -- Shell
   b.formatting.shfmt,
   b.diagnostics.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },
}

local M = {}

M.setup = function(on_attach)
   null_ls.config {
      sources = sources,
   }
   require("lspconfig")["null-ls"].setup { on_attach = on_attach }
end

return M
