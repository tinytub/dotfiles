return {
  root_dir = function(fname)
    local Path = require("plenary.path")

    local absolute_cwd = Path:new(vim.loop.cwd()):absolute()
    local absolute_fname = Path:new(fname):absolute()

    if string.find(absolute_cwd, "/cmd/", 1, true) and string.find(absolute_fname, absolute_cwd, 1, true) then
      return absolute_cwd
    end

    --local util = require "lspconfig.util"
    --return util.root_pattern("go.mod", ".git")(fname)
    local has_lsp, lspconfig = pcall(require, "lspconfig")
    if has_lsp then
      local util = lspconfig.util
      return util.root_pattern("go.mod", ".git")(fname) or util.path.dirname(fname)
    end
  end,
  filetypes = { "go", "gomod", "gosum", "gotmpl", "gohtmltmpl", "gotexttmpl" },
  -- more settings: https://github.com/golang/tools/blob/master/gopls/doc/settings.md
  settings = {
    gopls = {
      analyses = {
        fillstruct = false, -- 关闭自动填充 struct. 默认打开
        unusedparams = true
      },
      -- staticcheck = true,
      codelenses = {
        generate = true, -- show the `go generate` lens.
        gc_details = true, --  // Show a code lens toggling the display of gc's choices.
        test = true
      },
      --            gofumpt = true,
      usePlaceholders = false, -- 填充补全后的 functions param. 默认打开
      completeUnimported = true,
      --gofumpt = false,
      --hoverKind = "SingleLine",
      --hoverKind = "Structured",
      staticcheck = true,

      matcher = "Fuzzy",
      diagnosticsDelay = "500ms",
      --experimentalWatchedFileDelay = "100ms",
      symbolMatcher = "fuzzy",
      -- ["local"] = "",
      deepCompletion = true,
      gofumpt = false,
      buildFlags = { "-tags", "integration" },
    },
  },
  flags = { allow_incremental_sync = true, debounce_text_changes = 150 },
  --init_options = {
  --    usePlaceholders = false, -- 填充补全后的 functions param. 默认打开
  --    completeUnimported = true,
  --    --gofumpt = false,
  --    --hoverKind = "SingleLine",
  --    --hoverKind = "Structured",
  --    staticcheck = false,
  --    deepCompletion = true,
  --    --allowModfileModifications=true
  --},
}
