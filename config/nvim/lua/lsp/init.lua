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
   buf_set_keymap("n", "[e", '<cmd>lua vim.lsp.diagnostic.goto_prev({ popup_opts = { border = "single" }})<CR>', opts)
   buf_set_keymap("n", "]e", '<cmd>lua vim.lsp.diagnostic.goto_next({ popup_opts = { border = "single" }})<CR>', opts)
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

-- Set Default Prefix.
-- Note: You can set a prefix per lsp server in the lv-globals.lua file
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
   virtual_text = false,
   --virtual_text = {
   --   prefix = "",
   --   spacing = 0,
   --},
    signs = true,
    underline = true,
    update_in_insert = false,
  }
)

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "single",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = "single",
})

-- suppress error messages from lang servers
--vim.notify = function(msg, log_level, _opts)
--    if msg:match "exit code" then
--        return
--    end
--    if log_level == vim.log.levels.ERROR then
--        vim.api.nvim_err_writeln(msg)
--    else
--        vim.api.nvim_echo({{msg}}, true, {})
--    end
--end

---- symbols for autocomplete
--vim.lsp.protocol.CompletionItemKind = {
--    "   (Text) ",
--    "   (Method)",
--    "   (Function)",
--    "   (Constructor)",
--    " ﴲ  (Field)",
--    "[] (Variable)",
--    "   (Class)",
--    " ﰮ  (Interface)",
--    "   (Module)",
--    " 襁 (Property)",
--    "   (Unit)",
--    "   (Value)",
--    " 練 (Enum)",
--    "   (Keyword)",
--    "   (Snippet)",
--    "   (Color)",
--    "   (File)",
--    "   (Reference)",
--    "   (Folder)",
--    "   (EnumMember)",
--    " ﲀ  (Constant)",
--    " ﳤ  (Struct)",
--    "   (Event)",
--    "   (Operator)",
--    "   (TypeParameter)"
--}

--[[ " autoformat
autocmd BufWritePre *.js lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.jsx lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.lua lua vim.lsp.buf.formatting_sync(nil, 100) ]]
-- Java
-- autocmd FileType java nnoremap ca <Cmd>lua require('jdtls').code_action()<CR>


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


-- replace the default lsp diagnostic symbols
local function lspSymbol(name, icon)
    --vim.fn.sign_define("LspDiagnosticsSign" .. name, {text = icon, numhl = "LspDiagnosticsDefault" .. name})
    vim.fn.sign_define("LspDiagnosticsSign" .. name, {text = icon })
end

lspSymbol("Error", "")
lspSymbol("Warning", "")
lspSymbol("Information", "")
lspSymbol("Hint", "")

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


--if O.document_highlight then
--function lsp_config.common_on_attach(client, bufnr)
--    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
--    on_attach()
--
--    documentHighlight(client, bufnr)
--end
--end

--function lsp_config.tsserver_on_attach(client, bufnr)
--    lsp_config.on_attach(client, bufnr)
--    client.resolved_capabilities.document_formatting = false
--end

-- suppress error messages from lang servers
vim.notify = function(msg, log_level, _opts)
   if msg:match "exit code" then
      return
   end
   if log_level == vim.log.levels.ERROR then
      vim.api.nvim_err_writeln(msg)
   else
      vim.api.nvim_echo({ { msg } }, true, {})
   end
end

--local servers = {}
--
--for _, lsp in ipairs(servers) do
--   nvim_lsp[lsp].setup {
--      on_attach = lsp_config.on_attach,
--      capabilities = lsp_config.capabilities,
--      -- root_dir = vim.loop.cwd,
--      flags = {
--         debounce_text_changes = 150,
--      },
--   }
--end


require('lsp.lspservers').setup_lsp(lsp_config.on_attach,lsp_config.capabilities)


return lsp_config
