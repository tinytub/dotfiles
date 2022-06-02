local present, lspconfig = pcall(require, "lspconfig")

if not present then
    return
end

-- Lsp highlights managed by
--   `illuminate` plugin
local function lsp_highlight_document(client)
    --if client.resolved_capabilities.document_highlight then
    --    local illuminate_ok, illuminate = pcall(require, "illuminate")
    --    if not illuminate_ok then
    --        return
    --    end
    --    illuminate.on_attach(client)
    --end
    if client.server_capabilities.document_highlight then
        local illuminate_ok, illuminate = pcall(require, "illuminate")
        if not illuminate_ok then
            return
        end
        illuminate.on_attach(client)
    end


end

-- Borders for LspInfo winodw
local win = require "lspconfig.ui.windows"
local _default_opts = win.default_opts

win.default_opts = function(options)
    local opts = _default_opts(options)
    opts.border = "single"
    return opts
end

-- Create custom keymaps for useful
--   lsp functions
-- The missing functions are most covered whith which-key mappings
-- the `hover()` -> covers even signature_help on functions/methods
local function lsp_keymaps(client, bufnr)
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
    buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    --buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    buf_set_keymap("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
    buf_set_keymap("n", "ge", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
    --buf_set_keymap("n", "[e", '<cmd>lua vim.lsp.diagnostic.goto_prev({ popup_opts = { border = "single" }})<CR>', opts)
    --buf_set_keymap("n", "]e", '<cmd>lua vim.lsp.diagnostic.goto_next({ popup_opts = { border = "single" }})<CR>', opts)
    buf_set_keymap("n", "[e", '<cmd>lua vim.diagnostic.goto_prev({float = {border = "single"}})<CR>', opts)
    buf_set_keymap("n", "]e", '<cmd>lua vim.diagnostic.goto_next({float = {border = "single"}})<CR>', opts)
    buf_set_keymap("n", "<space>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
    buf_set_keymap("n", "<space>lf", "<cmd>lua vim.lsp.buf.formatting()<cr>", opts)
    buf_set_keymap("v", "<space>la", "<cmd>lua vim.lsp.buf.range_code_action()<CR>", opts)
    --if client.resolved_capabilities.document_formatting then
    --    --vim.keymap.set("n", "<leader>lf", vim.lsp.buf.formatting_seq_sync, opts)
    --    vim.api.nvim_buf_create_user_command(bufnr, "LspFormat", vim.lsp.buf.formatting_seq_sync, {})
    --end

    --if client.resolved_capabilities.document_range_formatting then
    --    --vim.keymap.set("x", "<leader>lf", vim.lsp.buf.range_formatting, opts)
    --    vim.api.nvim_buf_create_user_command(bufnr, "LspRangeFormat", vim.lsp.buf.formatting_seq_sync, { range = true })
    --end

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
            vim.lsp.buf.range_formatting,
            { range = true, desc = "LSP range format" }
        )
    end
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
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
capabilities.textDocument.codeAction.dynamicRegistration = true
-- Code actions
capabilities.textDocument.codeAction = {
    dynamicRegistration = true,
    codeActionLiteralSupport = {
        codeActionKind = {
            valueSet = (function()
                local res = vim.tbl_values(vim.lsp.protocol.CodeActionKind)
                table.sort(res)
                return res
            end)()
        }
    }
}
capabilities.textDocument.completion.completionItem.snippetSupport = true;

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
    vim.diagnostic.config {
        virtual_text = false,
        signs = true,
        underline = true,
        update_in_insert = false, -- update diagnostics insert mode
    }
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "single",
    })
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "single",
    })

    -- suppress error messages from lang servers
    vim.notify = function(msg, log_level)
        if msg:match "exit code" then
            return
        end
        if log_level == vim.log.levels.ERROR then
            vim.api.nvim_err_writeln(msg)
        else
            vim.api.nvim_echo({ { msg } }, true, {})
        end
    end
    -- credits to @Malace : https://www.reddit.com/r/neovim/comments/ql4iuj/rename_hover_including_window_title_and/
    -- This is modified version of the above snippet
    vim.lsp.buf.rename = {
        float = function()
            local currName = vim.fn.expand "<cword>"

            local win = require("plenary.popup").create("  ", {
                title = currName,
                style = "minimal",
                borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
                relative = "cursor",
                borderhighlight = "RenamerBorder",
                titlehighlight = "RenamerTitle",
                focusable = true,
                width = 25,
                height = 1,
                line = "cursor+2",
                col = "cursor-1",
            })

            local map_opts = { noremap = true, silent = true }

            vim.cmd "startinsert"

            vim.api.nvim_buf_set_keymap(0, "i", "<Esc>", "<cmd>stopinsert | q!<CR>", map_opts)
            vim.api.nvim_buf_set_keymap(0, "n", "<Esc>", "<cmd>stopinsert | q!<CR>", map_opts)

            vim.api.nvim_buf_set_keymap(
                0,
                "i",
                "<CR>",
                "<cmd>stopinsert | lua vim.lsp.buf.rename.apply(" .. currName .. "," .. win .. ")<CR>",
                map_opts
            )

            vim.api.nvim_buf_set_keymap(
                0,
                "n",
                "<CR>",
                "<cmd>stopinsert | lua vim.lsp.buf.rename.apply(" .. currName .. "," .. win .. ")<CR>",
                map_opts
            )
        end,

        apply = function(curr, win)
            local newName = vim.trim(vim.fn.getline ".")
            vim.api.nvim_win_close(win, true)

            if #newName > 0 and newName ~= curr then
                local params = vim.lsp.util.make_position_params()
                params.newName = newName

                vim.lsp.buf_request(0, "textDocument/rename", params)
            end
        end,
    }
end


-- Default lsp config for filetypes
local filetype_attach = setmetatable({
    go = function()
        local lspbufformat = vim.api.nvim_create_augroup("lsp_buf_format", { clear = true })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = lspbufformat,
            callback = function()
                --vim.lsp.buf.formatting_sync()
                vim.lsp.buf.format()
            end,
        })
    end,
    lua = function()
        local lspbufformat = vim.api.nvim_create_augroup("lsp_buf_format", { clear = true })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = lspbufformat,
            callback = function()
                --vim.lsp.buf.formatting_sync()
                vim.lsp.buf.format()
            end,
        })
    end,

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
    local filetype = vim.api.nvim_buf_get_option(0, "filetype")
    filetype_attach[filetype](client)
    lsp_keymaps(client, bufnr)
    --lsp_highlight_document(client)
end

-- Manage server with custom setup
local util = require "lspconfig.util"
local servers = {
    sumneko_lua = require("lsp.servers.sumneko_lua"),
    pyright = require("lsp.servers.pyright"),
    jsonls = require("lsp.servers.jsonls"),
    --emmet_ls = require("user.lsp.settings.emmet_ls"),
    vimls = require("lsp.servers.vimls"),
    gopls = require("lsp.servers.gopls"),
    yamlls = {},
    bashls = {
        cmd = { "bash-language-server", "start" },
        cmd_env = {
            GLOB_PATTERN = "*@(.sh|.inc|.bash|.command)",
        },
        filetypes = { "sh", "zsh" },
        root_dir = util.find_git_ancestor,
        single_file_support = true,
    },
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
        capabilities = capabilities,
        flags = {
            debounce_text_changes = nil,
        },
    }, config)

    lspconfig[server].setup(config)
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

lsp_handlers()

--return lsp_config
return {
    on_init = custom_init,
    on_attach = custom_attach,
    capabilities = capabilities,
}
