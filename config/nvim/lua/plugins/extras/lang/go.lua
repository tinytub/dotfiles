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

  ---- go
  --local dap = require("dap")
  --
  --vim.fn.sign_define('DapBreakpoint', {text='⛔', texthl='', linehl='', numhl=''})
  --vim.fn.sign_define('DapStopped', {text='👉', texthl='', linehl='', numhl=''})
  --
  ----dap.defaults.fallback.terminal_win_cmd = "50vsplit new"
  --
  --dap.adapters.go = function(callback, config)
  --    local stdout = vim.loop.new_pipe(false)
  --    local handle
  --    local pid_or_err
  --    local port = 38697
  --    local opts = {
  --      stdio = {nil, stdout},
  --      args = {"dap", "-l", "127.0.0.1:" .. port},
  --      detached = true
  --    }
  --    handle, pid_or_err = vim.loop.spawn("dlv", opts, function(code)
  --      stdout:close()
  --      handle:close()
  --      if code ~= 0 then
  --        print('dlv exited with code', code)
  --      end
  --    end)
  --    assert(handle, 'Error running dlv: ' .. tostring(pid_or_err))
  --    stdout:read_start(function(err, chunk)
  --      assert(not err, err)
  --      if chunk then
  --        vim.schedule(function()
  --          require('dap.repl').append(chunk)
  --        end)
  --      end
  --    end)
  --    -- Wait for delve to start
  --    vim.defer_fn(
  --      function()
  --        callback({type = "server", host = "127.0.0.1", port = port})
  --      end,
  --      100)
  --end
  --
  --
  --dap.configurations.go = {
  --    {
  --        type = "go",
  --        name = "Debug",
  --        request = "launch",
  --        program = "${file}"
  --    },
  --    {
  --        type = "go",
  --        name = "Debug test", -- configuration for debugging test files
  --        request = "launch",
  --        mode = "test",
  --        program = "${file}"
  --    },
  --    -- works with go.mod packages and sub packages
  --    {
  --        type = "go",
  --        name = "Debug test (go.mod)",
  --        request = "launch",
  --        mode = "test",
  --        program = "./${relativeFileDirname}"
  --    }
  --}
  --
  ---- lua
  --dap.configurations.lua = {
  --  {
  --    type = 'nlua',
  --    request = 'attach',
  --    name = "Attach to running Neovim instance",
  --    host = function()
  --      local value = vim.fn.input('Host [127.0.0.1]: ')
  --      if value ~= "" then
  --        return value
  --      end
  --      return '127.0.0.1'
  --    end,
  --    port = function()
  --      local val = tonumber(vim.fn.input('Port: '))
  --      assert(val, "Please provide a port number")
  --      return val
  --    end,
  --  }
  --}
  --
  --dap.adapters.nlua = function(callback, config)
  --  callback({ type = 'server', host = config.host, port = config.port })
  --end
  {
    "neovim/nvim-lspconfig",
    opts = {
      --      autoformat = false,
      servers = {
        --  gopls = require "lsp.servers.gopls",
        gopls = {
          --cmd = {
          --  "gopls", -- share the gopls instance if there is one already
          --  "-remote.debug=:0",
          --},
          settings = {
            gopls = {
              gofumpt = false,
              codelenses = {
                gc_details = false,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = false,
                test = false,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
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

              -- stop autoformat and use format_acmd_go instead
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
