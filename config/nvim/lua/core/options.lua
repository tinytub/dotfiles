CONFIG_PATH = vim.fn.stdpath("config")
DATA_PATH = vim.fn.stdpath("data")
CACHE_PATH = vim.fn.stdpath("cache")

local opt = vim.opt
local g = vim.g

--Defer loading shada until after startup_
vim.schedule(function()
  vim.opt.shadafile = vim.fn.stdpath(g.vim_version > 7 and "state" or "data") .. "/shada/main.shada"
  vim.cmd([[ silent! rsh ]])
end)

-- use filetype.lua instead of filetype.vim
g.vim_version = vim.version().minor
if g.vim_version < 8 then
  g.did_load_filetypes = 0
  g.do_filetype_lua = 1
end
g.toggle_theme_icon = "  "
g.theme_switcher_loaded = false


opt.laststatus = 3
opt.showmode = false

opt.title = true
opt.clipboard = "unnamedplus"
--opt.cmdheight = 0
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
opt.mouse = ""

-- Numbers
opt.number = true
opt.numberwidth = 2
opt.relativenumber = false
opt.ruler = false

-- disable nvim intro
opt.shortmess:append("sI")

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

-- disable some builtin vim plugins
local disabled_built_ins = {
  "2html_plugin",
  "getscript",
  "getscriptPlugin",
  "gzip",
  "logipat",
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "matchit",
  "tar",
  "tarPlugin",
  "rrhelper",
  "spellfile_plugin",
  "vimball",
  "vimballPlugin",
  "zip",
  "zipPlugin",
  "tutor",
  "rplugin",
  "syntax",
  "synmenu",
  "optwin",
  "compiler",
  "bugreport",
  "ftplugin",
}

for _, plugin in pairs(disabled_built_ins) do
  g["loaded_" .. plugin] = 1
end

local default_providers = {
  "node",
  "perl",
  "python3",
  "ruby",
}

for _, provider in ipairs(default_providers) do
  vim.g["loaded_" .. provider .. "_provider"] = 0
end
