return {
  -- copilot
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      local Util = require "utils"
      local colors = {
        [""] = Util.fg "Special",
        ["Normal"] = Util.fg "Special",
        ["Warning"] = Util.fg "DiagnosticError",
        ["InProgress"] = Util.fg "DiagnosticWarn",
      }
      table.insert(opts.sections.lualine_x, 2, {
        function()
          local icons = require("plugins.configs.lspkind_icons").kinds.Copilot
          local status = require("copilot.api").status.data
          return icons .. (status.message or "")
        end,

        separator = { left = "", right = "" },
        cond = function()
          local ok, clients = pcall(vim.lsp.get_active_clients, { name = "copilot", bufnr = 0 })
          return ok and #clients > 0
        end,
        color = function()
          if not package.loaded["copilot"] then return end
          local status = require("copilot.api").status.data
          return { bg = "#313244", fg = "#80A7EA" }
          --return colors[status.status] or { bg = "#313244", fg = "#80A7EA" }
        end,
      })
    end,
  },

  -- copilot cmp source
  {
    "nvim-cmp",
    dependencies = {
      {
        "zbirenbaum/copilot-cmp",
        dependencies = "copilot.lua",
        opts = {},
        config = function(_, opts)
          local copilot_cmp = require "copilot_cmp"
          copilot_cmp.setup(opts)
          -- attach cmp source whenever copilot attaches
          -- fixes lazy-loading issues with the copilot cmp source
          require("utils").on_attach(function(client)
            if client.name == "copilot" then
              copilot_cmp._on_insert_enter({})
            end
          end)
        end,
      },
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      --table.insert(opts.sources, 1, { name = "copilot", group_index = 2 })
      table.insert(opts.sources, 3, { name = "copilot" })
      opts.sorting = opts.sorting or require("cmp.config.default")().sorting
      table.insert(opts.sorting.comparators, 1, require("copilot_cmp.comparators").prioritize)
    end,
  },
}
