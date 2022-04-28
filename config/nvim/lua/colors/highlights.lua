local cmd = vim.cmd

local colors = require("colors").get()

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
local one_bg3 = colors.one_bg3

--local ui = require("core.utils").load_config().ui
local transparency = false

-- Define bg color
-- @param group Group
-- @param color Color
local function bg(group, color)
   cmd("hi " .. group .. " guibg=" .. color)
end

-- Define fg color
-- @param group Group
-- @param color Color
local function fg(group, color)
   cmd("hi " .. group .. " guifg=" .. color)
end

-- Define bg and fg color
-- @param group Group
-- @param fgcol Fg Color
-- @param bgcol Bg Color
local function fg_bg(group, fgcol, bgcol)
   cmd("hi " .. group .. " guifg=" .. fgcol .. " guibg=" .. bgcol)
end

-- Comments
--if ui.italic_comments then
--   fg("Comment", grey_fg .. " gui=italic")
--else
--   fg("Comment", grey_fg)
--end

-- Disable cusror line
cmd "hi clear CursorLine"
-- Line number
fg("cursorlinenr", white)

-- same it bg, so it doesn't appear
fg("EndOfBuffer", black)

-- For floating windows
fg("FloatBorder", blue)
bg("NormalFloat", darker_black)

-- Pmenu
bg("Pmenu", one_bg)
bg("PmenuSbar", one_bg2)
bg("PmenuSel", pmenu_bg)
bg("PmenuThumb", nord_blue)

fg("CmpItemAbbr", white)
fg("CmpItemAbbrMatch", blue)
fg("CmpItemKind", white)
fg("CmpItemMenu", white)

-- cmp highlight
-- gruvbox
vim.cmd [[highlight! link CmpItemAbbrMatchFuzzy Aqua]]
vim.cmd [[highlight! link CmpItemKindText Fg]]
vim.cmd [[highlight! link CmpItemKindMethod Purple]]
vim.cmd [[highlight! link CmpItemKindFunction Purple]]
vim.cmd [[highlight! link CmpItemKindConstructor Green]]
vim.cmd [[highlight! link CmpItemKindField Aqua]]
vim.cmd [[highlight! link CmpItemKindVariable Blue]]
vim.cmd [[highlight! link CmpItemKindClass Green]]
vim.cmd [[highlight! link CmpItemKindInterface Green]]
vim.cmd [[highlight! link CmpItemKindValue Orange]]
vim.cmd [[highlight! link CmpItemKindKeyword Keyword]]
vim.cmd [[highlight! link CmpItemKindSnippet Red]]
vim.cmd [[highlight! link CmpItemKindFile Orange]]
vim.cmd [[highlight! link CmpItemKindFolder Orange]]

-- misc

-- inactive statuslines as thin lines
--fg("StatusLineNC", one_bg2 .. " gui=underline")
fg("StatusLineNC", blue .. " gui=underline")

fg("LineNr", grey)
fg("NvimInternalError", red)
fg("VertSplit", one_bg2)

--if ui.transparency then
if transparency then
   bg("Normal", "NONE")
   bg("NvimTreeNormalNC", "NONE")
   bg("Folded", "NONE")
   fg("Folded", "NONE")
end
fg("Comment", grey_fg)

-- [[ Plugin Highlights

-- Dashboard
fg("AlphaHeader", grey_fg)
fg("AlphaButtons", light_grey)

-- Git signs
--cmd("hi clear SignColumn")
--fg_bg("DiffAdd", blue, "NONE")
--fg_bg("DiffChange", grey_fg, "NONE")
bg("SignColumn", "NONE")
fg_bg("DiffAdd", green, "NONE")
fg_bg("DiffChange", blue, "NONE")
fg_bg("DiffChangeDelete", red, "NONE")
fg_bg("DiffModified", red, "NONE")
fg_bg("DiffDelete", red, "NONE")

-- Indent blankline plugin
fg("IndentBlanklineChar", line)
fg("IndentBlanklineSpaceChar", line)

-- Lsp diagnostics

fg("DiagnosticHint", purple)
fg("DiagnosticError", red)
fg("DiagnosticWarn", yellow)
fg("DiagnosticInformation", green)

-- NvimTree
fg("NvimTreeEmptyFolderName", folder_bg)
fg("NvimTreeEndOfBuffer", darker_black)
fg("NvimTreeFolderIcon", folder_bg)
fg("NvimTreeFolderName", folder_bg)
fg("NvimTreeGitDirty", red)
fg("NvimTreeIndentMarker", one_bg2)
bg("NvimTreeNormal", darker_black)
bg("NvimTreeNormalNC", darker_black)
fg("NvimTreeOpenedFolderName", folder_bg)
--fg("NvimTreeRootFolder", red .. " gui=underline") -- enable underline for root folder in nvim tree
fg_bg("NvimTreeStatuslineNc", darker_black, darker_black)
fg_bg("NvimTreeVertSplit", darker_black, darker_black)
fg_bg("NvimTreeWindowPicker", red, black2)

-- Disable some highlight in nvim tree if transparency enabled
--if ui.transparency then
if transparency then
   bg("NvimTreeNormal", "NONE")
   bg("NvimTreeStatusLineNC", "NONE")
   fg_bg("NvimTreeVertSplit", grey, "NONE")
end


-- Telescope
-- 边框颜色
fg_bg("TelescopeBorder", purple, darker_black)
fg_bg("TelescopePromptBorder", purple, black2)
--fg_bg("TelescopeBorder", darker_black, darker_black)
--fg_bg("TelescopePromptBorder", black2, black2)

fg_bg("TelescopePromptNormal", white, black2)
fg_bg("TelescopePromptPrefix", red, black2)

bg("TelescopeNormal", darker_black)

fg_bg("TelescopePreviewTitle", black, green)
fg_bg("TelescopePromptTitle", black, red)
fg_bg("TelescopeResultsTitle", darker_black, darker_black)

bg("TelescopeSelection", black2)

---- gray
--vim.cmd [[highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080]]
---- blue
--vim.cmd [[highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6]]
--vim.cmd [[highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6]]
---- light blue
--vim.cmd [[highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE]]
--vim.cmd [[highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE]]
--vim.cmd [[highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE]]
---- pink
--vim.cmd [[highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0]]
--vim.cmd [[highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0]]
---- front
--vim.cmd [[highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4]]
--vim.cmd [[highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4]]
--vim.cmd [[highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4]]
