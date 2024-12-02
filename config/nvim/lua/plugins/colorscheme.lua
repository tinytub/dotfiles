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
      --opts.integrations = {
      --  --fidget = true,
      --  --ts_rainbow = true,
      --  --mason = true,
      --  --gitgutter = true,
      --  --symbols_outline = true,
      --  --dashboard = false,
      --  --markdown = true,
      --  --dap = {
      --  --  enabled = true,
      --  --  enabled_ui = true,
      --  --},
      --  snacks = true,
      --  symbols_outline = true,
      --  mason = true,
      --  aerial = true,
      --  alpha = true,
      --  cmp = true,
      --  dashboard = true,
      --  flash = true,
      --  gitsigns = true,
      --  headlines = true,
      --  illuminate = true,
      --  indent_blankline = { enabled = true },
      --  leap = true,
      --  lsp_trouble = true,
      --  mini = true,
      --  markdown = true,
      --  native_lsp = {
      --    enabled = true,
      --    underlines = {
      --      errors = { "undercurl" },
      --      warnings = { "undercurl" },
      --      hints = { "undercurl" },
      --      information = { "undercurl" },
      --    },
      --    inlay_hints = {
      --      background = true,
      --    },
      --  },
      --  navic = { enabled = true, custom_bg = "lualine" },
      --  neotest = true,
      --  noice = true,
      --  notify = true,
      --  neotree = true,
      --  semantic_tokens = true,
      --  telescope = true,
      --  treesitter = true,
      --  treesitter_context = true,
      --  which_key = true,
      --}
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
