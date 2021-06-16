local lspconfig = require 'lspconfig'
local format = require('lsp.format')


local enhance_attach = function(client,bufnr)
  if client.resolved_capabilities.document_formatting then
    format.lsp_before_save()
  end
  --require "lsp_signature".on_attach({   -- add lsp_signature support
  --    bind = true, -- This is mandatory, otherwise border config won't get registered.
  --    handler_opts = {
  --      border = "single"
  --    }
  --})
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
end

require'lspconfig'.gopls.setup{
    cmd = {DATA_PATH .. "/lspinstall/go/gopls"},
    settings = {gopls = {analyses = {unusedparams = true}, staticcheck = true}},
    --root_dir = require'lspconfig'.util.root_pattern(".git","go.mod","."),
    --init_options = {usePlaceholders = true, completeUnimported = true},
    --on_attach = enhance_attach,
    on_attach = require'lsp'.common_on_attach,
    root_dir = function(fname)
        return lspconfig.util.root_pattern("go.mod", ".git")(fname) or
          lspconfig.util.path.dirname(fname)
      end,
      init_options = {
        analyses = {
          fillstruct = false, -- 关闭自动填充 struct. 默认打开
          unusedparams = true,
        },
        usePlaceholders=false, -- 填充补全后的 functions param. 默认打开
        completeUnimported=true,
        gofumpt = false,
    --    staticcheck = true,
        deepCompletion=false,
        allowModfileModifications=true
      }
}
