local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local main_path = vim.fn.stdpath "data" .. "/lsp_servers/sumneko_lua/extension/server/bin/main.lua"

-- need brew install lua-language-server
return {
    init_options = { documentFormatting = true, codeAction = false },
 --   cmd = { "lua-language-server", "-E", main_path },
    filetypes = { "lua" },
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
--                path = runtime_path,
            },
            diagnostics = {
                enable = true,
                globals = { "vim", "packer_plugins" }
            },
            completion = {
                keywordSnippet = "Replace",
                callSnippet = "Replace",
            },
            workspace = {
                library = {
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true },
                preloadFileSize = 100000,
                maxPreload = 10000
            },
            telemetry = {
                enable = false,
            },
            single_file_support = true,
        },
    },
}
