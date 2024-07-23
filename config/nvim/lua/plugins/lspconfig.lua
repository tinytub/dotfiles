return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- disable a keymap
      keys[#keys + 1] = { "<c-k>", false }
    end,
    opts = {
      inlay_hints = {
        enabled = false,
        exclude = { "vue" }, -- filetypes for which you don't want to enable inlay hints
      },
      codelens = {
        enabled = false,
      },
      servers = {
        --  gopls = require "lsp.servers.gopls",
        gopls = {
          --cmd = {
          --  "gopls", -- share the gopls instance if there is one already
          --  "-remote.debug=:0",
          --},
          keys = {
            -- Workaround for the lack of a DAP strategy in neotest-go: https://github.com/nvim-neotest/neotest-go/issues/12
            { "<leader>td", "<cmd>lua require('dap-go').debug_test()<CR>", desc = "Debug Nearest (Go)" },
          },
          settings = {
            gopls = {
              --gofumpt = false,
              --codelenses = {
              --  gc_details = false,
              --  generate = true,
              --  regenerate_cgo = true,
              --  run_govulncheck = false,
              --  test = false,
              --  tidy = true,
              --  upgrade_dependency = true,
              --  vendor = true,
              --},
              ---- 这几个是干啥的
              --hints = {
              --  assignVariableTypes = true,
              --  compositeLiteralFields = true,
              --  compositeLiteralTypes = true,
              --  constantValues = true,
              --  functionTypeParameters = true,
              --  parameterNames = true,
              --  rangeVariableTypes = true,
              --},
              --analyses = {
              --  fieldalignment = false,
              --  nilness = true,
              --  unusedwrite = true,
              --  useany = true,

              --  fillstruct = false, -- 关闭自动填充 struct. 默认打开
              --  unusedparams = true,
              --},

              usePlaceholders = false, -- 填充补全后的 functions param. 默认打开
              --completeUnimported = true,
              --staticcheck = true,
              --directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
              --semanticTokens = true,
            },
          },
          flags = { allow_incremental_sync = true, debounce_text_changes = 150 },
        },
      },
    },
  },
}
