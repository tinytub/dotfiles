return {
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      {
        "mason.nvim",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          table.insert(opts.ensure_installed, "delve")
        end,
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      --      autoformat = false,
      servers = {
        gopls = require "lsp.servers.gopls",
      },
      setup = {
        gopls = function()
          -- workaround for gopls not supporting semantictokensprovider
          -- https://github.com/golang/go/issues/54531#issuecomment-1464982242
          require("utils").on_attach(function(client, _)
            client.server_capabilities.documentFormattingProvider = true
            client.server_capabilities.documentRangeFormattingProvider = true
            if client.name == "gopls" then
              if not client.server_capabilities.semanticTokensProvider then
                local semantic = client.config.capabilities.textDocument.semanticTokens
                client.server_capabilities.semanticTokensProvider = {
                  full = true,
                  legend = {
                    tokenTypes = semantic.tokenTypes,
                    tokenModifiers = semantic.tokenModifiers,
                  },
                  range = true,
                }
              end

              vim.b.autoformat = false

              require("lsp.format").format_acmd_go()
            end
          end)
          -- end workaround
        end,
      },
    },
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "nvim-neotest/neotest-go",
    },
    opts = {
      adapters = {
        ["neotest-go"] = {
          -- args = { '-race' },
          args = { "-count=1", "-timeout=60s" },
          experimantal = {
            test_table = true,
          },
        },
      },
    },
  },
}
