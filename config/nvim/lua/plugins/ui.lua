return {
  -- todo highlights
  {
    "folke/todo-comments.nvim",
    event = "LazyFile",
    config = function()
      local status_ok, todocomments = pcall(require, "todo-comments")
      if not status_ok then
        return
      end

      ---- HACK: #104 Invalid in command-line window
      --local hl = require("todo-comments.highlight")
      --local highlight_win = hl.highlight_win
      --hl.highlight_win = function(win, force)
      --  pcall(highlight_win, win, force)
      --end

      todocomments.setup({
        --signs = false,
        --highlight = {
        --  keyword = "bg",
        --},
        keywords = {
          FIX = {
            icon = " ", -- icon used for the sign, and in search results
            color = "error", -- can be a hex color, or a named color (see below)
            alt = { "FIXME", "BUG", "FIXIT", "ISSUE", "fix", "fixme", "bug" }, -- a set of other keywords that all map to this FIX keywords
            -- signs = false, -- configure signs for some keywords individually
          },
          -- TODO = { icon = " ", color = "info" },
          -- HACK = { icon = " ", color = "warning" },
          -- WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
          -- PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
          -- NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
          -- TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
        },
      })
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    enabled = true,
    keys = {
      { "<c-f>", false },
      { "<c-b>", false },
    },
    opts = function(_, opts)
      opts.presets = {
        lsp_doc_border = true, -- add a border to hover docs and signature help
      }
    end,
  },
  {
    "folke/edgy.nvim",
    event = "VeryLazy",
    enabled = true,
    opts = function(_, opts)
      opts.animate = {
        enabled = false,
      }
      opts.exit_when_last = true
    end,
  },
  {
    "nvim-mini/mini.indentscope",
    version = false, -- wait till new 0.7.0 release to put it back on semver
    event = "LazyFile",

    opts = function(_, opts)
      -- symbol = "",
      opts.symbol = "│" -- ▏│
      -- delay = 0,
      opts.options = { try_as_border = true }
      opts.draw = {
        animation = require("mini.indentscope").gen_animation.none(),
      }
    end,
  },
}
