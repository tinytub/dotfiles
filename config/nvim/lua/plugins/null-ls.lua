local ok, null_ls = pcall(require, "null-ls")
if not ok then
   return
end

local b = null_ls.builtins

--https://github.com/ray-x/nvim/blob/master/lua/modules/lang/null-ls/init.lua

local sources = {
   b.formatting.isort.with({
       extra_args = { "--profile", "black" },
   }),

   b.formatting.black,
   b.diagnostics.chktex,

--   b.diagnostics.misspell.with({
--     filetypes = { "markdown", "text", "txt" },
--     args = { "$FILENAME" },
--   }),
--   b.diagnostics.write_good.with({
--     filetypes = { "markdown", "tex", "" },
--     extra_filetypes = { "txt", "text" },
--     args = { "--text=$TEXT", "--parse" },
--     command = "write-good",
--   }),

   b.diagnostics.vint,

   -- JS html css stuff
   b.formatting.prettierd.with {
      filetypes = { "html", "markdown", "json", "css", "javascript", "javascriptreact" },
   },
   b.diagnostics.eslint.with {
      command = "eslint_d",
   },

   b.code_actions.proselint.with({ filetypes = { "markdown", "tex" }, command = "proselint", args = { "--json" } }),

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

   -- Shell
   b.formatting.shfmt,
   b.diagnostics.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },
   b.formatting.shfmt.with {
    	filetypes = { "sh", "bash" },
   },

   b.formatting.autopep8,
   b.formatting.rustfmt,
   --b.diagnostics.yamllint,
   --b.code_actions.gitsigns,
   --b.code_actions.proselint,
   --b.code_actions.refactoring,
   b.formatting.prettier,
}

local M = {}

M.setup = function()
    local function exist(bin)
       return vim.fn.exepath(bin) ~= ""
    end

    -- shell script
    if exist("shellcheck") then
      table.insert(sources, null_ls.builtins.diagnostics.shellcheck)
    end

    -- shell script
    if exist("shfmt") then
      table.insert(sources, null_ls.builtins.formatting.shfmt)
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

    null_ls.setup({
       sources = sources,
       debounce = 1000,
       default_timeout = 3000,
       root_dir = require("lspconfig").util.root_pattern(
         ".null-ls-root",
         "Makefile",
         ".git",
         "go.mod",
         "package.json",
         "tsconfig.json"
       ),
       debug = false,
       on_attach = require("lsp.init").on_attach
    })
end

return M
