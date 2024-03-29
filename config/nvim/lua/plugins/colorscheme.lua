return {

  {
    -- this repo has break some base46 colors
    -- "CanKolay3499/base46",
    -- "jayden-chan/base46.nvim",
    "tinytub/base46",
    dependencies = "plenary.nvim",
    config = function()
      local base46 = require("base46")
      --base46.setup({ theme = "everforest", custom_highlights = "colors.themes.everforest" })
      base46.setup({ theme = "everforest" })
    end,
    enabled = false,
  },

  -- tokyonight
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      style = "moon",
      sidebars = {
        "qf",
        "vista_kind",
        "terminal",
        "spectre_panel",
        "startuptime",
        "Outline",
      },
    },
  },

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
    opts = {
      flavour = "macchiato", -- latte, frappe, macchiato, mocha
      background = {
        -- :h background
        light = "latte",
        dark = "macchiato",
        --dark = "mocha",
      },
      transparent_background = false,
      no_italic = true,
      no_bold = false,
      compile = {
        enabled = true,
        path = vim.fn.stdpath("cache") .. "/catppuccin",
      },
      integrations = {
        --fidget = true,
        --treesitter_context = true,
        --ts_rainbow = true,
        --mason = true,
        --gitgutter = true,
        --symbols_outline = true,
        --dashboard = false,
        --markdown = true,
        --dap = {
        --  enabled = true,
        --  enabled_ui = true,
        --},

        symbols_outline = true,
        treesitter_context = true,
        mason = true,
        aerial = true,
        alpha = true,
        cmp = true,
        dashboard = true,
        flash = true,
        gitsigns = true,
        headlines = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        leap = true,
        lsp_trouble = true,
        mini = true,
        markdown = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
          inlay_hints = {
            background = true,
          },
        },
        navic = { enabled = true, custom_bg = "lualine" },
        neotest = true,
        noice = true,
        notify = true,
        neotree = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        which_key = true,
      },
      color_overrides = {
        mocha = {
          -- I don't think these colours are pastel enough by default!
          peach = "#fcc6a7",
          green = "#d2fac5",
        },
      },
    },
    --event = "VeryLazy",
  },

  {
    "sainnhe/everforest",
    config = function()
      require("colors").init()
    end,
    enabled = false,
  },

  {
    "rebelot/kanagawa.nvim",
    config = function()
      require("colors").init()
    end,
    enabled = false,
  },

  --{
  --	"sainnhe/gruvbox-material",
  --	config = function()
  --		require("colors").init()
  --	end,
  --	enabled = false,
  --},
}
