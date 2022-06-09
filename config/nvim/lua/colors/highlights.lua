-- breaking change: moved highlight stuff to base16 repo | rewrote whole…
-- https://github.com/NvChad/NvChad/commit/02d545cd42ccb4d8bcb6120c18f8d8d27958a1e0

--local colors = require("colors").get()
local colors = require("base46").get_colors("base_30")

-- colors from https://github.com/NvChad/base46/blob/a8ac8880e2b3f962e225af4399a5d9ffa5701cde/lua/hl_themes/everforest.lua
--local colors = {
--    white = "#D3C6AA",
--    darker_black = "#272f35",
--    black = "#2b3339", --  nvim bg
--    black2 = "#323a40",
--    one_bg = "#363e44",
--    one_bg2 = "#363e44",
--    one_bg3 = "#3a4248",
--    grey = "#4e565c",
--    grey_fg = "#545c62",
--    grey_fg2 = "#626a70",
--    light_grey = "#656d73",
--    red = "#e67e80",
--    baby_pink = "#ce8196",
--    pink = "#ff75a0",
--    line = "#3a4248", -- for lines like vertsplit
--    green = "#83c092",
--    vibrant_green = "#a7c080",
--    nord_blue = "#78b4ac",
--    blue = "#7393b3",
--    yellow = "#dbbc7f",
--    sun = "#d1b171",
--    purple = "#b4bbc8",
--    dark_purple = "#d699b6",
--    teal = "#69a59d",
--    orange = "#e69875",
--    cyan = "#95d1c9",
--    statusline_bg = "#2e363c",
--    lightbg = "#3d454b",
--    lightbg2 = "#333b41",
--    pmenu_bg = "#83c092",
--    folder_bg = "#7393b3",
--}

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

--local transparency = false

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

    LspReferenceText = { fg = darker_black, bg = white },
    LspReferenceRead = { fg = darker_black, bg = white },
    LspReferenceWrite = { fg = darker_black, bg = white },

    QuickScopePrimary = {
        fg = colors.orange,
        --link = "IncSearch",
        --bg = colors.black,
    },
    QuickScopeSecondary = {
        fg = colors.blue,
        --link = "Search",
        --bg = colors.black,
    },
}

for hl, col in pairs(hl_cols) do
    vim.api.nvim_set_hl(0, hl, col)
end
