return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      --      autoformat = false,
      servers = {
        --lua_ls = require "lsp.servers.sumneko_lua",
        lua_ls = {
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
                --  globals = { "vim", "packer_plugins" }
              },
              completion = {
                keywordSnippet = "Replace",
                callSnippet = "Both",
              },
              workspace = {
                checkThirdParty = false,
                --                library = {
                --                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                --                    [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true },
                preloadFileSize = 100000,
                maxPreload = 10000
              },
              misc = {
                parameters = {
                  -- "--log-level=trace",
                },
              },
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Disable",
              },
              telemetry = {
                enable = false,
              },
              single_file_support = true,
              format = {
                --  enable = false,
                --defaultConfig = {
                --  indent_style = "space",
                --  indent_size = "2",
                --  continuation_indent_size = "2",
                --},
              },
            },
          },
        }
      }
    }
  }

}
