local catppuccin = require("catppuccin")

catppuccin.setup({
  flavour = "macchiato", -- latte, frappe, macchiato, mocha
  background = { -- :h background
    light = "latte",
    dark = "macchiato",
    --dark = "mocha",
  },
  transparent_background = true,
  compile = {
    enabled = true,
    path = vim.fn.stdpath("cache") .. "/catppuccin",
  },
  integrations = {
    fidget = true,
    treesitter = true,
    treesitter_context = true,
    ts_rainbow = true,
    cmp = true,
    mason = true,
    gitgutter = true,
    gitsigns = true,
    lsp_trouble = true,
    --neogit = true,
    symbols_outline = true,
    telescope = true,
    nvimtree = true, --false? neotree
    dashboard = false,
    markdown = true,
    notify = true,
    indent_blankline = {
      enabled = true,
      colored_indent_levels = true,
    },
    dap = {
      enabled = true,
      enabled_ui = true,
    },
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = { "italic" },
        hints = { "italic" },
        warnings = { "italic" },
        information = { "italic" },
      },
      underlines = {
        errors = { "underline" },
        hints = { "underline" },
        warnings = { "underline" },
        information = { "underline" },
      },
    },
    neotree = {
      enabled = true,
      show_root = true,
      transparent_panel = false,
    }
  },
})
