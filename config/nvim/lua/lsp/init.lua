local present1, nvim_lsp = pcall(require, "lspconfig")

if not present1 then
   return
end

local lsp_config = {}

local function document_highlight(client, bufnr)
    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec(
            [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
            false
        )
    end
end



function lsp_config.on_attach(client, bufnr)
   local function buf_set_keymap(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
   end

   local function buf_set_option(...)
      vim.api.nvim_buf_set_option(bufnr, ...)
   end

   -- Enable completion triggered by <c-x><c-o>
   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

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
   buf_set_keymap("n", "ge", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
   --buf_set_keymap("n", "[e", '<cmd>lua vim.lsp.diagnostic.goto_prev({ popup_opts = { border = "single" }})<CR>', opts)
   --buf_set_keymap("n", "]e", '<cmd>lua vim.lsp.diagnostic.goto_next({ popup_opts = { border = "single" }})<CR>', opts)
   buf_set_keymap("n", "[e", '<cmd>lua vim.lsp.diagnostic.goto_prev({float = {border = "single"}})<CR>', opts)
   buf_set_keymap("n", "]e", '<cmd>lua vim.lsp.diagnostic.goto_next({float = {border = "single"}})<CR>', opts)
   buf_set_keymap("n", "<space>lq", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
   buf_set_keymap("n", "<space>lf", "<cmd>lua vim.lsp.buf.formatting()<cr>", opts)
   buf_set_keymap("v", "<space>la", "<cmd>lua vim.lsp.buf.range_code_action()<CR>", opts)
   document_highlight(client, bufnr)
end

--vim.api.nvim_set_keymap('n', 'gd', ':lua vim.lsp.buf.definition()<CR>', {noremap = true, silent = true})
----vim.api.nvim_set_keymap('n', 'ga', ':Lspsaga code_action<CR>', {noremap = true, silent = true})
----vim.api.nvim_set_keymap('v', 'ga', ':Lspsaga range_code_action<CR>', {noremap = true, silent = true})
----vim.api.nvim_set_keymap('n', 'gD', ':Lspsaga preview_definition<CR>', {noremap = true, silent = true})
--vim.api.nvim_set_keymap('n', 'gs', ':lua vim.lsp.buf signature_help<CR>', {noremap = true, silent = true})
--vim.api.nvim_set_keymap('n', 'ge', ':lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', {noremap = true, silent = true})
----vim.api.nvim_set_keymap('n', 'gr', ':Telescope lsp_references<CR>', {noremap = true, silent = true})
--vim.api.nvim_set_keymap('n', 'gr', ':lua vim.lsp.buf.references()<CR>', {noremap = true, silent = true})

--vim.api.nvim_set_keymap('n', 'K', ':lua vim.lsp.buf.hover()<CR>', {noremap = true, silent = true})

--vim.api.nvim_set_keymap('n', '[e', ':lua vim.lsp.diagnostic.goto_prev({ popup_opts = { border = "single" }})<CR>', {noremap = true, silent = true})
--vim.api.nvim_set_keymap('n', ']e', ':lua vim.lsp.diagnostic.goto_next({ popup_opts = { border = "single" }})<CR>', {noremap = true, silent = true})

--vim.api.nvim_set_keymap('n', '[e', ':Lspsaga diagnostic_jump_next<CR>', {noremap = true, silent = true})
--vim.api.nvim_set_keymap('n', ']e', ':Lspsaga diagnostic_jump_prev<CR>', {noremap = true, silent = true})
-- scroll down hover doc or scroll in definition preview
--vim.cmd("nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>")
-- scroll up hover doc
--vim.cmd("nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>")

--vim.cmd('command! -nargs=0 LspVirtualTextToggle lua require("lsp/virtual_text").toggle()')


local capabilities = vim.lsp.protocol.make_client_capabilities()
--capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
   properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
   },
}
lsp_config.capabilities = capabilities
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


local lsp_handlers = function()
   local function lspSymbol(name, icon)
    --vim.fn.sign_define("LspDiagnosticsSign" .. name, {text = icon })
      local hl = "DiagnosticSign" .. name
      vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
   end

   lspSymbol("Error", "")
   lspSymbol("Info", "")
   lspSymbol("Hint", "")
   lspSymbol("Warn", "")

   vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      --virtual_text = {
      --   prefix = "",
      --   spacing = 0,
      --},
      virtual_text = false,
      signs = true,
      underline = true,
      update_in_insert = false, -- update diagnostics insert mode
   })
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
end



require('lsp.lspservers').setup_lsp(lsp_config.on_attach, lsp_config.capabilities)

lsp_handlers()

local border_vertical   = "║"
local border_horizontal = "═"
local border_topleft    = "╔"
local border_topright   = "╗"
local border_botleft    = "╚"
local border_botright   = "╝"
local border_juncleft   = "╠"
local border_juncright  = "╣"

local if_nil = vim.F.if_nil

vim.lsp.diagnostic.show_line_diagnostics = function(opts, bufnr, line_nr, client_id)
    opts = opts or {}
    opts.severity_sort = if_nil(opts.severity_sort, true)

    local show_header = if_nil(opts.show_header, true)

    bufnr = bufnr or 0
    line_nr = line_nr or (vim.api.nvim_win_get_cursor(0)[1] - 1)

    local lines = {}
    local highlights = {}
    if show_header then
        table.insert(lines, "Diagnostics:")
        table.insert(highlights, {0, "Bold"})
    end

    local line_diagnostics = vim.lsp.diagnostic.get_line_diagnostics(bufnr, line_nr, opts, client_id)
    if vim.tbl_isempty(line_diagnostics) then return end

    for i, diagnostic in ipairs(line_diagnostics) do
        local prefix = string.format("%d. ", i)
        local hiname = vim.lsp.diagnostic._get_floating_severity_highlight_name(diagnostic.severity)
        assert(hiname, 'unknown severity: ' .. tostring(diagnostic.severity))

        local message_lines = vim.split(diagnostic.message, '\n', true)

        local columns = api.nvim_get_option('columns')
        local popup_max_width = math.floor(columns - (columns * 2 / 10))
        local stripped_max_width = {}

        for _, line in ipairs(message_lines) do
            local len = line:len()

            if len > popup_max_width then
                for j=1,math.ceil(len / popup_max_width) do
                    table.insert(stripped_max_width, string.sub(line, 1 + ((j-1) * popup_max_width), (j * popup_max_width)))
                end
            else
                table.insert(stripped_max_width, line)
            end
        end

        message_lines = stripped_max_width

        table.insert(lines, prefix..message_lines[1])
        table.insert(highlights, {#prefix + 1, hiname})
        for j = 2, #message_lines do
            table.insert(lines, message_lines[j])
            table.insert(highlights, {2, hiname})
        end
    end

    local max_length = 0

    for _, line in ipairs(lines) do
        local len = line:len()
        if len > max_length then
            max_length = len
        end
    end

    for i, line in ipairs(lines) do
        local len = line:len()
        lines[i] = string.format('%s%s%s%s', border_vertical, line, string.rep(" ", max_length - len), border_vertical)
    end

    table.insert(lines, 1, border_topleft..string.rep(border_horizontal, max_length)..border_topright)
    table.insert(lines, border_botleft..string.rep(border_horizontal, max_length)..border_botright)

    local popup_bufnr, winnr = vim.lsp.util.open_floating_preview(lines, 'plaintext')
    for i, hi in ipairs(highlights) do
        local prefixlen, hiname = unpack(hi)
        -- Start highlight after the prefix
        api.nvim_buf_add_highlight(popup_bufnr, -1, hiname, i, prefixlen+2, max_length + 4)
    end

    return popup_bufnr, winnr
end


return lsp_config
