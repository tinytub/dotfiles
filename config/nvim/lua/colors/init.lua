local M = {}
local vim = vim

vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato mocha
local colors = require("catppuccin.palettes").get_palette()

function M.get_colors()
  colors.diff = { -- git and native diffs
    add = "green",
    change = "#2B5B77",
    delete = "red",
    text = colors.blue,
    conflict = colors.magenta,
  }
  colors.magenta = "#c678dd"
  colors.gray = "#2a2e36"
  return colors
end

M.theme_colors = colors

M.mode_color = {
  --n = 'DarkGoldenrod2',
  n = colors.green,
  i = colors.blue,
  v = 'gray',
  [""] = 'gray',
  V = 'gray',
  c = 'plum3',
  no = 'DarkGoldenrod2',
  s = 'SkyBlue2',
  S = 'SkyBlue2',
  [""] = 'SkyBlue2',
  ic = 'chartreuse3',
  R = 'purple',
  Rv = 'purple',
  cv = 'plum3',
  ce = 'plum3',
  r = 'chocolate',
  rm = 'chocolate',
  ["r?"] = 'chocolate',
  ["!"] = 'plum3',
  t = 'plum3'
}

M.setup = function()
  vim.api.nvim_command [[syntax on]]
  if vim.fn.has('termguicolors') == 1 then
    vim.cmd.set("termguicolors")
  end

  require("colors.catppuccin").setup()
  vim.cmd.colorscheme("catppuccin")
end

return M


--local vim = vim
--local g = vim.g
--
--local M = {}
--
--
---- if theme given, load given theme if given, otherwise nvchad_theme
----M.init = function(theme)
----   if not theme then
----      theme = "gruvbox"
----   end
----
----   -- set the global theme, used at various places like theme switcher, highlights
----   local present, base16 = pcall(require, "base16")
----
----   if present then
----      -- first load the base16 theme
----      base16(base16.themes(theme), true)
----
----      -- unload to force reload
----      package.loaded["colors.highlights" or false] = nil
----      -- then load the highlights
----      require "colors.highlights"
----   else
----      return false
----   end
----end
--
--M.init = function()
--  M.kanagawa()
--
--  package.loaded["colors.highlights" or false] = nil
--  -- then load the highlights
--  require "colors.highlights"
--end
--
--
---- returns a table of colors for givem or current theme
--M.get = function(theme)
--  if not theme then
--    theme = "gruvbox"
--  end
--
--  --return require("hl_themes." .. theme)
--  return require("colors.themes." .. theme)
--end
--
--
--function M.get_color(hlgroup, attr)
--  return vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID(hlgroup)), attr, 'gui')
--  -- return vim.api.nvim_get_hl_by_name(hlgroup, true)[attr]
--end
--
--function M.kanagawa()
--  vim.cmd([[
--        set background=dark
--        "let g:everforest_background = 'hard'
--        "colorscheme everforest
--        colorscheme kanagawa
--    ]])
--end
--
--function M.gruvbox()
--  g.gruvbox_material_background = 'medium'
--  g.gruvbox_material_palette = 'original'
--  g.gruvbox_material_enable_bold = 1
--  g.gruvbox_material_enable_italic = 1
--  g.gruvbox_material_sign_column_background = 'none'
--  g.gruvbox_material_diagnostic_virtual_text = 'colored'
--  vim.cmd([[
--        let g:gruvbox_material_statusline_style = 'original'
--        colorscheme gruvbox-material
--    ]])
--end
--
--function M.tokyonight()
--  g.tokyonight_style = "night"
--  g.tokyonight_sidebars = {} -- { "qf", "vista", "terminal", "packer", "NvimTree" , 'Trouble', 'tagbar' }
--  vim.cmd('colorscheme tokyonight') -- this has to be specified last
--  -- vim.cmd('hi VertSplit guifg=' .. require'colors'.get_color('Visual', 'bg')) -- .. ' guibg=' .. get_color('StatusLine', 'bg'))
--end
--
--return M
