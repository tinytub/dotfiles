local M = {}
local catppuccin = require("catppuccin")
local mocha = require("catppuccin.palettes").get_palette("mocha")


vim.cmd("hi def GitSignsCurrentLineBlame guifg=" .. mocha.overlay2 .. " ctermfg=244")


M.overrides = {
  colors = {},
  highlights = {
    all = {
      CmpItemAbbrMatch = { fg = mocha.blue },
      CmpItemAbbrMatchFuzzy = { fg = mocha.blue },
      Pmenu = { bg = mocha.crust },
      PmenuSel = { fg = mocha.sapphire },
      PmenuSbar = { bg = mocha.base }, -- Popup menu: scrollbar.
      PmenuThumb = { bg = mocha.surface0 }, -- Popup menu: Thumb of the scrollbar.
      VertSplit = { fg = mocha.surface0 },
      NonText = { fg = mocha.surface0 },
      FidgetTitle = { fg = mocha.blue, bg = mocha.none },
      FidgetTask = { fg = mocha.blue, bg = mocha.none },
    }
  }
}

function M.setup()
  catppuccin.setup({
    transparent_background = true,
    term_colors = false,
    compile = {
      enabled = false,
      path = vim.fn.stdpath("cache") .. "/catppuccin",
    },
    dim_inactive = {
      enabled = false,
      shade = "dark",
      percentage = 0.15,
    },
    styles = {
      comments = { "italic" },
      conditionals = { "italic" },
      loops = {},
      functions = {},
      keywords = { "italic" },
      strings = {},
      variables = { "italic" },
      numbers = {},
      booleans = {},
      properties = {},
      types = {},
      operators = {},
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
    color_overrides = M.overrides.colors,
    highlight_overrides = M.overrides.highlights,
  })
end

return M
