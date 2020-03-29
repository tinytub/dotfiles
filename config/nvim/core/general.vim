" ----------------------------------------------------------------------------
" 一般配置
" ----------------------------------------------------------------------------
    " 关闭 vi 兼容性
    set nocompatible

    " clipboard 配置
    "if has('unnamedplus')
    "  set clipboard=unnamed
    "  "set clipboard^=unnamed
    "  "set clipboard^=unnamedplus
    "endif

    " tabs 及 空格控制
    set expandtab
    set tabstop=4
    set softtabstop=4
    set shiftwidth=4
    set smarttab
    set autoindent      " Use same indenting on new lines
    set smartindent     " Smart autoindenting on new lines
    set shiftround      " Round indent to multiple of 'shiftwidth'

    set magic " Set magic on, for regex

    " 横竖行光标高亮
    " set cursorline
    " set cursorcolumn

    set lazyredraw
    set ttyfast "faster redrawing

    
    "set splitright
    "set splitbelow

    "最大可用内存
    set mmp=5000

    "syntax sync minlines=128 " 设置配色行数
    set synmaxcol=2500  " Don't syntax highlight long lines
    set path+=**                 " Directories to search when using gf and friends
    set isfname-==               " Remove =, detects filename in var=/foo/bar

    set hidden "current buffer can be put into background,
    "set hidden 会和 go-def-tab 冲突, 如果关闭 tab 再通过 go-def-tab 打开会导致在同屏 split horizon
    "set showcmd
    "set showmode
    "set showcmd " show incomplete commands
    set noshowcmd noruler "关闭 showcmd 和 ruler 尝试加速 nvim, from: https://www.reddit.com/r/neovim/comments/7epa94/neovim_slowness_compared_to_vim_8/
    set noshowmode " don't show which mode disabled for PowerLine

    set textwidth=120

    " 隐藏欢迎信息, neovim 下可能会造成 continue 及 press enter 问题
    "set shortmess=atIo
    " 文件切换自动保存
    set autowrite
    " 文件变更自动读取
    set autoread
    " 当操作未保存文件时,询问如何操作
    set confirm
    " 无备份文件
    set nobackup
    set nowritebackup

    set bsdir=buffer

    " 其他设置
    "set langmenu=zh_CN.UTF-8
    set langmenu=en_US-UTF-8
    set mouse-=a
    "set mouse=a
    "set wrap " turn on line wrapping
    "set wrapmargin=8 " wrap lines when coming within n characters from side
    "set whichwrap+=<,>,h,l,[,]
    set background=dark

    if has('vim_starting')
    	set encoding=UTF-8
    	scriptencoding UTF-8
    endif

    "set backspace=2 "退格数量,和其他 ide 适配
    "set backspace=indent,eol,start

    " error bells
    set noerrorbells
    set visualbell
    set t_vb=
    set tm=500

    " tab 在一些特殊文件中的特殊配置
    autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
    autocmd FileType htmldjango setlocal shiftwidth=2 tabstop=2 softtabstop=2
    autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2


    " 永远显示状态栏
    set laststatus=2
    set showtabline=2
    "set statusline=-        " hide file name in statusline
    "set fillchars+=vert:\|  " add a bar for vertical splits
    "let g:gruvbox_transp_bg = 1
    if has('nvim')
        if get(g:,'gruvbox_transp_bg',1)
            set fcs=eob:\           " hide ~
        endif
    endif
    if has('mac')
    	let g:clipboard = {
    		\   'name': 'macOS-clipboard',
    		\   'copy': {
    		\      '+': 'pbcopy',
    		\      '*': 'pbcopy',
    		\    },
    		\   'paste': {
    		\      '+': 'pbpaste',
    		\      '*': 'pbpaste',
    		\   },
    		\   'cache_enabled': 0,
    		\ }
    endif
    if has('clipboard')
	    set clipboard& clipboard+=unnamedplus
    endif

    set history=2000
    set number
    set timeout ttimeout

    " Searching
    set ignorecase " case insensitive searching
    set smartcase " case-sensitive if expresson contains a capital letter
    set hlsearch " highlight search results, 高亮搜索结果
    set incsearch " set incremental search, like modern browsers, 增量搜索
    set nolazyredraw " don't redraw while executing macros

    set complete=.,w,b,k  " C-n completion: Scan buffers, windows and dictionary

    if exists('+inccommand')
    	set inccommand=nosplit
    endif
    
    if executable('rg')
    	set grepformat=%f:%l:%m
    	let &grepprg = 'rg --vimgrep' . (&smartcase ? ' --smart-case' : '')
    elseif executable('ag')
    	set grepformat=%f:%l:%m
    	let &grepprg = 'ag --vimgrep' . (&smartcase ? ' --smart-case' : '')
    endif


    " 进入搜索使用sane正则
    "nnoremap / /\v
    "vnoremap / /\v

    " 显示行号
    set nu

   " deoplete.nvim 推荐的补全选项
    " set completeopt-=preview "关闭自带补全窗口
    " set completeopt+=noinsert
    " set completeopt+=noselect

    set completefunc=emoji#complete
    set completeopt =longest,menu
    set completeopt-=preview
""    set list
""    set listchars=tab:»·,nbsp:+,trail:·,extends:→,precedes:←

    " Behavior 
    " --------
    "set nowrap                      " No wrap by default
    set linebreak                   " Break long lines at 'breakat'
    set breakat=\ \	;:,!?           " Long lines break chars
    set nostartofline               " Cursor in same column for few commands
    set whichwrap+=h,l,<,>,[,],~    " Move to following line on certain keys
    set splitbelow splitright       " Splits open bottom right
    set switchbuf=useopen,usetab    " Jump to the first open window in any tab
    set switchbuf+=vsplit           " Switch buffer behavior to vsplit
    set backspace=indent,eol,start  " Intuitive backspacing in insert mode
    set diffopt=filler,iwhite       " Diff mode: show fillers, ignore whitespace
    "set completeopt=menuone         " Always show menu, even for one item
    "set completeopt+=noselect       " Do not select a match in the menu
    "set diffopt+=vertical,iwhite,internal,algorithm:patience,hiddenoff

    if has('patch-8.1.0360') || has('nvim-0.4')
    	set diffopt+=internal,algorithm:patience
    	" set diffopt=indent-heuristic,algorithm:patience
    endif


    " UI Symbols
    " icons:  ▏│ ¦ ╎ ┆ ⋮ ⦙ ┊ 
    set showbreak=↪
    set listchars=tab:\▏\ ,extends:⟫,precedes:⟪,nbsp:␣,trail:·

    " sudo 权限保存
    ca w!! w !sudo tee "%"

    " 滚动屏幕是保持3行在屏幕边界内
    set scrolloff=5

    " 自动补全文件名和命令行的行为,类似 zsh
    set wildmenu
    set wildmode=longest,full
    set shell=$SHELL
    set cmdheight=1 " command bar height
    set title " set terminal title
    set showmatch " show matching braces
    set matchpairs+=<:> " Add HTML brackets to pair matching
    set matchtime=10     " Tenths of a second to show the matching paren
    set cpoptions-=m    " showmatch will wait 0.5s or until a char is typed
    set grepprg=rg\ --vimgrep\ $*
    set wildignore+=*.so,*~,*/.git/*,*/.svn/*,*/.DS_Store,*/tmp/*

    set timeoutlen=500
    set ttimeoutlen=10
    set updatetime=100
    set signcolumn=yes
    set shortmess+=c

    if has('conceal')
    	set conceallevel=3 concealcursor=niv
    endif

    set t_Co=256 " Explicitly tell vim that the terminal supports 256 colors

    if &term =~ '256color'
        " disable background color erase
        set t_ut=
    endif

    "set backup                        " make backup files
    "set undofile                      " persistent undos - undo after you re-open the file
    set undofile swapfile nobackup
    set directory=$DATA_PATH/swap//,$DATA_PATH,~/tmp,/var/tmp,/tmp
    set undodir=$DATA_PATH/undo//,$DATA_PATH,~/tmp,/var/tmp,/tmp
    set backupdir=$DATA_PATH/backup/,$DATA_PATH,~/tmp,/var/tmp,/tmp
    set viewdir=$DATA_PATH/view/
    set spellfile=$VIM_PATH/spell/en.utf-8.add

    " 打开自动定位到最后编辑的位置, 需要确认 .viminfo 当前用户可写
    if has("autocmd")
      au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    endif

    " 适配 neovim 的viminfo
    if has('nvim') && ! has('win32') && ! has('win64')
    	set shada=!,'300,<50,@100,s10,h
    else
    	set viminfo='300,<10,@50,h,n$DATA_PATH/viminfo
    endif

    if (has('nvim'))
        " show results of substition as they're happening
        " but don't open a split
        set inccommand=nosplit
    endif

    " store yankring history file there too
    let g:yankring_history_dir = $DATA_PATH.'/dirs/'

    "" create needed directories if they don't exist
    "if !isdirectory(&backupdir)
    "    call mkdir(&backupdir, "p")
    "endif
    "if !isdirectory(&directory)
    "    call mkdir(&directory, "p")
    "endif
    "if !isdirectory(&undodir)
    "    call mkdir(&undodir, "p")
    "endif

    " If sudo, disable vim swap/backup/undo/shada/viminfo writing
    if $SUDO_USER !=# '' && $USER !=# $SUDO_USER
    		\ && $HOME !=# expand('~'.$USER)
    		\ && $HOME ==# expand('~'.$SUDO_USER)
    
    	set noswapfile
    	set nobackup
    	set nowritebackup
    	set noundofile
    	if has('nvim')
    		set shada="NONE"
    	else
    		set viminfo="NONE"
    	endif
    endif
    
    " Secure sensitive information, disable backup files in temp directories
    if exists('&backupskip')
    	set backupskip+=/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*
    	set backupskip+=.vault.vim
    endif
    
    " Disable swap/undo/viminfo/shada files in temp directories or shm
    augroup user_secure
    	autocmd!
    	silent! autocmd BufNewFile,BufReadPre
    		\ /tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim
    		\ setlocal noswapfile noundofile nobackup nowritebackup viminfo= shada=
    augroup END

    " 自动配置文件头
    autocmd BufNewFile *.sh,*.py,*.rb exec ":call SetTitle()"
    function! SetTitle()
        if &filetype == 'sh'
            call setline(1,"\#!/bin/bash")
            call append(line("."), "")

        elseif &filetype == 'python'
            call setline(1,"#!/usr/bin/env python")
            call append(line("."),"# coding=utf-8")
            call append(line(".")+1, "")

        elseif &filetype == 'ruby'
            call setline(1,"#!/usr/bin/env ruby")
            call append(line("."),"# encoding: utf-8")
            call append(line(".")+1, "")
        endif
    endfunction

    autocmd BufNewFile * normal G

    " If sudo, disable vim swap/backup/undo/shada/viminfo writing
    if $SUDO_USER !=# '' && $USER !=# $SUDO_USER
    		\ && $HOME !=# expand('~'.$USER)
    		\ && $HOME ==# expand('~'.$SUDO_USER)
    
    	set noswapfile
    	set nobackup
    	set nowritebackup
    	set noundofile
    	if has('nvim')
    		set shada="NONE"
    	else
    		set viminfo="NONE"
    	endif
    endif
"
