CONFIG_PATH = vim.fn.stdpath("config")
DATA_PATH = vim.fn.stdpath("data")
CACHE_PATH = vim.fn.stdpath("cache")

local opt = vim.opt
local g = vim.g

--Defer loading shada until after startup_
vim.schedule(function()
    vim.opt.shadafile = vim.fn.expand("$HOME") .. "/.local/share/nvim/shada/main.shada"
    vim.cmd([[ silent! rsh ]])
end)

-- use filetype.lua instead of filetype.vim
g.did_load_filetypes = 0
g.do_filetype_lua = 1

opt.laststatus = 3
opt.title = true
opt.clipboard = "unnamedplus"
opt.cmdheight = 1
opt.cul = true -- cursor line

-- Indentline
opt.expandtab = true
opt.shiftwidth = 4
opt.smartindent = true

-- disable tilde on end of buffer: https://github.com/  neovim/neovim/pull/8546#issuecomment-643643758
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
}

for _, plugin in pairs(disabled_built_ins) do
    g["loaded_" .. plugin] = 1
end
