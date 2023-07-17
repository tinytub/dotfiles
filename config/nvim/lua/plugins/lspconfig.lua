return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "b0o/SchemaStore.nvim", -- Get extra JSON schemas -- 虽然不知道干嘛用,但是先留着吧, jsonls
      { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
      { "folke/neodev.nvim",  opts = {} },


      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      {
        "hrsh7th/cmp-nvim-lsp",
        --cond = function() return require("utils").has "nvim-cmp" end,
      },
    },

    opts = {
      autoformat = true,
      -- add any global capabilities here
      capabilities = {},
      format_notify = false,
      inlay_hints = {
        enabled = false,
      },
      diagnostics = {
        virtual_text = {
          spacing = 4,
          source = "if_many",
          --prefix = "●",
          -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
          -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
          prefix = "icons",
        },
        signs = true,
        severity_sort = true,
        -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
        -- Be aware that you also will need to properly configure your LSP server to
        -- provide the inlay hints.
        underline = true,
        update_in_insert = false, -- update diagnostics insert mode
        float = {
          --  focused = false,
          --  style = "minimal",
          border = "rounded",
          --  source = "always",
          --  header = "",
          --  prefix = "",
        },
      },
      -- options for vim.lsp.buf.format
      -- `bufnr` and `filter` is handled by the formatter,
      -- but can be also overridden when specified
      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- example to setup with typescript.nvim
        -- tsserver = function(_, opts)
        --   require("typescript").setup({ server = opts })
        --   return true
        -- end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },

    config = function(_, opts)
      if require("utils").has("neoconf.nvim") then
        local plugin = require("lazy.core.config").spec.plugins["neoconf.nvim"]
        require("neoconf").setup(require("lazy.core.plugin").values(plugin, "opts", false))
      end
      require("lsp.lspconfig").config(opts)
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    --ft = { 'sh', 'lua', 'zsh', 'bash', 'c', 'cpp', 'cmake', 'html', 'markdown', 'vim', 'json', 'markdown', 'css',
    --  'javascript', 'javascriptreact', 'python' },
    dependencies = { "nvim-lspconfig", "mason.nvim" },
    opts = function()
      local nls = require "null-ls"
      return {
        root_dir = require("null-ls.utils").root_pattern(
          ".null-ls-root",
          ".neoconf.json",
          "Makefile",
          ".git",
          "go.mod"
        ),
        sources = {
          --nls.builtins.formatting.fish_indent,
          --nls.builtins.diagnostics.fish,
          nls.builtins.diagnostics.zsh,
          --nls.builtins.formatting.stylua,
          nls.builtins.formatting.shfmt,
        },
      }
    end,
    --config = function()
    --  require("lsp.null-ls")
    --end,
    enabled = true,
  },

  -- Package Manager
  {
    "williamboman/mason.nvim",
    cmd = { "Mason" },
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    opts = {
      ensure_installed = {
        "stylua",
        "shfmt",
        "gopls",
        -- "flake8",
      },
    },
    --config = function(_,opts)
    --  require "plugins.configs.mason"
    --end,
    ---@param opts MasonSettings | {ensure_installed: string[]}
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require "mason-registry"
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then p:install() end
        end
      end

      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
    enabled = true,
  },



}
