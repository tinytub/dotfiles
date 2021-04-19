local api = vim.api
local lspconfig = require 'lspconfig'
local lspinstall_dir = require('core.global').lspinstall_dir
local global = require 'core.global'
local format = require('modules.completion.format')

--if not packer_plugins['lspsaga.nvim'].loaded then
--  vim.cmd [[packadd lspsaga.nvim]]
--end

--local saga = require 'lspsaga'
--saga.init_lsp_saga({
----  code_action_icon = '💡',
---- 	error_sign = '❌',
---- 	warn_sign = '⚠️',
---- 	hint_sign = '💡',
---- 	infor_sign = 'ℹ️',
---- 	dianostic_header_icon = ' 🚒 ',
---- 	code_action_keys = {
---- 		quit = '<esc>',
---- 		exec = '<cr>'
---- 	},
-- 	finder_definition_icon = '📖 ',
-- 	finder_reference_icon = '🔖 ',
-- 	finder_action_keys = {
--    open = 'o', vsplit = 's',split = 'i',quit = 'q',scroll_down = '<C-f>', scroll_up = '<C-b>'
-- 	},
-- 	code_action_keys = {
-- 		quit = '<esc>',
-- 		exec = '<cr>'
-- 	},
-- 	rename_action_keys = {
-- 		quit = '<esc>',
-- 		exec = '<cr>'
-- 	},
-- 	definition_preview_icon = '📖 '
--})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

function _G.reload_lsp()
  vim.lsp.stop_client(vim.lsp.get_active_clients())
  vim.cmd [[edit]]
end

function _G.open_lsp_log()
  local path = vim.lsp.get_log_path()
  vim.cmd("edit " .. path)
end

vim.cmd('command! -nargs=0 LspLog call v:lua.open_lsp_log()')
vim.cmd('command! -nargs=0 LspRestart call v:lua.reload_lsp()')

-- Define diagnostic signs and highlighting colors
--vim.api.nvim_call_function('sign_define',{"LspDiagnosticsSignError", {text = "",
--  texthl = "LspDiagnosticsDefaultError",
--  numhl = "LspDiagnosticsDefaultError"
--}})
--vim.api.nvim_call_function('sign_define',{"LspDiagnosticsSignWarning", {text = "",
--  texthl = "LspDiagnosticsDefaultWarning",
--  numhl = "LspDiagnosticsDefaultWarning"
--}})
--vim.api.nvim_call_function('sign_define',{"LspDiagnosticsSignInformation", {text = "",
--  texthl = "LspDiagnosticsDefaultInformation",
--  numhl = "LspDiagnosticsDefaultInformation"
--}})
--vim.api.nvim_call_function('sign_define',{"LspDiagnosticsSignHint", {text = "",
--  texthl = "LspDiagnosticsDefaultHint",
--  numhl = "LspDiagnosticsDefaultHint"
--}})
--vim.fn.sign_define("LspDiagnosticsSignError",{ text = "", texthl = "LspDiagnosticsDefaultError" })
--vim.fn.sign_define("LspDiagnosticsSignWarning",{ text = "", texthl = "LspDiagnosticsDefaultWarning" })
--vim.fn.sign_define("LspDiagnosticsSignInformation",{ text = "", texthl = "LspDiagnosticsDefaultInformation" })
--vim.fn.sign_define("LspDiagnosticsSignHint",{ text = "", texthl = "LspDiagnosticsDefaultHint" })
vim.fn.sign_define(
    "LspDiagnosticsSignError",
    {texthl = "LspDiagnosticsSignError", text = "", numhl = "LspDiagnosticsSignError"}
)
vim.fn.sign_define(
    "LspDiagnosticsSignWarning",
    {texthl = "LspDiagnosticsSignWarning", text = "", numhl = "LspDiagnosticsSignWarning"}
)
vim.fn.sign_define(
    "LspDiagnosticsSignHint",
    {texthl = "LspDiagnosticsSignHint", text = "", numhl = "LspDiagnosticsSignHint"}
)
vim.fn.sign_define(
    "LspDiagnosticsSignInformation",
    {texthl = "LspDiagnosticsSignInformation", text = "", numhl = "LspDiagnosticsSignInformation"}
)

-- replace lsp-kind
vim.lsp.protocol.CompletionItemKind = {
    "   (Text) ",
    "   (Method)",
    "   (Function)",
    "   (Constructor)",
    " ﴲ  (Field)",
    "[] (Variable)",
    "   (Class)",
    " ﰮ  (Interface)",
    "   (Module)",
    " 襁 (Property)",
    "   (Unit)",
    "   (Value)",
    " 練 (Enum)",
    "   (Keyword)",
    " ﬌  (Snippet)",
    "   (Color)",
    "   (File)",
    "   (Reference)",
    "   (Folder)",
    "   (EnumMember)",
    " ﲀ  (Constant)",
    " ﳤ  (Struct)",
    "   (Event)",
    "   (Operator)",
    "   (TypeParameter)"
}

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    -- Enable underline, use default values
    underline = true,
    -- Enable virtual text, override spacing to 4
    virtual_text = false,
    signs = {
      enable = true,
      priority = 20
    },
    -- Disable a feature
    update_in_insert = false,
})

local enhance_attach = function(client,bufnr)
  if client.resolved_capabilities.document_formatting then
    format.lsp_before_save()
  end
  api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
end

--local util = require('nvim_lsp/util')
lspconfig.gopls.setup {
  --cmd = {"gopls","--remote=auto"},
  cmd = {lspinstall_dir .. "go/gopls", "--remote=auto"},
  on_attach = enhance_attach,
  capabilities = capabilities,
  --on_attach=on_attach_vim,
  root_dir = function(fname)
    return lspconfig.util.root_pattern("go.mod", ".git")(fname) or
      lspconfig.util.path.dirname(fname)
  end,
  init_options = {
    usePlaceholders=true,
    completeUnimported=true,

--    gofumpt = false,
--    staticcheck = true,
    deepCompletion=true,
    allowModfileModifications=true
  }
}

lspconfig.bashls.setup {
    cmd = {lspinstall_dir .. "bash/node_modules/.bin/bash-language-server", "start"},
    on_attach = enhance_attach,
    filetypes = { "sh", "zsh" }
}

-- npm i -g pyright
lspconfig.pyright.setup {
    cmd = {lspinstall_dir .. "python/node_modules/.bin/pyright-langserver", "--stdio"},
    --on_attach = require'lsp'.common_on_attach,
    on_attach = enhance_attach,
    --handlers = {
    --    ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    --        virtual_text = O.python.diagnostics.virtual_text,
    --        signs = O.python.diagnostics.signs,
    --        underline = O.python.diagnostics.underline,
    --        update_in_insert = true

    --    })
    --}
}

lspconfig.sumneko_lua.setup {
  cmd = {
    --global.home.."/workstation/lua-language-server/bin/macOS/lua-language-server",
    --"-E",
    --global.home.."/workstation/lua-language-server/main.lua"
    --global.home.."/Documents/local_projects/lua-language-server/bin/macOS/lua-language-server",
    --"-E",
    --global.home.."/Documents/local_projects/lua-language-server/main.lua"
    lspinstall_dir .. "lua/sumneko-lua-language-server",
    "-E",
    lspinstall_dir .. "lua/main.lua",
  };
  settings = {
    Lua = {
      diagnostics = {
        enable = true,
        globals = {"vim","packer_plugins"}
      },
      runtime = {version = "LuaJIT"},
      workspace = {
        library = {[vim.fn.expand('$VIMRUNTIME/lua')] = true, [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true},
       -- library = vim.list_extend({[vim.fn.expand("$VIMRUNTIME/lua")] = true},{}),
      },
    },
  }
}

lspconfig.clangd.setup {
    cmd = {
        lspinstall_dir .. "cpp/clangd/bin/clangd",
        "--background-index",
        "--suggest-missing-includes",
        "--clang-tidy",
        "--header-insertion=iwyu",
    },
    --on_attach = require'lsp'.common_on_attach,
    on_attach = enhance_attach,
    --handlers = {
    --    ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    --        virtual_text = O.clang.diagnostics.virtual_text,
    --        signs = O.clang.diagnostics.signs,
    --        underline = O.clang.diagnostics.underline,
    --        update_in_insert = true

    --    })
    --}
}

-- npm install -g dockerfile-language-server-nodejs
lspconfig.dockerls.setup {
    cmd = {lspinstall_dir .. "dockerfile/node_modules/.bin/docker-langserver", "--stdio"},
    --on_attach = require'lsp'.common_on_attach,
    on_attach = enhance_attach,
	root_dir = vim.loop.cwd
}

lspconfig.tsserver.setup {
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = false
    enhance_attach(client)
  end
}

--lspconfig.clangd.setup {
--  cmd = {
--    "clangd",
--    "--background-index",
--    "--suggest-missing-includes",
--    "--clang-tidy",
--    "--header-insertion=iwyu",
--  },
--}

lspconfig.rust_analyzer.setup {
  capabilities = capabilities,
}

local servers = {
 -- 'dockerls',
}

for _,server in ipairs(servers) do
  lspconfig[server].setup {
    on_attach = enhance_attach
  }
end
