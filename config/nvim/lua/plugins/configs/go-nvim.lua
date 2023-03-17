require('go').setup({
  --verbose = plugin_debug(),
  -- goimport = 'goimports', -- 'gopls'
  goimport = 'gopls',
  filstruct = "gopls",
  lsp_cfg = false,
  textobjects = false,
  tag_transform = "camelcase", -- can be transform option("snakecase", "camelcase", etc) check gomodifytags for details and more options
  --log_path = vim.fn.expand("$HOME") .. "/tmp/gonvim.log",
  --lsp_codelens = false, -- use navigator
  lsp_keymaps = false, -- set to false to disable gopls/lsp keymap
  lsp_codelens = false,

  dap_debug = true,
  --goimport = "goimports",
  dap_debug_vt = "true",
  dap_debug_gui = true,
  --test_runner = "go", -- richgo, go test, richgo, dlv, ginkgo
  -- run_in_floaterm = true, -- set to true to run in float window.
  --lsp_document_formatting = false,
  -- lsp_on_attach = require("navigator.lspclient.attach").on_attach,
  -- lsp_cfg = true,
})
