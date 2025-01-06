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
      opts.flavour = "macchiato" -- latte, frappe, macchiato, mocha
      opts.background = {
        -- :h background
        light = "latte",
        dark = "macchiato",
        --dark = "mocha",
      }
      opts.transparent_background = true
      opts.no_italic = true
      opts.no_bold = false
      opts.compile = {
        enabled = true,
        path = vim.fn.stdpath("cache") .. "/catppuccin",
      }
      opts.color_overrides = {
        mocha = {
          -- I don't think these colours are pastel enough by default!
          peach = "#fcc6a7",
          green = "#d2fac5",
        },
      }
      opts.custom_highlights = function(colors)
        return {
          --WinSeparator = { fg = colors.yellow, style = { "bold" } },
          --WinSeparator = { fg = "#ffc4c4" },
          --NeoTreeWinSeparator = { fg = "#ffc4c4" },

          WinSeparator = { style = { "bold" } },
          NeoTreeWinSeparator = { style = { "bold" } },

          --WinSeparator = { fg = colors.peach },
          --NeoTreeWinSeparator = { fg = colors.peach },
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
