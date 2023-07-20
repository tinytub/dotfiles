return {
  {
    "nvim-neotest/neotest",
    enabled = true,
    ft = { "go", "rust", "python" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      --'nvim-treesitter/nvim-treesitter',
      --'antoinemadec/FixCursorHold.nvim',
      "rcarriga/neotest-plenary",
      "nvim-neotest/neotest-python",
      "nvim-neotest/neotest-go",
    },
    config = function() require "plugins.configs.neotest" end,
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      --'nvim-treesitter/nvim-treesitter',
      --'antoinemadec/FixCursorHold.nvim',
      "rcarriga/neotest-plenary",
      "nvim-neotest/neotest-python",
      "nvim-neotest/neotest-go",
    },
    opts = {
      -- Can be a list of adapters like what neotest expects,
      -- or a table of adapter names, mapped to adapter configs.
      -- The adapter will then be automatically loaded with the config.

      adapters = {
        ["neotest-plenary"] = {},
        ["neotest-python"] = {},
      },
      discovery = {
        enabled = false,
      },
      summary = {
        mappings = {
          expand = { "l", "zo", "za" },
          expand_all = { "e", "zO" },
          mark = { "<Tab>", "m", "<Space>" },
          jumpto = { "i", "<CR>", "<2-LeftMouse>" },
        },
      },
      output = {
        open_on_run = false,
      },
      icons = {
        child_indent = " ",
        child_prefix = " ",
        expanded = " ",
        final_child_prefix = " ",
        collapsed = " ",
        non_collapsible = " ",
        running_animated = { "◴", "◷", "◶", "◵" },
        passed = "",
        failed = "",
        running = "",
        skipped = "",
        unknown = "",
      },
    },
    status = { virtual_text = true },
    output = { open_on_run = true },
    quickfix = {
      open = function()
        if require("lazyvim.util").has "trouble.nvim" then
          vim.cmd "Trouble quickfix"
        else
          vim.cmd "copen"
        end
      end,
    },
    config = function(_, opts)
      local neotest_ns = vim.api.nvim_create_namespace "neotest"
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            -- Replace newline and tab characters with space for more compact diagnostics
            local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            return message
          end,
        },
      }, neotest_ns)

      local adapters = {}
      if opts.adapters then
        for name, config in pairs(opts.adapters or {}) do
          if type(name) == "number" then
            if type(config) == "string" then config = require(config) end
            adapters[#adapters + 1] = config
          elseif config ~= false then
            local adapter = require(name)
            if type(config) == "table" and not vim.tbl_isempty(config) then
              local meta = getmetatable(adapter)
              if adapter.setup then
                adapter.setup(config)
              elseif meta and meta.__call then
                adapter(config)
              else
                error("Adapter " .. name .. " does not support setup")
              end
            end
            adapters[#adapters + 1] = adapter
          end
        end
        opts.adapters = adapters
      end

      --require("neotest").setup { adapters = adapters }
      --require "plugins.configs.neotest"
      require("neotest").setup(opts)
    end,
    -- stylua: ignore
    keys = {
      { "<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File" },
      { "<leader>tT", function() require("neotest").run.run(vim.loop.cwd()) end, desc = "Run All Test Files" },
      { "<leader>tn", function() require("neotest").run.run() end, desc = "Run Nearest" },
      { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle Summary" },
      { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output" },
      { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel" },
      { "<leader>tS", function() require("neotest").run.stop() end, desc = "Stop" },
    },
  },
  {
    "mfussenegger/nvim-dap",
    optional = true,
    -- stylua: ignore
    keys = {
      { "<leader>td", function() require("neotest").run.run({strategy = "dap"}) end, desc = "Debug Nearest" },
    },
  },
}
