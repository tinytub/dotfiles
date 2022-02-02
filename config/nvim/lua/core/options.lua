CONFIG_PATH = vim.fn.stdpath('config')
DATA_PATH = vim.fn.stdpath('data')
CACHE_PATH = vim.fn.stdpath('cache')

local opt = vim.opt
local g = vim.g

--Defer loading shada until after startup_
vim.opt.shadafile = "NONE"
vim.schedule(function()
   vim.opt.shadafile = vim.fn.expand("$HOME") .. "/.local/share/nvim/shada/main.shada"
   vim.cmd [[ rsh ]]
end)

-- export user config as a global varibale
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
opt.shortmess:append "sI"

opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.tabstop = 4
opt.termguicolors = true
opt.timeoutlen = 400
opt.undofile = true

opt.scrolloff      = 2
opt.sidescrolloff  = 5

opt.showcmd = true


opt.confirm        = true

-- interval for writing swap file to disk, also used by gitsigns
opt.updatetime = 250

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append "<>[]hl"

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

--local function bind_option(options)
--  for k, v in pairs(options) do
--    if v == true or v == false then
--      vim.cmd('set ' .. k)
--    else
--      vim.cmd('set ' .. k .. '=' .. v)
--    end
--  end
--end
--
--local function load_options()
--  local global_local = {
--    termguicolors  = true;
--    --mouse          = "nv";
--    mouse          = "";
--    errorbells     = true;
--    visualbell     = true;
--    hidden         = true;
--    fileformats    = "unix,mac,dos";
--    magic          = true;
--    virtualedit    = "block";
--    encoding       = "utf-8";
--    viewoptions    = "folds,cursor,curdir,slash,unix";
--    sessionoptions = "curdir,help,tabpages,winsize";
--    clipboard      = "unnamedplus";
--    wildignorecase = true;
--    wildignore     = ".git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**";
--    backup         = false;
--    writebackup    = false;
--    swapfile       = false;
--    directory      = CACHE_PATH .. "swag/";
--    undodir        = CACHE_PATH .. "undo/";
--    backupdir      = CACHE_PATH .. "backup/";
--    viewdir        = CACHE_PATH .. "view/";
--    spellfile      = CACHE_PATH .. "spell/en.uft-8.add";
--    history        = 2000;
--    shada          = "!,'300,<50,@100,s10,h";
--    backupskip     = "/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim";
--    smarttab       = true;
--    shiftround     = true;
--    timeout        = true;
--    ttimeout       = true;
--    timeoutlen     = 400;
--    ttimeoutlen    = 10;
--    updatetime     = 400;
--    redrawtime     = 2000;
--    ignorecase     = true;
--    smartcase      = true;
--    infercase      = true;
--    incsearch      = true;
--    wrapscan       = true;
--    complete       = ".,w,b,k";
--    inccommand     = "nosplit";
--    grepformat     = "%f:%l:%c:%m";
--    grepprg        = 'rg --hidden --vimgrep --smart-case --';
--    --grepprg        = 'rg --vimgrep --no-heading' . (&smartcase ? ' --smart-case' : '') . ' --'
--    breakat        = [[\ \	;:,!?]];
--    startofline    = false;
--    whichwrap      = "h,l,<,>,[,],~";
--    splitbelow     = true;
--    splitright     = true;
--    switchbuf      = "useopen";
--    backspace      = "indent,eol,start";
--    diffopt        = "filler,iwhite,internal,algorithm:patience";
--    completeopt    = "menuone,noselect";
--    jumpoptions    = "stack";
--    showmode       = false;
--    shortmess      = "aoOTIcF";
--    scrolloff      = 2;
--    sidescrolloff  = 5;
--    foldlevelstart = 99;
--    ruler          = false;
--    title          = true;
--    titlestring    = "%<%F%=%l/%L - nvim";
--    --list           = true;
--    showtabline    = 2;
--    winwidth       = 30;
--    winminwidth    = 10;
--    pumheight      = 15;
--    helpheight     = 12;
--    previewheight  = 12;
--    showcmd        = false;
--    cmdheight      = 2;
--    cmdwinheight   = 5;
--    equalalways    = false;
--    laststatus     = 2;
--    display        = "lastline";
--    showbreak      = "↳  ";
----    listchars      = "tab:»·,nbsp:+,trail:·,extends:→,precedes:←";
--    pumblend       = 10;
--    winblend       = 10;
--  }
--
--  local bw_local  = {
--    undofile       = true;
--    synmaxcol      = 2500;
--    formatoptions  = "1jcroql";
--    textwidth      = 120;
--    expandtab      = true;
--    autoindent     = true;
--    tabstop        = 4;
--    shiftwidth     = 4;
--    softtabstop    = -1;
--    breakindentopt = "shift:2,min:20";
--    wrap           = false;
--    linebreak      = true;
--    number         = true;
--    colorcolumn    = "120";
--    foldenable     = true;
--    signcolumn     = "yes";
--    --conceallevel   = 2;
--    --concealcursor  = "niv";
--    confirm        = true;
--  }
--
--  local os_name = vim.loop.os_uname().sysname
--  is_mac     = os_name == 'Darwin'
--  is_linux   = os_name == 'Linux'
--  is_windows = os_name == 'Windows'
--
--  if is_mac then
--    vim.g.clipboard = {
--      name = "macOS-clipboard",
--      copy = {
--        ["+"] = "pbcopy",
--        ["*"] = "pbcopy",
--      },
--      paste = {
--        ["+"] = "pbpaste",
--        ["*"] = "pbpaste",
--      },
--      cache_enabled = 0
--    }
--
--    --virtualenv = global.cache_dir..'/venv/bin/python'
--    --vim.g.python_host_prog = '/usr/bin/python'
--    --vim.g.python3_host_prog = '/usr/local/bin/python3'
--    vim.g.python3_host_prog = CACHE_PATH..'/venv/bin/python'
--  end
--  for name, value in pairs(global_local) do
--    vim.o[name] = value
--  end
--  bind_option(bw_local)
--end
--
--
---- vim.o.guifont = "JetBrains\\ Mono\\ Regular\\ Nerd\\ Font\\ Complete"
--
--local disable_distribution_plugins= function()
--    vim.g.loaded_gzip              = 1
--    vim.g.loaded_tar               = 1
--    vim.g.loaded_tarPlugin         = 1
--    vim.g.loaded_zip               = 1
--    vim.g.loaded_zipPlugin         = 1
--    vim.g.loaded_getscript         = 1
--    vim.g.loaded_getscriptPlugin   = 1
--    vim.g.loaded_vimball           = 1
--    vim.g.loaded_vimballPlugin     = 1
--    vim.g.loaded_matchit           = 1
--    vim.g.loaded_matchparen        = 1
--    vim.g.loaded_2html_plugin      = 1
--    vim.g.loaded_logiPat           = 1
--    vim.g.loaded_rrhelper          = 1
--    vim.g.loaded_netrw             = 1
--    vim.g.loaded_netrwPlugin       = 1
--    vim.g.loaded_netrwSettings     = 1
--    vim.g.loaded_netrwFileHandlers = 1
--  end
--
--  local leader_map = function()
--    --vim.g.mapleader = ","
--    vim.g.mapleader = " "
--    vim.api.nvim_set_keymap('n',' ','',{noremap = true})
--    vim.api.nvim_set_keymap('x',' ','',{noremap = true})
--  end
--
--local createdir = function ()
--    local data_dir = {
--        CACHE_PATH..'backup',
--        CACHE_PATH..'session',
--        CACHE_PATH..'swap',
--        CACHE_PATH..'tags',
--        CACHE_PATH..'undo'
--    }
--    -- There only check once that If cache_dir exists
--    -- Then I don't want to check subs dir exists
--    if vim.fn.isdirectory(CACHE_PATH) == 0 then
--      os.execute("mkdir -p " .. CACHE_PATH)
--      for _,v in pairs(data_dir) do
--        if vim.fn.isdirectory(v) == 0 then
--          os.execute("mkdir -p " .. v)
--        end
--      end
--    end
--  end
--
--createdir()
--disable_distribution_plugins()
--leader_map()
--load_options()
