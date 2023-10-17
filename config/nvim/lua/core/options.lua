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
opt.conceallevel = 3 -- Hide * markup for bold and italic

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

-- Enable LazyVim auto format
vim.g.autoformat = true

-- LazyVim root dir detection
-- Each entry can be:
-- * the name of a detector function like `lsp` or `cwd`
-- * a pattern or array of patterns like `.git` or `lua`.
-- * a function with signature `function(buf) -> string|string[]`
vim.g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }

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
opt.pumblend = 10 -- Popup blend
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

opt.scrolloff = 4
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" }
opt.sidescrolloff = 5

opt.showcmd = true

--opt.list = true -- Show some invisible characters (tabs...

opt.confirm = true
--opt.cursorline = true

-- interval for writing swap file to disk, also used by gitsigns
opt.updatetime = 250
opt.virtualedit = "block"

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append("<>[]hl")

opt.winminwidth = 5 -- Minimum window width
opt.wrap = false -- Disable line wrap
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  -- fold = "⸱",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}

--opt.guifont = "Hack:h14"
if vim.fn.has("nvim-0.9.0") == 1 then
  opt.splitkeep = "screen"
  opt.shortmess:append({ C = true })
end

if vim.fn.has("nvim-0.10") == 1 then
  opt.smoothscroll = true
end
-- Folding
vim.opt.foldlevel = 99
vim.opt.foldtext = "v:lua.require'utils.ui'.foldtext()"

if vim.fn.has("nvim-0.9.0") == 1 then
  vim.opt.statuscolumn = [[%!v:lua.require'utils.ui'.statuscolumn()]]
end

-- HACK: causes freezes on <= 0.9, so only enable on >= 0.10 for now
if vim.fn.has("nvim-0.10") == 1 then
  vim.opt.foldmethod = "expr"
  vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
else
  vim.opt.foldmethod = "indent"
end

vim.o.formatexpr = "v:lua.require'lazyvim.util'.format.formatexpr()"

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

g.mapleader = " "
g.maplocalleader = "\\"

-- disable some default providers
for _, provider in ipairs({ "node", "perl", "python3", "ruby" }) do
  vim.g["loaded_" .. provider .. "_provider"] = 0
end
