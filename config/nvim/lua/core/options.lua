CONFIG_PATH = vim.fn.stdpath("config")
DATA_PATH = vim.fn.stdpath("data")
CACHE_PATH = vim.fn.stdpath("cache")

local opt = vim.opt
local g = vim.g

-- use filetype.lua instead of filetype.vim
g.toggle_theme_icon = "  "
g.theme_switcher_loaded = false


opt.laststatus = 3
opt.showmode = false

opt.clipboard = "unnamedplus"
--opt.cmdheight = 0 -- 控制cmd 高度, 0 会隐藏
opt.cul = true -- cursor line

-- Indenting
opt.expandtab = true
opt.shiftwidth = 4
opt.smartindent = true

opt.fillchars = { eob = " " }
--opt.listchars = "tab:»·,nbsp:+, trail:·, extends:→,precedes:←";
--opt.listchars = { tab = " " }

opt.hidden = true
opt.ignorecase = true
opt.smartcase = true
opt.mouse = "a"
--opt.mousemodel = 'extend'
--opt.mouse = ""

-- Numbers
opt.number = true
opt.numberwidth = 2
opt.relativenumber = false
opt.ruler = false

-- disable nvim intro
opt.shortmess:append("sI")

--opt.signcolumn = "number"
opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.tabstop = 4
opt.termguicolors = true
opt.timeoutlen = 400
opt.undofile = true

opt.scrolloff = 2
opt.sidescrolloff = 5

opt.showcmd = true

opt.confirm = true

-- interval for writing swap file to disk, also used by gitsigns
opt.updatetime = 250

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append("<>[]hl")

--opt.guifont = "Hack:h14"

g.mapleader = " "


-- disable some default providers
for _, provider in ipairs { "node", "perl", "python3", "ruby" } do
  vim.g["loaded_" .. provider .. "_provider"] = 0
end
