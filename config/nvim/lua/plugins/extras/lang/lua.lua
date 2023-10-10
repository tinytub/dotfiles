return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      --      autoformat = false,
      servers = {
        --lua_ls = require "lsp.servers.sumneko_lua",
        lua_ls = {
          --init_options = { documentFormatting = true, codeAction = false },
          --   cmd = { "lua-language-server", "-E", main_path },
          --filetypes = { "lua" },
          settings = {
            Lua = {
              diagnostics = {
                enable = true,
              },
              completion = {
                callSnippet = "Replace",
              },
              workspace = {
                checkThirdParty = false,
              },
              --hint = {
              --  enable = true,
              --  setType = false,
              --  paramType = true,
              --  paramName = "Disable",
              --  semicolon = "Disable",
              --  arrayIndex = "Disable",
              --},
              --telemetry = {
              --  enable = false,
              --},
              single_file_support = true,
              --format = {
              --  --  enable = false,
              --  --defaultConfig = {
              --  --  indent_style = "space",
              --  --  indent_size = "2",
              --  --  continuation_indent_size = "2",
              --  --},
              --},
            },
          },
        },
      },
    },
  },
}
