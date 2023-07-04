local catppuccin = require("catppuccin")

--catppuccin.setup({
--  flavour = "macchiato", -- latte, frappe, macchiato, mocha
--  background = {
--    -- :h background
--    light = "latte",
--    dark = "macchiato",
--    --dark = "mocha",
--  },
----  transparent_background = true,
--  compile = {
--    enabled = true,
--    path = vim.fn.stdpath("cache") .. "/catppuccin",
--  },
--  integrations = {
--    fidget = true,
--    treesitter = true,
--    treesitter_context = true,
--    ts_rainbow = true,
--    cmp = true,
--    mason = true,
--    gitgutter = true,
--    gitsigns = true,
--    lsp_trouble = true,
--    --neogit = true,
--    symbols_outline = true,
--    telescope = true,
--    dashboard = false,
--    markdown = true,
--    notify = true,
--    indent_blankline = {
--      enabled = true,
--      colored_indent_levels = true,
--    },
--    dap = {
--      enabled = true,
--      enabled_ui = true,
--    },
--    native_lsp = {
--      enabled = true,
--      virtual_text = {
--        errors = { "italic" },
--        hints = { "italic" },
--        warnings = { "italic" },
--        information = { "italic" },
--      },
--      underlines = {
--        errors = { "underline" },
--        hints = { "underline" },
--        warnings = { "underline" },
--        information = { "underline" },
--      },
--    },
--    neotree = {
--      enabled = true,
--      show_root = true,
--      transparent_panel = false,
--    }
--  },
--})


catppuccin.setup({
  flavour = "macchiato", -- latte, frappe, macchiato, mocha
  background = {
    -- :h background
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
    alpha = true,
    cmp = true,
    gitsigns = true,
    illuminate = true,
    indent_blankline = { enabled = true },
    lsp_trouble = true,
    mini = true,
    native_lsp = {
      enabled = true,
      --virtual_text = {
      --  errors = { "italic" },
      --  hints = { "italic" },
      --  warnings = { "italic" },
      --  information = { "italic" },
      --},
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
    navic = { enabled = true },
    neotest = true,
    noice = true,
    notify = true,
    neotree = true,
    semantic_tokens = true,
    telescope = true,
    treesitter = true,
    which_key = true,
  },
})
