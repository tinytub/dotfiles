local lspconfig = require 'lspconfig'
--local format = require('lsp.format')

require'lspconfig'.gopls.setup{
    cmd = {DATA_PATH .. "/lspinstall/go/gopls"},
    on_attach = require'lsp'.on_attach,
    capabilities = require'lsp'.capabilities,
    root_dir = function(fname)
        return lspconfig.util.root_pattern("go.mod", ".git")(fname) or
          lspconfig.util.path.dirname(fname)
      end,
    settings = {
        gopls = {
            analyses = {
                fillstruct = false, -- 关闭自动填充 struct. 默认打开
                unusedparams = true
            },
            staticcheck = true
        }
    },
    init_options = {
        usePlaceholders = false, -- 填充补全后的 functions param. 默认打开
        completeUnimported = true,
        --gofumpt = false,
        --hoverKind = "SingleLine",
        --hoverKind = "Structured",
        staticcheck = false,
        deepCompletion = false,
        --allowModfileModifications=true
    }
}

