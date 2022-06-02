-- plugin: null-ls.nvim
-- see: https://github.com/jose-elias-alvarez/null-ls.nvim
-- rafi settings

-- install:
-- brew install stylua shellcheck vint markdownlint-cli
-- brew install shfmt shellharden hadolint proselint

local builtins = require('null-ls').builtins
local on_attach = require('lsp.lspconfig').on_attach

local function has_exec(filename)
    return function(_)
        return vim.fn.executable(filename) == 1
    end
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
require('null-ls').setup({
    -- Ensure key maps are setup
    on_attach = on_attach,
    --on_attach = function(client)
    --    -- use vim.lsp.buf.format on 0.8
    --    vim.cmd([[
    --        augroup LspFormatting
    --            autocmd! * <buffer>
    --            autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
    --        augroup END
    --        ]])
    --end,


    debug = true,
    -- should_attach = function(bufnr)
    -- 	return not vim.api.nvim_buf_get_name(bufnr):match("^git://")
    -- end,

    sources = {
        -- Whitespace
        --builtins.diagnostics.trail_space.with({
        --    disabled_filetypes = { 'gitcommit' },
        --}),

        -- Ansible
        builtins.diagnostics.ansiblelint.with({
            runtime_condition = has_exec('ansible-lint'),
            extra_filetypes = { 'yaml', 'yaml.ansible' },
        }),

        ---- Javascript
        --builtins.diagnostics.eslint,

        ---- Go
        --builtins.formatting.gofmt.with({
        --    runtime_condition = has_exec('gofmt'),
        --}),
        --builtins.formatting.gofumpt.with({
        --    runtime_condition = has_exec('gofumpt'),
        --}),
        --builtins.formatting.golines.with({
        --    runtime_condition = has_exec('golines'),
        --}),

        -- Lua
        --builtins.formatting.stylua,

        -- SQL
        builtins.formatting.sqlformat,

        -- Shell
        -- builtins.code_actions.shellcheck,
        builtins.diagnostics.shellcheck.with({
            runtime_condition = has_exec('shellcheck'),
            extra_filetypes = { 'bash' },
        }),
        builtins.formatting.shfmt.with({
            runtime_condition = has_exec('shfmt'),
            extra_filetypes = { 'bash' },
        }),
        builtins.formatting.shellharden.with({
            runtime_condition = has_exec('shellharden'),
            extra_filetypes = { 'bash' },
        }),

        -- Docker
        builtins.diagnostics.hadolint.with({
            runtime_condition = has_exec('hadolint'),
        }),

        -- Vim
        --builtins.diagnostics.vint.with({
        --    runtime_condition = has_exec('vint'),
        --}),

        ---- Markdown
        --builtins.diagnostics.markdownlint.with({
        --    runtime_condition = has_exec('markdownlint'),
        --    extra_filetypes = { 'vimwiki' },
        --}),
        --builtins.diagnostics.proselint.with({
        --    runtime_condition = has_exec('proselint'),
        --    extra_filetypes = { 'vimwiki' },
        --}),
        -- builtins.code_actions.proselint.with({
        -- 	runtime_condition = has_exec('proselint'),
        -- 	extra_filetypes = { 'vimwiki' },
        -- }),
        -- builtins.diagnostics.write_good.with({
        -- 	runtime_condition = has_exec('write-good'),
        -- 	extra_filetypes = { 'vimwiki' },
        -- }),
        -- builtins.hover.dictionary.with({ extra_filetypes = { 'vimwiki' } }),
        -- builtins.completion.spell.with({ extra_filetypes = { 'vimwiki' } }),
    },
})

--local ok, null_ls = pcall(require, "null-ls")
--if not ok then
--    return
--end
--
----https://github.com/ray-x/nvim/blob/master/lua/modules/lang/null-ls/init.lua
--local sources = {
--    null_ls.builtins.formatting.autopep8,
--    null_ls.builtins.formatting.rustfmt,
--    null_ls.builtins.diagnostics.yamllint,
--    --null_ls.builtins.code_actions.gitsigns,
--    --null_ls.builtins.code_actions.refactoring,
--    --null_ls.builtins.formatting.prettier.with {
--    --    extra_filetypes = { "toml", "solidity" },
--    --    extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
--    --},
--    --null_ls.builtins.formatting.black.with { extra_args = { "--fast" } },
--    --null_ls.builtins.formatting.stylua,
--    --null_ls.builtins.code_actions.gitsigns,
--}
--
--local M = {}
--
--M.setup = function()
--    local function exist(bin)
--        return vim.fn.exepath(bin) ~= ""
--    end
--
--    -- shell script
--    if exist("shellcheck") then
--        table.insert(sources, null_ls.builtins.diagnostics.shellcheck)
--    end
--
--    -- shell script
--    if exist("shfmt") then
--        table.insert(sources, null_ls.builtins.formatting.shfmt)
--    end
--
--
--    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
--    local cfg = {
--        sources = sources,
--        debounce = 1000,
--        default_timeout = 3000,
--        fallback_severity = vim.diagnostic.severity.WARN,
--        root_dir = require("lspconfig").util.root_pattern(
--            ".null-ls-root",
--            "Makefile",
--            ".git",
--            "go.mod",
--            "package.json",
--            "tsconfig.json"
--        ),
--        debug = false,
--        --on_attach = require("lsp.init").on_attach
--        --on_attach = function(client)
--        --  if client.resolved_capabilities.document_formatting then
--        --    vim.cmd("autocmd BufWritePre <buffer> :silent lua vim.lsp.buf.formatting_sync()")
--        --  end
--        --end,
--        on_attach = function(client, bufnr)
--            if client.supports_method("textDocument/formatting") then
--                vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
--                vim.api.nvim_create_autocmd("BufWritePre", {
--                    group = augroup,
--                    buffer = bufnr,
--                    callback = function()
--                        -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
--                        vim.lsp.buf.formatting_sync()
--                    end,
--                })
--            end
--        end,
--    }
--    null_ls.setup(cfg)
--end
--
--return M
