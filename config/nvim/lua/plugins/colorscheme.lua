return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    --dependencies = "nvim-treesitter",
    --dependencies = "bufferline.nvim",
    --    run = ":CatppuccinCompile",
    --config = function() require "colors.catppuccin" end,
    enabled = true,
    lazy = true,
    vscode = true,
    opts = function(_, opts)
      local bufferline = require("catppuccin.groups.integrations.bufferline")
      bufferline.get = bufferline.get or bufferline.get_theme

      opts.flavour = "macchiato" -- latte, frappe, macchiato, mocha
      opts.integrations = {
        avante = true,
      }
      opts.background = {
        -- :h background
        light = "latte",
        dark = "macchiato",
        --dark = "mocha",
      }
      -- 非活动窗口搞成深色
      opts.dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.99,
      }
      opts.transparent_background = true
      opts.no_italic = true
      opts.no_bold = false
      opts.compile = {
        enabled = true,
        path = vim.fn.stdpath("cache") .. "/catppuccin",
      }
      --opts.color_overrides = {
      --  mocha = {
      --    -- I don't think these colours are pastel enough by default!
      --    peach = "#fcc6a7",
      --    green = "#d2fac5",
      --  },
      --}
      opts.custom_highlights = function(colors)
        return {
          --WinSeparator = { fg = colors.yellow, style = { "bold" } },
          --WinSeparator = { fg = "#ffc4c4" },
          -- NeoTreeWinSeparator = { fg = "#ffc4c4" },
          WinSeparator = { style = { "bold" } },
          NeoTreeWinSeparator = { style = { "bold" } },
          --NeoTreeFileNameOpened = {
          --  fg = "#ffcc00", -- 设置前景色为黄色
          --  --  fg = "",
          --  -- bg = "#282828", -- 设置背景色
          --  bg = "#e35e4f",
          --  bold = true, -- 设置加粗
          --},
          --WinSeparator = { fg = colors.peach },
          --NeoTreeWinSeparator = { fg = colors.peach },
          -- 当前文件高亮
          NeoTreeFileNameOpened = {
            fg = colors.peach,
            bg = colors.surface0,
            bold = true,
          },

          -- 光标所在行高亮（Neo-tree 专用）
          NeoTreeCursorLine = {
            bg = colors.surface1,
          },
          -- 如果你想让普通窗口也有 CursorLine 背景
          CursorLine = {
            bg = colors.surface1,
          },
          --NeoTreeNormal = {
          --  bg = colors.base,
          --},
          --NeoTreeNormalNC = {
          --  bg = colors.base,
          --},
        }
      end
    end,
    --event = "VeryLazy",
  },
  {
    "LazyVim/LazyVim",
    opts = function(_, opts)
      opts.colorscheme = "catppuccin"
    end,
  },
}
