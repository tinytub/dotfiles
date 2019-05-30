" vim-plug 自动更新
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" 配置缓存地址
let $VARPATH = expand(($XDG_CACHE_HOME ? $XDG_CACHE_HOME : '~/.cache').'/vim')

" 配置 neovim 使用的基础环境地址
if isdirectory($VARPATH.'/venv/neovim3')
    let g:python3_host_prog = $VARPATH.'/venv/neovim3/bin/python'
    " 忽略 nvim 模块检查
    let g:python3_host_skip_check = 1
endif
if isdirectory($VARPATH.'/venv/neovim2')
    let g:python_host_prog = $VARPATH.'/venv/neovim2/bin/python'
endif

" default map leader '\'

" ============================================================================
" Active plugins
" You can disable or add new ones here:

call plug#begin('~/.vim/plugged')

" 还是需要再把插件详细分类一下
" Plugins from github repos:

" Better file browser
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Code commenter
Plug 'scrooloose/nerdcommenter'
" Class/module browser
Plug 'majutsushi/tagbar'
" Code and files fuzzy finder
"Plug 'kien/ctrlp.vim'
" Extension to ctrlp, for fuzzy command finder
"Plug 'fisadev/vim-ctrlp-cmdpalette'
" Zen coding
Plug 'mattn/emmet-vim'
" Maybe the best Git integration
Plug 'tpope/vim-fugitive'
" Tab list panel
Plug 'kien/tabman.vim'
" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Consoles as buffers
"Plug 'rosenfeld/conque-term'
" Surround
Plug 'tpope/vim-surround'
" Autoclose
Plug 'Townk/vim-autoclose'
" Indent text object
Plug 'michaeljsmith/vim-indent-object'

" Better autocompletion
" pip3 install neovim
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
" deoplete golang 插件, 需要手动make
Plug 'zchee/deoplete-go' , {'for':'go', 'do': 'make'}
" 据说比 deoplete 好用
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}

"Plug 'nsf/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' } " 据说是不维护了
"Plug 'mdempsky/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }
"Plug 'mdempsky/gocode', {'rtp': 'nvim'}


" python 补全插件
Plug 'davidhalter/jedi-vim' , {'for': ['python', 'python3']}
"Plug 'zchee/deoplete-jedi', {'for': ['python', 'python3']}


" Snippets manager (SnipMate), dependencies, and snippets repo
"Plug 'MarcWeber/vim-addon-mw-utils'
"Plug 'tomtom/tlib_vim'
"Plug 'honza/vim-snippets'
"Plug 'garbas/vim-snipmate'

" Plugin 'joshdick/onedark.vim'
Plug 'morhetz/gruvbox'
" gruvbox 如果颜色不对,尝试执行~/.vim/bundle/gruvbox/gruvbox_256palette.sh 或 ~/.vim/bundle/gruvbox/gruvbox_256palette_osx.sh
"Plugin 'altercation/solarized'

"" Git/mercurial/others diff icons on the side of the file lines
Plug 'mhinz/vim-signify'
" Automatically sort python imports
"Plug 'fisadev/vim-isort'
"" Drag visual blocks arround
"Plug 'fisadev/dragvisuals.vim'
" Window chooser
Plug 't9md/vim-choosewin'
" Python and other languages code checker
" Plug 'scrooloose/syntastic'
Plug 'w0rp/ale' " Asynchonous linting engine

" Paint css colors with the real color
Plug 'lilydjwg/colorizer'
" Relative numbering of lines (0 is the current line)
" (disabled by default because is very intrusive and can't be easily toggled
" on/off. When the plugin is present, will always activate the relative 
" numbering every time you go to normal mode. Author refuses to add a setting 
" to avoid that)
" Plugin 'myusuf3/numbers.vim'

" javascript complete after install the plugin, you must cd the install
" directory and run `npm install`, then add a .tern-project config file
" the doc at http://ternjs.net/doc/manual.html#vim
Plug 'marijnh/tern_for_vim'
" Golang Plugins
Plug 'fatih/vim-go', {'for':'go', 'do': ':GoInstallBinaries' }

" JSX syntax highlight.
Plug 'mxw/vim-jsx'
" Markdown syntastic highlight
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
" Markdown realtime preview
" Before you want to use it, please run
" `sudo npm -g install instant-markdown-d`
" Plug 'suan/vim-instant-markdown'
" Handlebars syntax highlighting
Plug 'mustache/vim-mustache-handlebars'
" Vue.js syntax and highlighting
" Plug 'tao12345666333/vim-vue'
" True Sublime Text style multiple selections for Vim
Plug 'terryma/vim-multiple-cursors'
Plug 'elzr/vim-json', { 'for': 'json' }

" 传说中的自动补全神器?
"git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
"~/.fzf/install
if has("nvim")
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    "Plug '~/.fzf', { 'do' : './install --all' } | Plug 'junegunn/fzf.vim'
endif


" Plugins from vim-scripts repos:

call plug#end()


" 一般配置 
    " 关闭 vi 兼容性
    set nocompatible
    
    " clipboard 配置
    if has('unnamedplus')
      set clipboard=unnamed
      "set clipboard^=unnamed
      "set clipboard^=unnamedplus
    endif

    " tabs 及 空格控制
    set expandtab
    set tabstop=4
    set softtabstop=4
    set shiftwidth=4

    set magic " Set magic on, for regex

    " 横竖行光标高亮
    " set cursorline
    " set cursorcolumn

    set lazyredraw
    set ttyfast "faster redrawing

    set nolazyredraw  " don't redraw while executing macros
    set diffopt+=vertical

    "syntax sync minlines=128 " 设置配色行数
    "set synmaxcol=128

    "set hidden "current buffer can be put into background, 
    "set hidden 会和 go-def-tab 冲突, 如果关闭 tab 再通过 go-def-tab 打开会导致在同屏 split horizon
    "set showcmd
    "set showmode
    "set showcmd " show incomplete commands
    set noshowcmd noruler "关闭 showcmd 和 ruler 尝试加速 nvim, from: https://www.reddit.com/r/neovim/comments/7epa94/neovim_slowness_compared_to_vim_8/
    set noshowmode " don't show which mode disabled for PowerLine

    set textwidth=120
    
    " 隐藏欢迎信息, neovim 下可能会造成 continue 及 press enter 问题
    set shortmess=atIo
    " 文件切换自动保存
    set autowrite
    " 文件变更自动读取
    set autoread
    " 当操作未保存文件时,询问如何操作
    set confirm
    " 无备份文件
    set nobackup
    " 其他设置
    "set langmenu=zh_CN.UTF-8
    set langmenu=en_US-UTF-8
    set mouse-=a
    "set wrap " turn on line wrapping
    "set wrapmargin=8 " wrap lines when coming within n characters from side
    set whichwrap+=<,>,h,l,[,]
    set background=dark
    set encoding=UTF-8

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
    " 增量搜索
    set incsearch
    " 高亮搜索结果
    set hlsearch
    " 关闭最后一次查询的高亮
    nnoremap <F2> :set hlsearch!<CR>

    " 搜索忽略大小写
    set ignorecase
    " 取消查询结果高亮
    nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>
    " 进入搜索使用sane正则
    "nnoremap / /\v
    "vnoremap / /\v

    " 显示行号
    set nu

    " tab 导航 按键映射
    map tn :tabn<CR>
    map tp :tabp<CR>
    map tm :tabm 
    map tt :tabnew 
    map ts :tab split<CR>
    map <C-S-Right> :tabn<CR>
    imap <C-S-Right> <ESC>:tabn<CR>
    map <C-S-Left> :tabp<CR>
    imap <C-S-Left> <ESC>:tabp<CR>

    " 窗口导航使用 meta+arrows
    "map <M-Right> <c-w>l
    "map <M-Left> <c-w>h
    "map <M-Up> <c-w>k
    "map <M-Down> <c-w>j
    "imap <M-Right> <ESC><c-w>l
    "imap <M-Left> <ESC><c-w>h
    "imap <M-Up> <ESC><c-w>k
    "imap <M-Down> <ESC><c-w>j

    " old autocomplete keyboard shortcut
    "imap <C-J> <C-X><C-O>

    " 分屏窗口移动, Smart way to move between windows
    map <C-j> <C-W>j
    map <C-k> <C-W>k
    map <C-h> <C-W>h
    map <C-l> <C-W>l

    " 离开插入模式时关闭粘贴模式
    au InsertLeave * set nopaste

    " 在插入模式时自动set paset
    function! XTermPasteBegin()
      set pastetoggle=<Esc>[201~
      set paste
      return ""
    endfunction
    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

    " deoplete.nvim 推荐的补全选项
    set completeopt-=preview "关闭自带补全窗口
    set completeopt+=noinsert
    set completeopt+=noselect

    " sudo 权限保存
    ca w!! w !sudo tee "%"

    " 简单的递归grep
    " both recursive grep commands with internal or external (fast) grep
    " 同时使用递归 grep 命令同内部或外部 grep (fast)
    command! -nargs=1 RecurGrep lvimgrep /<args>/gj ./**/*.* | lopen | set nowrap
    command! -nargs=1 RecurGrepFast silent exec 'lgrep! <q-args> ./**/*.*' | lopen
    " 映射 grep 按键
    nmap ,R :RecurGrep 
    nmap ,r :RecurGrepFast 
    " 映射 grep 并使用默认字符作为查询文本
    nmap ,wR :RecurGrep <cword><CR>
    nmap ,wr :RecurGrepFast <cword><CR>

    " 滚动屏幕是保持3行在屏幕边界内
    set scrolloff=5

    " 自动补全文件名和命令行的行为,类似 zsh
    set wildmenu
    set wildmode=longest,full
    set shell=$SHELL
    set cmdheight=1 " command bar height
    set title " set terminal title
    set showmatch " show matching braces
"    set mat=2 " how many tenths of a second to blink

    set t_Co=256 " Explicitly tell vim that the terminal supports 256 colors

    if &term =~ '256color'
        " disable background color erase
        set t_ut=
    endif

    " 更好的 backup, swap 和 undos storage
    set directory=~/.vim/dirs/tmp     " directory to place swap files in
    set backup                        " make backup files
    set backupdir=~/.vim/dirs/backups " where to put backup files
    set undofile                      " persistent undos - undo after you re-open the file
    set undodir=~/.vim/dirs/undos

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
        set viminfo+=n~/.vim/dirs/viminfo
    endif

    if (has('nvim'))
        " show results of substition as they're happening
        " but don't open a split
        set inccommand=nosplit
    endif

    " store yankring history file there too
    let g:yankring_history_dir = '~/.vim/dirs/'

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
"

" ============================================================================
" Plugins settings and mappings
" Edit them as you wish.

" Tagbar ----------------------------- 

    " toggle tagbar display
    map <F4> :TagbarToggle<CR>
    " autofocus on tagbar open
    let g:tagbar_autofocus = 1

" NERDTree ----------------------------- 
    " 切换 nerdtre 显示
    " map <F3> :NERDTreeToggle<CR>
    " 打开 nerdree 并选中当前打开的文件
    map <F3> :call ToggleNerdTree()<CR>
    "nmap ,t :NERDTreeFind<CR>
    "
    " 不要显示如下文件类型
    let NERDTreeIgnore = ['\.pyc$', '\.pyo$']
    " 自动开关 NERDTree
    autocmd vimenter * if !argc() | NERDTree | endif
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

    " 先注释掉,试用旧配置"
    "let NERDTreeDirArrowExpandable = "\u00a0" " make arrows invisible
    "let NERDTreeDirArrowCollapsible = "\u00a0" " make arrows invisible

    augroup nerdtree
        autocmd!
        autocmd FileType nerdtree setlocal nolist " turn off whitespace characters
        autocmd FileType nerdtree setlocal nocursorline " turn off line highlighting for performance
    augroup END

    " Toggle NERDTree
    function! ToggleNerdTree()
        if @% != "" && @% !~ "Startify" && (!exists("g:NERDTree") || (g:NERDTree.ExistsForTab() && !g:NERDTree.IsOpen()))
            :NERDTreeFind
        else
            :NERDTreeToggle
        endif
    endfunction
    " " toggle nerd tree
    " nmap <silent> <leader>k :call ToggleNerdTree()<cr>
    " " find the current file in nerdtree without needing to reload the drawer
    " nmap <silent> <leader>y :NERDTreeFind<cr>

    "let NERDTreeShowHidden=1
    let NERDTreeDirArrowExpandable = '▷'
    let NERDTreeDirArrowCollapsible = '▼'
    let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }
"



" FZF 没有详细配置,回头再搞
    let g:fzf_layout = { 'down': '~25%' }
    let g:fzf_buffers_jump = 1

    if isdirectory(".git")
        " if in a git project, use :GFiles
        nmap <silent> <leader>f :GitFiles --cached --others --exclude-standard<cr>
    else
        " otherwise, use :FZF
        nmap <silent> <leader>f :FZF<cr>
    endif

    nmap <silent> <leader>s :GFiles?<cr>

    nmap <silent> <leader>r :Buffers<cr>
    nmap <silent> <leader>e :FZF<cr>
    nmap <leader><tab> <plug>(fzf-maps-n)
    xmap <leader><tab> <plug>(fzf-maps-x)
    omap <leader><tab> <plug>(fzf-maps-o)

    " Insert mode completion
    imap <c-x><c-k> <plug>(fzf-complete-word)
    imap <c-x><c-f> <plug>(fzf-complete-path)
    imap <c-x><c-j> <plug>(fzf-complete-file-ag)
    imap <c-x><c-l> <plug>(fzf-complete-line)

    nnoremap <silent> <Leader>C :call fzf#run({
    \   'source':
    \     map(split(globpath(&rtp, "colors/*.vim"), "\n"),
    \         "substitute(fnamemodify(v:val, ':t'), '\\..\\{-}$', '', '')"),
    \   'sink':    'colo',
    \   'options': '+m',
    \   'left':    30
    \ })<CR>

    command! FZFMru call fzf#run({
    \  'source':  v:oldfiles,
    \  'sink':    'e',
    \  'options': '-m -x +s',
    \  'down':    '40%'})

    command! -bang -nargs=* Find call fzf#vim#grep(
        \ 'rg --column --line-number --no-heading --follow --color=always '.<q-args>, 1,
        \ <bang>0 ? fzf#vim#with_preview('up:60%') : fzf#vim#with_preview('right:50%:hidden', '?'), <bang>0)
    command! -bang -nargs=? -complete=dir Files
        \ call fzf#vim#files(<q-args>, fzf#vim#with_preview('right:50%', '?'), <bang>0)
    command! -bang -nargs=? -complete=dir GitFiles
        \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview('right:50%', '?'), <bang>0)



" CtrlP ------------------------------

"    " file finder mapping
"    let g:ctrlp_map = ',e'
"    " hidden some types files
"    let g:ctrlp_show_hidden = 1
"    set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.png,*.jpg,*.gif           "Linux
"    " tags (symbols) in current file finder mapping
"    nmap ,g :CtrlPBufTag<CR>
"    " tags (symbols) in all files finder mapping
"    nmap ,G :CtrlPBufTagAll<CR>
"    " general code finder in all files mapping
"    nmap ,f :CtrlPLine<CR>
"    " recent files finder mapping
"    nmap ,m :CtrlPMRUFiles<CR>
"    " commands finder mapping
"    nmap ,c :CtrlPCmdPalette<CR>
"    " to be able to call CtrlP with default search text
"    function! CtrlPWithSearchText(search_text, ctrlp_command_end)
"        execute ':CtrlP' . a:ctrlp_command_end
"        call feedkeys(a:search_text)
"    endfunction
"    " same as previous mappings, but calling with current word as default text
"    nmap ,wg :call CtrlPWithSearchText(expand('<cword>'), 'BufTag')<CR>
"    nmap ,wG :call CtrlPWithSearchText(expand('<cword>'), 'BufTagAll')<CR>
"    nmap ,wf :call CtrlPWithSearchText(expand('<cword>'), 'Line')<CR>
"    nmap ,we :call CtrlPWithSearchText(expand('<cword>'), '')<CR>
"    nmap ,pe :call CtrlPWithSearchText(expand('<cfile>'), '')<CR>
"    nmap ,wm :call CtrlPWithSearchText(expand('<cword>'), 'MRUFiles')<CR>
"    nmap ,wc :call CtrlPWithSearchText(expand('<cword>'), 'CmdPalette')<CR>
"    " don't change working directory
"    let g:ctrlp_working_path_mode = 0
"    " ignore these files and folders on file finder
"    let g:ctrlp_custom_ignore = {
"      \ 'dir':  '\v[\/](\.git|\.hg|\.svn)$',
"      \ 'file': '\.pyc$\|\.pyo$',
"      \ }

" ALE 替代 Syntastic
    " Write this in your vimrc file
    let g:ale_lint_on_text_changed = 'normal'
    " You can disable this option too
    " if you don't want linters to run on opening a file
    let g:ale_lint_on_enter = 1

    "let g:ale_set_highlights = 1
    "let g:ale_change_sign_column_color = 1

    " Enable integration with airline.
    "let g:airline#extensions#ale#enabled = 1

    " 关闭本地列表,使用 quickfix
    let g:ale_set_loclist = 0
    let g:ale_set_quickfix = 1
    "let g:ale_list_vertical = 1
    "let g:ale_open_list = 1

    let g:ale_sign_column_always = 0
    "let g:ale_sign_error = '✖'
    "let g:ale_sign_warning = '⚠'
    let g:ale_sign_error = '👿'
    let g:ale_sign_warning = '🤔'
    "let g:ale_echo_msg_error_str = '✖'
    "let g:ale_echo_msg_warning_str = '⚠'
    let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'


    " for golang
    "let g:ale_linters = {'go': ['gometalinter']}
    "let g:ale_linters = {'go': ['golangci-lint','gofmt'],'python': ['flake8','pylint']}
    "let g:ale_linters = {'go': ['gometalinter','gofmt'],'python': ['flake8','pylint']}
    let g:ale_linters = {'go': ['golint','gofmt'],'python': ['flake8','pylint']}
    "let g:ale_linters = {'go': ['gopls'],'python': ['flake8','pylint']}
    let b:ale_fixers = {'python':['autopep8', 'yapf']}
    "let g:ale_go_gometalinter_options = '--fast --disable=gas --deadline=1s'
    "let g:ale_go_golangci_lint_package = 1
    "let g:ale_go_golangci_lint_options = '--fast'
    "let g:ale_go_golangci_lint_options = "--no-config --fast -D staticcheck -D typecheck"
    "let g:ale_go_gometalinter_options = '--fast --disable=gas --disable=goconst --disable=gocyclo --deadline=1s --exclude="should have comment" --exclude="error return value not checked \(defer"'
    "let g:ale_go_gometalinter_options = '--fast --enable=staticcheck --enable=gosimple --enable=unused'
    let g:ale_go_gometalinter_options = '--fast --disable=gas --disable=goconst --disable=gocyclo --deadline=1s'
    "let g:ale_python_flake8_args="--ignore=E114,E116,E131 --max-line-length=120"
    let g:ale_python_flake8_options="--ignore=E114,E116,E131 --max-line-length=120"

    let g:ale_fixers = {}
    let g:ale_fixers['javascript'] = ['prettier']
    let g:ale_fixers['typescript'] = ['prettier', 'tslint']
    let g:ale_fixers['json'] = ['prettier']
    let g:ale_fixers['css'] = ['prettier']
    let g:ale_javascript_prettier_use_local_config = 1
    let g:ale_fix_on_save = 0

    " エラー一覧リストをトグルする自作関数
    function! AleListToggle()
        " ALEが起動していないときは終了する
        if !exists('g:ale_open_list')
            return
        endif
        " listが0(off)のときは1(on)にして、1のときは0にする
        if(g:ale_open_list == 0) 
            ALEDisableBuffer  " 一旦aleを終了(ale起動中に変数を変えても反映されないので)
            let g:ale_open_list = 1
            ALEEnableBuffer  " aleを再度起動
        else
            let g:ale_open_list = 0
            " 下のウィンドウに移動してからウィンドウを消す
            execute ":wincmd j"
            execute ":q"
        endif
    endfunction

    nnoremap <silent> <F5> :call AleListToggle()<CR>

"" deoplete 相关配置
"    " ---
"    " let g:deoplete#enable_profile = 1
"    " call deoplete#enable_logging('DEBUG', 'deoplete.log')<CR>
"    " call deoplete#custom#source('tern', 'debug_enabled', 1)<CR>
"    " " General settings " {{{ 参考https://github.com/rafi/vim-config/config/plugins/deoplete.vim
"    " ---
"    " let g:deoplete#auto_complete_delay = 50  " Default is 50
"    " let g:deoplete#auto_refresh_delay = 500  " Default is 500
"    " let g:deoplete#auto_complete_delay = 50  " Default is 50
"    " let g:deoplete#auto_refresh_delay = 500  " Default is 500
"
"    " let g:deoplete#sources#go#debug#log_file = '/tmp/deoplete-go.log'
"
"    let g:deoplete#enable_refresh_always = 1
"    let g:deoplete#enable_camel_case = 1
"    let g:deoplete#max_abbr_width = 35
"    let g:deoplete#max_menu_width = 20
"    let g:deoplete#skip_chars = ['(', ')', '<', '>']
"    let g:deoplete#tag#cache_limit_size = 800000
"    let g:deoplete#file#enable_buffer_path = 1
"
"    let g:deoplete#sources#jedi#statement_length = 30
"    let g:deoplete#sources#jedi#show_docstring = 1
"    let g:deoplete#sources#jedi#short_types = 1
"    "let g:deoplete#sources#jedi#enable_typeinfo = 0
"
"    let g:deoplete#sources#ternjs#filetypes = [
"        \ 'jsx',
"        \ 'javascript.jsx',
"        \ 'vue',
"        \ 'javascript'
"        \ ]
"
"    let g:deoplete#sources#ternjs#timeout = 3
"    let g:deoplete#sources#ternjs#types = 1
"    let g:deoplete#sources#ternjs#docs = 1
"
"    call deoplete#custom#source('_', 'min_pattern_length', 2)
"
"    " }}}
"    " Limit Sources " {{{
"    " ---
"
"    "let g:deoplete#sources = get(g:, 'deoplete#sources', {})
"    "let g:deoplete#sources.go = ['vim-go']
"    "let g:deoplete#ignore_sources = get(g:, 'deoplete#ignore_sources', {})
"
"
"    " deoplete 我的 go 相关配置
"    let g:deoplete#enable_at_startup = 1
"    let g:deoplete#sources#go#gocode_binary = '$GOPATH/bin/gocode'
"    " let g:deoplete#file#enable_buffer_path=1
"    let g:deoplete#sources#go#pointer = 1
"    let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const', 'pointer']
"    let g:deoplete#keyword_patterns={}
"    "let g:deoplete#keyword_patterns.clojure='[\w!$%&*+/:<=>?@\^_~\-\.]*'
"
"    " <Tab> completion:
"    " 1. If popup menu is visible, select and insert next item
"    " 2. Otherwise, if within a snippet, jump to next input
"    " 3. Otherwise, if preceding chars are whitespace, insert tab char
"    " 4. Otherwise, start manual autocomplete
"    imap <silent><expr><Tab> pumvisible() ? "\<Down>"
"        \ : (<SID>is_whitespace() ? "\<Tab>"
"        \ : deoplete#manual_complete())
"
"    smap <silent><expr><Tab> pumvisible() ? "\<Down>"
"        \ : (<SID>is_whitespace() ? "\<Tab>"
"        \ : deoplete#manual_complete())
"
"    inoremap <expr><S-Tab>  pumvisible() ? "\<Up>" : "\<C-h>"
"
"    function! s:is_whitespace()
"        let col = col('.') - 1
"        return ! col || getline('.')[col - 1] =~? '\s'
"    endfunction
"
"    " 解决 vim-multiple-cursors deoplete 冲突问题
"    function! Multiple_cursors_before()
"        let g:deoplete#disable_auto_complete = 1
"      "if exists(':NeoCompleteLock')==2
"      "  exe 'NeoCompleteLock'
"      "endif
"    endfunction
"
"    function! Multiple_cursors_after()
"        let g:deoplete#disable_auto_complete = 0
"      "if exists(':NeoCompleteUnlock')==2
"      "  exe 'NeoCompleteUnlock'
"      "endif
"    endfunction
"

" TabMan ------------------------------

    " mappings to toggle display, and to focus on it
    let g:tabman_toggle = 'tl'
    let g:tabman_focus  = 'tf'

" Autoclose ------------------------------

    " Fix to let ESC work as espected with Autoclose plugin
    let g:AutoClosePumvisible = {"ENTER": "\<C-Y>", "ESC": "\<ESC>"}

" DragVisuals ------------------------------

    " mappings to move blocks in 4 directions
    vmap <expr> <S-M-LEFT> DVB_Drag('left')
    vmap <expr> <S-M-RIGHT> DVB_Drag('right')
    vmap <expr> <S-M-DOWN> DVB_Drag('down')
    vmap <expr> <S-M-UP> DVB_Drag('up')
    " mapping to duplicate block
    vmap <expr> D DVB_Duplicate()

" Signify ------------------------------

    " this first setting decides in which order try to guess your current vcs
    " UPDATE it to reflect your preferences, it will speed up opening files
    let g:signify_vcs_list = [ 'git', 'hg' ]
    " mappings to jump to changed blocks
    nmap <leader>sn <plug>(signify-next-hunk)
    nmap <leader>sp <plug>(signify-prev-hunk)


" Window Chooser ------------------------------

    " mapping
    nmap  -  <Plug>(choosewin)
    " show big letters
    let g:choosewin_overlay_enable = 1

" Airline ------------------------------

    
    let g:airline_powerline_fonts = 1
    " let g:airline_theme = 'bubblegum'
    let g:airline_theme = 'gruvbox'
    "let g:airline#extensions#tabline#left_sep = ' '
    "let g:airline#extensions#tabline#left_alt_sep = '|'
    
    " to use fancy symbols for airline, uncomment the following lines and use a
    " patched font (more info on the README.rst)
    if !exists('g:airline_symbols')
       let g:airline_symbols = {}
    endif
    " let g:airline_left_sep = '⮀'
    " let g:airline_left_alt_sep = '⮁'
    " let g:airline_right_sep = '⮂'
    " let g:airline_right_alt_sep = '⮃'
    " let g:airline_symbols.branch = '⭠'
    " let g:airline_symbols.readonly = '⭤'
    " let g:airline_symbols.linenr = '⭡'
    "
    "let g:airline_left_sep = '»'
    "let g:airline_left_sep = '▶'
    "let g:airline_right_sep = '«'
    "let g:airline_right_sep = '◀'
    "let g:airline_symbols.crypt = '🔒'
    "let g:airline_symbols.linenr = '¶'
    "let g:airline_symbols.maxlinenr = ''
    "let g:airline_symbols.branch = ''
    "let g:airline_symbols.paste = 'Þ'
    "let g:airline_symbols.spell = ''
    "let g:airline_symbols.notexists = 'Ɇ'
    "let g:airline_symbols.whitespace = 'Ξ'

    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#formatter = 'default'
    "let airline#extensions#ale#error_symbol = 'E:'
    "let airline#extensions#ale#warning_symbol = 'W:'
    "let airline#extensions#ale#show_line_numbers = 1
    "let airline#extensions#ale#open_lnum_symbol = '(L'
    "let airline#extensions#ale#close_lnum_symbol = ')'
    let g:airline#extensions#coc#enabled = 1


    
    let g:airline_left_sep = ''
    let g:airline_left_alt_sep = ''
    let g:airline_right_sep = ''
    let g:airline_right_alt_sep = ''
    let g:airline_symbols.branch = ''
    let g:airline_symbols.readonly = ''
    let g:airline_symbols.crypt = '🔒'
    let g:airline_symbols.linenr = '¶'
    let g:airline_symbols.maxlinenr = ''
    let g:airline_symbols.paste = 'Þ'
    let g:airline_symbols.spell = ''
    let g:airline_symbols.notexists = 'Ɇ'
    let g:airline_symbols.whitespace = 'Ξ'
    
" Vim-jsx ------------------------------

    " if you use JSX syntax in .js file, please enable it.
    let g:jsx_ext_required = 0

" Vim-markdown ------------------------------

    " Disabled automatically folding
    let g:vim_markdown_folding_disabled=1
    " LeTeX math
    let g:vim_markdown_math=1
    " Highlight YAML frontmatter
    let g:vim_markdown_frontmatter=1

" Vim-instant-markdown -----------------

    " If it takes your system too much, you can specify
    " let g:instant_markdown_slow = 1
    " if you don't want to manually control it
    " you can open this setting
    " and when you open this, you can manually trigger preview
    " via the command :InstantMarkdownPreview
    let g:instant_markdown_autostart = 0

" vim-JSON 
    let g:vim_json_syntax_conceal = 0
" 
" coc.vim

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')



" vim-go 相关配置 --------------------------
      " disable vim-go :GoDef short cut (gd)
      " this is handled by LanguageClient [LC]
      " 关闭 vim-go 的 godef 使用 coc 的
      let g:go_def_mapping_enabled = 0
       
      "let g:go_autodetect_gopath = 1
      "let g:go_list_type = "quickfix"
      "let g:go_def_mode = 'guru'
      let g:go_def_mode = 'gopls'
      let g:go_info_mode = 'gopls'
      "let g:go_def_mode = 'godef'
      let g:go_def_reuse_buffer = 1
    
      let g:go_fmt_command = "goimports"
      " 自动添加标签
      let g:go_addtags_transform = "snakecase"
      "let g:go_term_mode = "split"
      "let g:go_term_enabled = 1
      
      "据说可以解决和 ale 的冲突
      let g:go_fmt_fail_silently = 1

      " 关闭 vim-go 的 linter ?
      let g:go_metalinter_autosave = 0
      let g:go_metalinter_autosave_enabled = ['vet']
    
      let g:go_highlight_functions = 1
      let g:go_highlight_methods = 1
      let g:go_highlight_structs = 1
      let g:go_highlight_interfaces = 1
      let g:go_highlight_operators = 1
      let g:go_highlight_build_constraints = 1
      let g:go_highlight_extra_types = 1

" vim-go 按键映射 -------------------------
    augroup VimGo
      autocmd!
      " vim-go related mappings
      autocmd FileType go nmap <Leader>r <Plug>(go-run)
      autocmd FileType go nmap <Leader>b <Plug>(go-build)
      "autocmd FileType go nmap <Leader>t <Plug>(go-test)
      "autocmd FileType go nmap <Leader>i <Plug>(go-info)
      "autocmd FileType go nmap <Leader>s <Plug>(go-implements)
      autocmd FileType go nmap <Leader>c <Plug>(go-coverage)
      autocmd FileType go nmap <Leadee <Plug>(go-rename)
      autocmd FileType go nmap <Leader>gi <Plug>(go-imports)
      autocmd FileType go nmap <Leader>gI <Plug>(go-install)
      autocmd FileType go nmap <Leader>gd <Plug>(go-doc)
      autocmd FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
      autocmd FileType go nmap <Leader>gb <Plug>(go-doc-browser)
      autocmd FileType go nmap <Leader>ds <Plug>(go-def-split)
      autocmd FileType go nmap <Leader>dv <Plug>(go-def-vertical)
      autocmd FileType go nmap <Leader>dt <Plug>(go-def-tab)
      autocmd FileType go set nocursorcolumn
    augroup END

" vim-jedi 相关配置
        "let g:jedi#auto_vim_configuration = 0
        "let g:jedi#auto_configuration = 0
        let g:jedi#smart_auto_mappings = 1
        " 禁用自动补全
        let g:jedi#completions_enabled = 0
        let g:jedi#use_tabs_not_buffers = 1
        " 键位什么的
        let g:jedi#goto_command = "gd"
        let g:jedi#goto_assignments_command = "<leader>g"
        let g:jedi#documentation_command = "K"
        let g:jedi#usages_command = "<leader>n"
        let g:jedi#completions_command = "<C-Space>"
        let g:jedi#rename_command = "<leader>r"
        let g:jedi#auto_close_doc = 1
    "endif


"" AutoGroups -------------------
    " 虽然不知道做什么用的,但是觉得挺厉害的...
    " file type specific settings
    augroup configgroup
        autocmd!

        " automatically resize panes on resize
        autocmd VimResized * exe 'normal! \<c-w>='
        autocmd BufWritePost .vimrc,.vimrc.local,init.vim source %
        autocmd BufWritePost .vimrc.local source %
        " save all files on focus lost, ignoring warnings about untitled buffers
        autocmd FocusLost * silent! wa

        " make quickfix windows take all the lower section of the screen
        " when there are multiple windows open
        autocmd FileType qf wincmd J
        autocmd FileType qf nmap <buffer> q :q<cr>
    augroup END
""  

" 颜色主题及最后配置
    " use 256 colors when possible
    if (has("termguicolors"))
        set termguicolors
    endif

    if has('nvim')
      colorscheme gruvbox
    else
      colorscheme gruvbox
    endif

    " syntax highlight on and filetype reload
    syntax on
    filetype plugin indent on


augroup CloseLoclistWindowGroup
    autocmd!
    autocmd QuitPre * if empty(&buftype) | lclose | endif
augroup END

" Enter automatically into the files directory
autocmd BufEnter * silent! lcd %:p:h
