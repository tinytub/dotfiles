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

      -- HACK: #104 Invalid in command-line window
      local hl = require("todo-comments.highlight")
      local highlight_win = hl.highlight_win
      hl.highlight_win = function(win, force)
        pcall(highlight_win, win, force)
      end

      todocomments.setup({
        signs = false,
        highlight = {
          keyword = "bg",
        },
        keywords = {
          FIX = {
            icon = " ", -- icon used for the sign, and in search results
            color = "error", -- can be a hex color, or a named color (see below)
            alt = { "FIXME", "BUG", "FIXIT", "ISSUE", "fix", "fixme", "bug" }, -- a set of other keywords that all map to this FIX keywords
            -- signs = false, -- configure signs for some keywords individually
          },
          IDEA = { icon = " ", color = "#ffb86c" },
          TODO = { icon = " ", color = "#bd93f9" },
          HACK = { icon = " ", color = "#ffb86c" },
          WARN = { icon = " ", color = "#ff5555", alt = { "WARNING", "XXX" } },
          --PERF = { icon = " ", color = "#8be9fd", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
          NOTE = { icon = " ", color = "#50fa7b", alt = { "INFO" } },
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
  },
}
--return {
--
--  {
--    "akinsho/bufferline.nvim",
--    lazy = false,
--    dependencies = { "catppuccin", "nvim-web-devicons" },
--    event = "VeryLazy",
--    keys = {
--      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
--      { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
--      { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete other buffers" },
--      { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete buffers to the right" },
--      { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete buffers to the left" },
--      { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
--      { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
--      { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
--      { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
--    },
--    opts = {
--      options = {
--        diagnostics = "nvim_lsp",
--        show_buffer_close_icons = false,
--        diagnostics_indicator = function(_, _, diag)
--          local icons = require("lazyvim.config").icons.diagnostics
--          -- local icons = require("plugins.configs.lspkind_icons").diagnostics
--          local ret = (diag.error and icons.Error .. diag.error .. " " or "")
--            .. (diag.warning and icons.Warn .. diag.warning or "")
--          return vim.trim(ret)
--        end,
--        offsets = {
--          {
--            filetype = "neo-tree",
--            text = "Neo-tree",
--            highlight = "Directory",
--            text_align = "left",
--          },
--        },
--      },
--    },
--    config = function(_, opts)
--      opts.highlights = require("catppuccin.groups.integrations.bufferline").get()
--      require("bufferline").setup(opts)
--      -- Fix bufferline when restoring a session
--      vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
--        callback = function()
--          vim.schedule(function()
--            pcall(nvim_bufferline)
--          end)
--        end,
--      })
--    end,
--  },
--}
