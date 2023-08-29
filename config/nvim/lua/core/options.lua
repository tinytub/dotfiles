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
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 3           -- Hide * markup for bold and italic

opt.formatoptions = "jcroqlnt" -- tcqj

--opt.cmdheight = 0 -- 控制cmd 高度, 0 会隐藏
opt.cul = true -- cursor line

-- Indenting
opt.expandtab = true
opt.shiftwidth = 4
opt.smartindent = true

vim.opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.foldcolumn = "0"

vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
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
opt.pumblend = 10  -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup

-- disable nvim intro
--opt.shortmess:append("sI")
opt.shortmess:append({ W = true, I = true, c = true, s = true })

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

--opt.list = true -- Show some invisible characters (tabs...

opt.confirm = true
--opt.cursorline = true

-- interval for writing swap file to disk, also used by gitsigns
opt.updatetime = 250

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append("<>[]hl")

--opt.guifont = "Hack:h14"
if vim.fn.has("nvim-0.9.0") == 1 then
  opt.splitkeep = "screen"
  opt.shortmess:append({ C = true })
end

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

g.mapleader = " "
g.maplocalleader = "\\"


-- disable some default providers
for _, provider in ipairs { "node", "perl", "python3", "ruby" } do
  vim.g["loaded_" .. provider .. "_provider"] = 0
end
