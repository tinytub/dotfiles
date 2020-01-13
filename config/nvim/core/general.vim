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

    set diffopt+=vertical,iwhite,internal,algorithm:patience,hiddenoff
    "set diffopt+=vertical


    set splitright
    set splitbelow

    "最大可用内存
    set mmp=5000

    "syntax sync minlines=128 " 设置配色行数
    "set synmaxcol=128

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
    set whichwrap+=<,>,h,l,[,]
    set background=dark

    if has('vim_starting')
    	set encoding=UTF-8
    	scriptencoding UTF-8
    endif

    set backspace=2 "退格数量,和其他 ide 适配
    set backspace=indent,eol,start

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
    if get(g:,'gruvbox_transp_bg',1)
        set fcs=eob:\           " hide ~
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


    " 搜索忽略大小写
    set ignorecase
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

    " 更好的 backup, swap 和 undos storage
    set directory=$VARPATH/tmp     " directory to place swap files in
    set backup                        " make backup files
    set backupdir=$VARPATH/backups " where to put backup files
    set undofile                      " persistent undos - undo after you re-open the file
    set undodir=$VARPATH/undos

    " 打开自动定位到最后编辑的位置, 需要确认 .viminfo 当前用户可写
    if has("autocmd")
      au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    endif
    " 适配 neovim 的viminfo
    if has('nvim')
        "  ShaDa/viminfo:
        "   ' - Maximum number of previously edited files marks
        "   < - Maximum number of lines saved for each register
        "   @ - Maximum number of items in the input-line history to be
        "   s - Maximum size of an item contents in KiB
        "   h - Disable the effect of 'hlsearch' when loading the shada
        set shada='300,<50,@100,s10,h
    else
        set viminfo='300,<10,@50,h,n$VARPATH/viminfo
        set viminfo+=n~$VARPATH/dirs/viminfo
    endif

    if (has('nvim'))
        " show results of substition as they're happening
        " but don't open a split
        set inccommand=nosplit
    endif

    " store yankring history file there too
    let g:yankring_history_dir = $VARPATH.'/dirs/'

    " create needed directories if they don't exist
    if !isdirectory(&backupdir)
        call mkdir(&backupdir, "p")
    endif
    if !isdirectory(&directory)
        call mkdir(&directory, "p")
    endif
    if !isdirectory(&undodir)
        call mkdir(&undodir, "p")
    endif

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
