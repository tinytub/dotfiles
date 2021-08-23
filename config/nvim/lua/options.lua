CONFIG_PATH = vim.fn.stdpath('config')
DATA_PATH = vim.fn.stdpath('data')
CACHE_PATH = vim.fn.stdpath('cache')
vim.cmd('set iskeyword+=-') -- treat dash separated words as a word text object"
TERMINAL = vim.fn.expand('$TERMINAL')
vim.cmd('let &titleold="'..TERMINAL..'"')
vim.cmd [[let &fcs='eob: ']]

-- uncomment this if you want to open nvim with a dir
--vim.cmd [[ autocmd BufEnter * if &buftype != "terminal" | lcd %:p:h | endif ]]

-- Don't show any numbers inside terminals
vim.cmd [[ au TermOpen term://* setlocal nonumber norelativenumber | setfiletype terminal ]]
-- Don't show status line on certain windows
vim.cmd [[ au TermOpen term://* setfiletype terminal ]]
--vim.cmd [[ let hidden_statusline = luaeval('require("chadrc").ui.hidden_statusline') | autocmd BufEnter,BufWinEnter,WinEnter,CmdwinEnter,TermEnter * nested if index(hidden_statusline, &ft) >= 0 | set laststatus=0 | else | set laststatus=2 | endif ]]

local function bind_option(options)
  for k, v in pairs(options) do
    if v == true or v == false then
      vim.cmd('set ' .. k)
    else
      vim.cmd('set ' .. k .. '=' .. v)
    end
  end
end

local function load_options()
  local global_local = {
    termguicolors  = true;
    --mouse          = "nv";
    mouse          = "";
    errorbells     = true;
    visualbell     = true;
    hidden         = true;
    fileformats    = "unix,mac,dos";
    magic          = true;
    virtualedit    = "block";
    encoding       = "utf-8";
    viewoptions    = "folds,cursor,curdir,slash,unix";
    sessionoptions = "curdir,help,tabpages,winsize";
    clipboard      = "unnamedplus";
    wildignorecase = true;
    wildignore     = ".git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**";
    backup         = false;
    writebackup    = false;
    swapfile       = false;
    directory      = CACHE_PATH .. "swag/";
    undodir        = CACHE_PATH .. "undo/";
    backupdir      = CACHE_PATH .. "backup/";
    viewdir        = CACHE_PATH .. "view/";
    spellfile      = CACHE_PATH .. "spell/en.uft-8.add";
    history        = 2000;
    shada          = "!,'300,<50,@100,s10,h";
    backupskip     = "/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim";
    smarttab       = true;
    shiftround     = true;
    timeout        = true;
    ttimeout       = true;
    timeoutlen     = 400;
    ttimeoutlen    = 10;
    updatetime     = 400;
    redrawtime     = 2000;
    ignorecase     = true;
    smartcase      = true;
    infercase      = true;
    incsearch      = true;
    wrapscan       = true;
    complete       = ".,w,b,k";
    inccommand     = "nosplit";
    grepformat     = "%f:%l:%c:%m";
    grepprg        = 'rg --hidden --vimgrep --smart-case --';
    --grepprg        = 'rg --vimgrep --no-heading' . (&smartcase ? ' --smart-case' : '') . ' --'
    breakat        = [[\ \	;:,!?]];
    startofline    = false;
    whichwrap      = "h,l,<,>,[,],~";
    splitbelow     = true;
    splitright     = true;
    switchbuf      = "useopen";
    backspace      = "indent,eol,start";
    diffopt        = "filler,iwhite,internal,algorithm:patience";
    completeopt    = "menuone,noselect";
    jumpoptions    = "stack";
    showmode       = false;
    shortmess      = "aoOTIcF";
    scrolloff      = 2;
    sidescrolloff  = 5;
    foldlevelstart = 99;
    ruler          = false;
    title          = true;
    titlestring    = "%<%F%=%l/%L - nvim";
    --list           = true;
    showtabline    = 2;
    winwidth       = 30;
    winminwidth    = 10;
    pumheight      = 15;
    helpheight     = 12;
    previewheight  = 12;
    showcmd        = false;
    cmdheight      = 2;
    cmdwinheight   = 5;
    equalalways    = false;
    laststatus     = 2;
    display        = "lastline";
    showbreak      = "↳  ";
    listchars      = "tab:»·,nbsp:+,trail:·,extends:→,precedes:←";
    pumblend       = 10;
    winblend       = 10;
  }

  local bw_local  = {
    undofile       = true;
    synmaxcol      = 2500;
    formatoptions  = "1jcroql";
    textwidth      = 120;
    expandtab      = true;
    autoindent     = true;
    tabstop        = 4;
    shiftwidth     = 4;
    softtabstop    = -1;
    breakindentopt = "shift:2,min:20";
    wrap           = false;
    linebreak      = true;
    number         = true;
    colorcolumn    = "120";
    foldenable     = true;
    signcolumn     = "yes";
    --conceallevel   = 2;
    --concealcursor  = "niv";
    confirm        = true;
  }

  local os_name = vim.loop.os_uname().sysname
  is_mac     = os_name == 'Darwin'
  is_linux   = os_name == 'Linux'
  is_windows = os_name == 'Windows'

  if is_mac then
    vim.g.clipboard = {
      name = "macOS-clipboard",
      copy = {
        ["+"] = "pbcopy",
        ["*"] = "pbcopy",
      },
      paste = {
        ["+"] = "pbpaste",
        ["*"] = "pbpaste",
      },
      cache_enabled = 0
    }

    --virtualenv = global.cache_dir..'/venv/bin/python'
    --vim.g.python_host_prog = '/usr/bin/python'
    --vim.g.python3_host_prog = '/usr/local/bin/python3'
    vim.g.python3_host_prog = CACHE_PATH..'/venv/bin/python'
  end
  for name, value in pairs(global_local) do
    vim.o[name] = value
  end
  bind_option(bw_local)
end


-- vim.o.guifont = "JetBrains\\ Mono\\ Regular\\ Nerd\\ Font\\ Complete"

local disable_distribution_plugins= function()
    vim.g.loaded_gzip              = 1
    vim.g.loaded_tar               = 1
    vim.g.loaded_tarPlugin         = 1
    vim.g.loaded_zip               = 1
    vim.g.loaded_zipPlugin         = 1
    vim.g.loaded_getscript         = 1
    vim.g.loaded_getscriptPlugin   = 1
    vim.g.loaded_vimball           = 1
    vim.g.loaded_vimballPlugin     = 1
    vim.g.loaded_matchit           = 1
    vim.g.loaded_matchparen        = 1
    vim.g.loaded_2html_plugin      = 1
    vim.g.loaded_logiPat           = 1
    vim.g.loaded_rrhelper          = 1
    vim.g.loaded_netrw             = 1
    vim.g.loaded_netrwPlugin       = 1
    vim.g.loaded_netrwSettings     = 1
    vim.g.loaded_netrwFileHandlers = 1
  end

  local leader_map = function()
    --vim.g.mapleader = ","
    vim.g.mapleader = " "
    vim.api.nvim_set_keymap('n',' ','',{noremap = true})
    vim.api.nvim_set_keymap('x',' ','',{noremap = true})
  end

local createdir = function ()
    local data_dir = {
        CACHE_PATH..'backup',
        CACHE_PATH..'session',
        CACHE_PATH..'swap',
        CACHE_PATH..'tags',
        CACHE_PATH..'undo'
    }
    -- There only check once that If cache_dir exists
    -- Then I don't want to check subs dir exists
    if vim.fn.isdirectory(CACHE_PATH) == 0 then
      os.execute("mkdir -p " .. CACHE_PATH)
      for _,v in pairs(data_dir) do
        if vim.fn.isdirectory(v) == 0 then
          os.execute("mkdir -p " .. v)
        end
      end
    end
  end

createdir()
disable_distribution_plugins()
leader_map()
load_options()
