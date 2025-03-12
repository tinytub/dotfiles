return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- disable a keymap
      keys[#keys + 1] = { "<c-k>", false }
    end,
    opts = function(_, opts)
      opts.inlay_hints = {
        enabled = false,
        exclude = { "vue" }, -- filetypes for which you don't want to enable inlay hints
      }
      opts.diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
          -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
          -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
          -- prefix = "icons",
          --
          severity = { min = vim.diagnostic.severity.ERROR },
        },
        float = { border = "rounded" },
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = LazyVim.config.icons.diagnostics.Error,
            [vim.diagnostic.severity.WARN] = LazyVim.config.icons.diagnostics.Warn,
            [vim.diagnostic.severity.HINT] = LazyVim.config.icons.diagnostics.Hint,
            [vim.diagnostic.severity.INFO] = LazyVim.config.icons.diagnostics.Info,
          },
        },
      }
      opts.codelens = {
        enabled = false,
      }
      --opts.servers = {
      --  --  gopls = require "lsp.servers.gopls",
      --  gopls = {
      --    keys = {
      --      -- Workaround for the lack of a DAP strategy in neotest-go: https://github.com/nvim-neotest/neotest-go/issues/12
      --      { "<leader>td", "<cmd>lua require('dap-go').debug_test()<CR>", desc = "Debug Nearest (Go)" },
      --    },
      --    settings = {
      --      gopls = {
      --        usePlaceholders = false, -- 填充补全后的 functions param. 默认打开
      --      },
      --    },
      --    flags = { allow_incremental_sync = true, debounce_text_changes = 150 },
      --  },
      --}
      opts.servers.gopls.settings.gopls.usePlaceholders = false
      opts.servers.gopls.settings.gopls.flags = { allow_incremental_sync = true, debounce_text_changes = 150 }
      --opts.servers.gopls = {
      --  --  gopls = require "lsp.servers.gopls",
      --  keys = {
      --    -- Workaround for the lack of a DAP strategy in neotest-go: https://github.com/nvim-neotest/neotest-go/issues/12
      --    { "<leader>td", "<cmd>lua require('dap-go').debug_test()<CR>", desc = "Debug Nearest (Go)" },
      --  },
      --  --settings = {
      --  --  gopls = {
      --  --    gofumpt = true,
      --  --    codelenses = {
      --  --      gc_details = false,
      --  --      generate = true,
      --  --      regenerate_cgo = true,
      --  --      run_govulncheck = true,
      --  --      test = true,
      --  --      tidy = true,
      --  --      upgrade_dependency = true,
      --  --      vendor = true,
      --  --    },
      --  --    hints = {
      --  --      assignVariableTypes = true,
      --  --      compositeLiteralFields = true,
      --  --      compositeLiteralTypes = true,
      --  --      constantValues = true,
      --  --      functionTypeParameters = true,
      --  --      parameterNames = true,
      --  --      rangeVariableTypes = true,
      --  --    },
      --  --    analyses = {
      --  --      nilness = true,
      --  --      unusedparams = true,
      --  --      unusedwrite = true,
      --  --      useany = true,
      --  --    },
      --  --    usePlaceholders = false, -- 填充补全后的 functions param. 默认打开
      --  --    completeUnimported = true,
      --  --    staticcheck = true,
      --  --    directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
      --  --    semanticTokens = true,
      --  --  },
      --  --},
      --  --flags = { allow_incremental_sync = true, debounce_text_changes = 150 },
      --}
    end,
  },
}
