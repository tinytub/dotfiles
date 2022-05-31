-- breaking change: moved highlight stuff to base16 repo | rewrote whole…
-- https://github.com/NvChad/NvChad/commit/02d545cd42ccb4d8bcb6120c18f8d8d27958a1e0

--local colors = require("colors").get()
local colors = require('base46').get_colors('base_30')

local black = colors.black
local black2 = colors.black2
local blue = colors.blue
local darker_black = colors.darker_black
local folder_bg = colors.folder_bg
local green = colors.green
local grey = colors.grey
local grey_fg = colors.grey_fg
local light_grey = colors.light_grey
local line = colors.line
local nord_blue = colors.nord_blue
local one_bg = colors.one_bg
local one_bg2 = colors.one_bg2
local pmenu_bg = colors.pmenu_bg
local purple = colors.purple
local red = colors.red
local white = colors.white
local yellow = colors.yellow
local orange = colors.orange

local transparency = false

-- highlight groups & colors
local hl_cols = {

   Comment = { fg = grey_fg },

   -- line numbers
   CursorLineNr = { fg = white },
   LineNr = { fg = grey },

   -- those ugly ~'s
   EndOfBuffer = { fg = black },

   -- floating windows like whichkey_window
   --FloatBorder = { fg = blue },
   --NormalFloat = { bg = darker_black },

   -- Pmenu i.e completion menu
   Pmenu = { bg = one_bg },
   PmenuSbar = { bg = one_bg2 },
   PmenuSel = { bg = pmenu_bg, fg = black },
   PmenuThumb = { bg = nord_blue },

   -- nvim cmp
   CmpItemAbbr = { fg = white },
   CmpItemAbbrMatch = { fg = white },
   CmpItemKind = { fg = white },
   CmpItemMenu = { fg = white },

   NvimInternalError = { fg = red },
   WinSeparator = { fg = one_bg2 },

   -- Dashboard i.e alpha.nvim
   AlphaHeader = { fg = grey_fg },
   AlphaButtons = { fg = light_grey },

   -- Gitsigns.nvim
   DiffAdd = {
      fg = green,
      bg = "NONE",
   },

   DiffChange = {
      fg = blue,
      bg = "NONE",
   },

   DiffChangeDelete = {
      fg = red,
      bg = "NONE",
   },

   DiffModified = {
      fg = orange,
      bg = "NONE",
   },

   DiffDelete = {
      fg = red,
      bg = "NONE",
   },

   -- Indent blankline
   IndentBlanklineChar = { fg = line },
   IndentBlanklineSpaceChar = { fg = line },

   -- Lsp Diagnostics
   DiagnosticHint = { fg = purple },
   DiagnosticError = { fg = red },
   DiagnosticWarn = { fg = yellow },
   DiagnosticInformation = { fg = green },

   -- NvimTree
   NvimTreeEmptyFolderName = { fg = folder_bg },
   NvimTreeEndOfBuffer = { fg = darker_black },
   NvimTreeFolderIcon = { fg = folder_bg },
   NvimTreeFolderName = { fg = folder_bg },
   NvimTreeGitDirty = { fg = red },
   NvimTreeIndentMarker = { fg = one_bg2 },
   NvimTreeNormal = { bg = darker_black },
   NvimTreeNormalNC = { bg = darker_black },
   NvimTreeOpenedFolderName = { fg = folder_bg },

   NvimTreeWinSeparator = {
      fg = darker_black,
      bg = darker_black,
   },

   NvimTreeWindowPicker = {
      fg = red,
      bg = black2,
   },

   -- Telescope
   TelescopeBorder = {
      --fg = purple,
      fg = colors.darker_black,
      bg = colors.darker_black,
   },

   TelescopePromptBorder = {
      --fg = purple,
      fg = colors.black2,
      bg = colors.black2,
   },

   TelescopePromptNormal = {
      fg = colors.white,
      bg = colors.black2,
   },

   TelescopePromptPrefix = {
      fg = colors.red,
      bg = colors.black2,
   },

   TelescopeNormal = { bg = colors.darker_black },

   TelescopePreviewTitle = {
      fg = colors.black,
      bg = colors.green,
   },

   TelescopePromptTitle = {
      fg = colors.black,
      bg = colors.red,
   },

   TelescopeResultsTitle = {
      fg = colors.darker_black,
      bg = colors.darker_black,
   },

   TelescopeSelection = { bg = colors.black2 },

   -- Feline
   Feline = {
      fg = colors.grey_fg2,
      bg = colors.statusline_bg,
   },

   FelineIcon = {
      fg = colors.statusline_bg,
      bg = colors.nord_blue,
   },

   FelineIconSeparator = {
      fg = colors.nord_blue,
      bg = colors.lightbg,
   },

   FelineFileName = {
      fg = colors.white,
      bg = colors.lightbg,
   },

   FelineFileName_Separator = {
      fg = colors.lightbg,
      bg = colors.lightbg2,
   },

   FelineDirName = {
      fg = colors.light_grey,
      bg = colors.lightbg2,
   },

   FelineDirName_Separator = {
      fg = colors.lightbg2,
      bg = colors.statusline_bg,
   },

   Feline_diffIcons = {
      fg = colors.grey_fg2,
      bg = colors.statusline_bg,
   },

   -- LSP

   Feline_lspError = {
      fg = colors.red,
      bg = colors.statusline_bg,
   },

   Feline_lspWarning = {
      fg = colors.yellow,
      bg = colors.statusline_bg,
   },

   Feline_LspHints = {
      fg = colors.purple,
      bg = colors.statusline_bg,
   },

   Feline_LspInfo = {
      fg = colors.green,
      bg = colors.statusline_bg,
   },

   Feline_LspIcon = {
      fg = colors.nord_blue,
      bg = colors.statusline_bg,
   },

   Feline_LspProgress = {
      fg = colors.green,
      bg = colors.statusline_bg,
   },

   -- MODES

   Feline_NormalMode = {
      fg = colors.red,
      bg = colors.one_bg,
   },

   Feline_InsertMode = {
      fg = colors.dark_purple,
      bg = colors.one_bg,
   },

   Feline_TerminalMode = {
      fg = colors.green,
      bg = colors.one_bg,
   },

   Feline_VisualMode = {
      fg = colors.cyan,
      bg = colors.one_bg,
   },

   Feline_ReplaceMode = {
      fg = colors.orange,
      bg = colors.one_bg,
   },

   Feline_ConfirmMode = {
      fg = colors.teal,
      bg = colors.one_bg,
   },

   Feline_CommandMode = {
      fg = colors.pink,
      bg = colors.one_bg,
   },

   Feline_SelectMode = {
      fg = colors.nord_blue,
      bg = colors.one_bg,
   },

   Feline_EmptySpace = {
      fg = colors.one_bg2,
      bg = colors.statusline_bg,
   },

   Feline_CurrentLine = {
      fg = colors.green,
      bg = colors.one_bg,
   },

   Feline_PositionIcon = {
      fg = colors.black,
      bg = colors.green,
   },

   Feline_PositionSeparator = {
      fg = colors.green,
      bg = colors.grey,
   },

   LspReferenceText = { fg = darker_black, bg = white },
   LspReferenceRead = { fg = darker_black, bg = white },
   LspReferenceWrite = { fg = darker_black, bg = white },
}

if transparency then
   local hl_groups = {
      "NormalFloat",
      "Normal",
      "Folded",
      "NvimTreeNormal",
      "NvimTreeNormalNC",
      "TelescopeNormal",
      "TelescopePrompt",
      "TelescopeResults",
      "TelescopeBorder",
      "TelescopePromptBorder",
      "TelescopePromptNormal",
      "TelescopePromptPrefix",
   }

   for index, _ in ipairs(hl_groups) do
      hl_cols[hl_groups[index]] = {
         bg = "NONE",
      }
   end

   hl_cols.NvimTreeWinSeparator = {
      fg = grey,
      bg = "NONE",
   }

   hl_cols.TelescopeResultsTitle = {
      fg = black,
      bg = blue,
   }
end

for hl, col in pairs(hl_cols) do
   vim.api.nvim_set_hl(0, hl, col)
end

