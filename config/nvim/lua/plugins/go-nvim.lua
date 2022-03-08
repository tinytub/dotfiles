require('go').setup({
 --verbose = plugin_debug(),
 -- goimport = 'goimports', -- 'gopls'
 --filstruct = "gopls",
 --log_path = vim.fn.expand("$HOME") .. "/tmp/gonvim.log",
 --lsp_codelens = false, -- use navigator
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
