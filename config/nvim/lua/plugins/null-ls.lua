local ok, null_ls = pcall(require, "null-ls")
if not ok then
    return
end

--https://github.com/ray-x/nvim/blob/master/lua/modules/lang/null-ls/init.lua
local sources = {
    null_ls.builtins.formatting.autopep8,
    null_ls.builtins.formatting.rustfmt,
    null_ls.builtins.diagnostics.yamllint,
    --null_ls.builtins.code_actions.gitsigns,
    --null_ls.builtins.code_actions.refactoring,
    --null_ls.builtins.formatting.prettier.with {
    --    extra_filetypes = { "toml", "solidity" },
    --    extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
    --},
    --null_ls.builtins.formatting.black.with { extra_args = { "--fast" } },
    --null_ls.builtins.formatting.stylua,
    --null_ls.builtins.code_actions.gitsigns,
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


    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    local cfg = {
        sources = sources,
        debounce = 1000,
        default_timeout = 3000,
        fallback_severity = vim.diagnostic.severity.WARN,
        root_dir = require("lspconfig").util.root_pattern(
            ".null-ls-root",
            "Makefile",
            ".git",
            "go.mod",
            "package.json",
            "tsconfig.json"
        ),
        debug = false,
        --on_attach = require("lsp.init").on_attach
        --on_attach = function(client)
        --  if client.resolved_capabilities.document_formatting then
        --    vim.cmd("autocmd BufWritePre <buffer> :silent lua vim.lsp.buf.formatting_sync()")
        --  end
        --end,
        on_attach = function(client, bufnr)
            if client.supports_method("textDocument/formatting") then
                vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                vim.api.nvim_create_autocmd("BufWritePre", {
                    group = augroup,
                    buffer = bufnr,
                    callback = function()
                        -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                        vim.lsp.buf.formatting_sync()
                    end,
                })
            end
        end,
    }
    null_ls.setup(cfg)
end

return M
