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
        --  gopls = require "lsp.servers.gopls",
        gopls = {
          cmd = {
            "gopls", -- share the gopls instance if there is one already
            "-remote.debug=:0",
          },
          settings = {
            gopls = {
              gofumpt = true,
              codelenses = {
                gc_details = false,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
                --generate = true, -- show the `go generate` lens.
                --gc_details = true, --  // Show a code lens toggling the display of gc's choices.
                --test = true,
              },
              -- 这几个是干啥的
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
              analyses = {
                fieldalignment = true,
                nilness = true,
                unusedwrite = true,
                useany = true,

                fillstruct = false, -- 关闭自动填充 struct. 默认打开
                unusedparams = true,
              },

              usePlaceholders = false, -- 填充补全后的 functions param. 默认打开
              completeUnimported = true,
              staticcheck = true,
              directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
              semanticTokens = true,
            },
          },
          flags = { allow_incremental_sync = true, debounce_text_changes = 150 },
        },
      },
      setup = {
        gopls = function(_, opts)
          -- workaround for gopls not supporting semanticTokensProvider
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
  -- Ensure Go tools are installed
  --{
  --  "jose-elias-alvarez/null-ls.nvim",
  --  opts = function(_, opts)
  --    if type(opts.sources) == "table" then
  --      local nls = require("null-ls")
  --      vim.list_extend(opts.sources, {
  --        nls.builtins.code_actions.gomodifytags,
  --        nls.builtins.code_actions.impl,
  --        nls.builtins.formatting.gofumpt,
  --        nls.builtins.formatting.goimports_reviser,
  --      })
  --    end
  --  end,
  --},
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
