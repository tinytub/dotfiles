" ----------------------------------------------------------------------------
"  外部基础依赖
" ----------------------------------------------------------------------------
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


" ----------------------------------------------------------------------------
"  插件加载
" ----------------------------------------------------------------------------
call plug#begin('~/.vim/plugged')

    " 还是需要再把插件详细分类一下
    " 配色大全
    " Plug 'sheerun/vim-polyglot'

    " 启动页
    Plug 'mhinz/vim-startify'

    " tmux integration for vim
    Plug 'benmills/vimux'
    
    " Better file browser
    "Plug 'scrooloose/nerdtree'
    "Plug 'Xuyuanp/nerdtree-git-plugin'
    "Plug 'ryanoasis/vim-devicons'
    "Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

    Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'kristijanhusak/defx-git'
    Plug 'kristijanhusak/defx-icons'
    
    " Class/module 浏览器
    Plug 'majutsushi/tagbar'
    " Zen coding
    Plug 'mattn/emmet-vim'
    " 可能是最好的 git 继承插件
    Plug 'tpope/vim-fugitive'
    " Airline
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    " Surround
    Plug 'tpope/vim-surround'

    " Autoclose
    "Plug 'Townk/vim-autoclose'
    "Plug 'jiangmiao/auto-pairs'
    
    " Better autocompletion 暂时先使用 coc
    "if has('nvim')
    "  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    "else
    "  Plug 'Shougo/deoplete.nvim'
    "  Plug 'roxma/nvim-yarp'
    "  Plug 'roxma/vim-hug-neovim-rpc'
    "endif
    "" deoplete golang 插件, 需要手动make
    "Plug 'zchee/deoplete-go' , {'for':'go', 'do': 'make'}
    
    " 据说比 deoplete 好用
    " Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}
    Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}


    
    "Plug 'nsf/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' } " 据说是不维护了
    "Plug 'mdempsky/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }
    
    
    " python 补全插件
    Plug 'davidhalter/jedi-vim' , {'for': ['python', 'python3']}
    "Plug 'zchee/deoplete-jedi', {'for': ['python', 'python3']}
    
    
    " Plugin 'joshdick/onedark.vim'
    Plug 'morhetz/gruvbox'
    Plug 'jacoborus/tender.vim'
    Plug 'joshdick/onedark.vim'
    Plug 'dracula/vim', { 'as': 'dracula' }

    " gruvbox 如果颜色不对,尝试执行~/.vim/bundle/gruvbox/gruvbox_256palette.sh 或 ~/.vim/bundle/gruvbox/gruvbox_256palette_osx.sh
    "Plugin 'altercation/solarized'
    
    "" Git/mercurial/others diff icons on the side of the file lines
    Plug 'mhinz/vim-signify'
    
    " Window chooser
    Plug 't9md/vim-choosewin'
    " Asynchonous linting engine
    Plug 'w0rp/ale' 
    
    " JS 相关暂时用不到
    "Plug 'othree/yajs.vim', { 'for': [ 'javascript', 'javascript.jsx', 'html' ] }
    "" Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx', 'html'] }
    "Plug 'moll/vim-node', { 'for': 'javascript' }
	"Plug 'ternjs/tern_for_vim', { 'for': ['javascript', 'javascript.jsx'], 'do': 'npm install' }
	"Plug 'MaxMEllon/vim-jsx-pretty'
    "let g:vim_jsx_pretty_highlight_close_tag = 1
    
    " Golang Plugins
    Plug 'fatih/vim-go', {'for':'go', 'do': ':GoInstallBinaries' }
    
    " Markdown syntastic highlight
    Plug 'godlygeek/tabular'
    Plug 'plasticboy/vim-markdown'
    " True Sublime Text style multiple selections for Vim
    Plug 'terryma/vim-multiple-cursors'

    "JSON
    Plug 'elzr/vim-json', { 'for': 'json' }
    let g:vim_json_syntax_conceal = 0

    
    " 传说中的自动补全神器?
    "git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    "~/.fzf/install
    if has("nvim")
        Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
        Plug 'junegunn/fzf.vim'
    endif
call plug#end()


" ----------------------------------------------------------------------------
" 一般配置 
" ----------------------------------------------------------------------------
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

    set diffopt+=vertical,iwhite,internal,algorithm:patience,hiddenoff
    "set diffopt+=vertical


    set splitright
    set splitbelow

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

    " Searching
    set ignorecase " case insensitive searching
    set smartcase " case-sensitive if expresson contains a capital letter
    set hlsearch " highlight search results, 高亮搜索结果
    set incsearch " set incremental search, like modern browsers, 增量搜索
    set nolazyredraw " don't redraw while executing macros

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

    " insert Mode 移动光标
    inoremap <C-h> <Left>
    inoremap <C-j> <Down>
    inoremap <C-k> <Up>
    inoremap <C-l> <Right>

    cnoremap <C-h> <Left>
    cnoremap <C-j> <Down>
    cnoremap <C-k> <Up>
    cnoremap <C-l> <Right>


    " 分屏窗口移动, Smart way to move between windows
    map <C-j> <C-W>j
    map <C-k> <C-W>k
    map <C-h> <C-W>h
    map <C-l> <C-W>l

    " Make basic movements work better with wrapped lines
    "nnoremap j gj
    "nnoremap gj j
    "nnoremap k gk
    "nnoremap gk k

    " So that I don't have to hit esc
    "inoremap jk 
    "inoremap kj 

    " So I can move around in insert
    "inoremap <C-k> <C-o>gk
    "inoremap <C-h> <Left>
    "inoremap <C-l> <Right>
    "inoremap <C-j> <C-o>gj
    
    " Make working with multiple buffers less of a pain
    "nnoremap <C-w>v :vnew<cr>
    "nnoremap <C-k> <C-w>k
    "nnoremap <C-h> <C-w>h
    "nnoremap <C-l> <C-w>l
    "nnoremap <C-j> <C-w>j<Paste>

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
    " set completeopt-=preview "关闭自带补全窗口
    " set completeopt+=noinsert
    " set completeopt+=noselect

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
    set mat=2 " how many tenths of a second to blink

    set updatetime=300
    set signcolumn=yes
    set shortmess+=c

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

" ----------------------------------------------------------------------------
" 插件配置
" ----------------------------------------------------------------------------

" Polyglot
    let g:polyglot_disabled = ['go']

" Tagbar ----------------------------- 

    " toggle tagbar display
    map <F4> :TagbarToggle<CR>
    " autofocus on tagbar open
    let g:tagbar_autofocus = 1

" NERDTree ----------------------------- 
""    " 切换 nerdtre 显示
""    " map <F3> :NERDTreeToggle<CR>
""    " 打开 nerdree 并选中当前打开的文件
""    map <F3> :call ToggleNerdTree()<CR>
""
""
""    let g:WebDevIconsOS = 'Darwin'
""    let g:WebDevIconsUnicodeDecorateFolderNodes = 1
""    "let g:WebDevIconsUnicodeDecorateFolderNodes = v:true
""    let g:WebDevIconsNerdTreeBeforeGlyphPadding = ''
""    let g:DevIconsEnableFoldersOpenClose = 1
""    let g:DevIconsEnableFolderExtensionPatternMatching = 1
""    let NERDTreeDirArrowExpandable = "\u00a0" " make arrows invisible
""    let NERDTreeDirArrowCollapsible = "\u00a0" " make arrows invisible
""    let NERDTreeNodeDelimiter = "\u263a" " smiley face
""
""    " 不要显示如下文件类型
""    let NERDTreeIgnore=['\.o','\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
""
""    " 自动开关 NERDTree
""    autocmd vimenter * if !argc() | NERDTree | endif
""    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
""
""    augroup nerdtree
""        autocmd!
""        autocmd FileType nerdtree setlocal nolist " turn off whitespace characters
""        autocmd FileType nerdtree setlocal nocursorline " turn off line highlighting for performance
""    augroup END
""
""    " Toggle NERDTree
""    function! ToggleNerdTree()
""        if @% != "" && @% !~ "Startify" && (!exists("g:NERDTree") || (g:NERDTree.ExistsForTab() && !g:NERDTree.IsOpen()))
""            :NERDTreeFind
""        else
""            :NERDTreeToggle
""        endif
""    endfunction
""
""    " " find the current file in nerdtree without needing to reload the drawer
""    nmap <silent> <leader>y :NERDTreeFind<cr>
""
""    let NERDTreeShowHidden=1
""    " let NERDTreeDirArrowExpandable = '▷'
""    " let NERDTreeDirArrowCollapsible = '▼'
""    let g:NERDTreeIndicatorMapCustom = {
""    \ "Modified"  : "✹",
""    \ "Staged"    : "✚",
""    \ "Untracked" : "✭",
""    \ "Renamed"   : "➜",
""    \ "Unmerged"  : "═",
""    \ "Deleted"   : "✖",
""    \ "Dirty"     : "✗",
""    \ "Clean"     : "✔︎",
""    \ 'Ignored'   : '☒',
""    \ "Unknown"   : "?"
""    \ }

  
" Defx 代替 nerdtree ----------------------------- 
    augroup vimrc_defx
      autocmd!
      autocmd FileType defx call s:defx_mappings()                                  "Defx mappings
      autocmd VimEnter * call s:setup_defx()
    augroup END
    
    nnoremap <silent><Leader>n :call <sid>defx_open()<CR>
    nnoremap <silent><Leader>hf :call <sid>defx_open({ 'find_current_file': v:true })<CR>
    let s:default_columns = 'indent:git:icons:filename'
    
    function! s:setup_defx() abort
      call defx#custom#option('_', {
            \ 'columns': s:default_columns,
            \ })
    
      call defx#custom#column('filename', {
            \ 'min_width': 80,
            \ 'max_width': 80,
            \ })
    
      call s:defx_open({ 'dir': expand('<afile>') })
    endfunction
    
    function s:get_project_root() abort
      let l:git_root = ''
      let l:path = expand('%:p:h')
      let l:cmd = systemlist('cd '.l:path.' && git rev-parse --show-toplevel')
      if !v:shell_error && !empty(l:cmd)
        let l:git_root = fnamemodify(l:cmd[0], ':p:h')
      endif
    
      if !empty(l:git_root)
        return l:git_root
      endif
    
      return getcwd()
    endfunction
    
    function! s:defx_open(...) abort
      let l:opts = get(a:, 1, {})
      let l:is_file = has_key(l:opts, 'dir') && !isdirectory(l:opts.dir)
    
      if  &filetype ==? 'defx' || l:is_file
        return
      endif
    
      let l:path = s:get_project_root()
    
      if has_key(l:opts, 'dir') && isdirectory(l:opts.dir)
        let l:path = l:opts.dir
      endif
    
      let l:args = '-winwidth=40 -direction=topleft -split=vertical'
    
      if has_key(l:opts, 'find_current_file')
        call execute(printf('Defx %s -search=%s %s', l:args, expand('%:p'), l:path))
      else
        call execute(printf('Defx -toggle %s %s', l:args, l:path))
        call execute('wincmd p')
      endif
    
      return execute("norm!\<C-w>=")
    endfunction
    
    function! s:defx_context_menu() abort
      let l:actions = ['new_multiple_files', 'rename', 'copy', 'move', 'paste', 'remove']
      let l:selection = confirm('Action?', "&New file/directory\n&Rename\n&Copy\n&Move\n&Paste\n&Delete")
      silent exe 'redraw'
    
      return feedkeys(defx#do_action(l:actions[l:selection - 1]))
    endfunction
    
    function s:defx_toggle_tree() abort
      if defx#is_directory()
        return defx#do_action('open_or_close_tree')
      endif
      return defx#do_action('drop')
    endfunction
    
    function! s:defx_mappings() abort
      nnoremap <silent><buffer>m :call <sid>defx_context_menu()<CR>
      nnoremap <silent><buffer><expr> o <sid>defx_toggle_tree()
      nnoremap <silent><buffer><expr> O defx#do_action('open_tree_recursive')
      nnoremap <silent><buffer><expr> <CR> <sid>defx_toggle_tree()
      nnoremap <silent><buffer><expr> <2-LeftMouse> <sid>defx_toggle_tree()
      nnoremap <silent><buffer><expr> C defx#is_directory() ? defx#do_action('multi', ['open', 'change_vim_cwd']) : 'C'
      nnoremap <silent><buffer><expr> s defx#do_action('open', 'botright vsplit')
      nnoremap <silent><buffer><expr> R defx#do_action('redraw')
      nnoremap <silent><buffer><expr> U defx#do_action('multi', [['cd', '..'], 'change_vim_cwd'])
      nnoremap <silent><buffer><expr> H defx#do_action('toggle_ignored_files')
      nnoremap <silent><buffer><expr> <Space> defx#do_action('toggle_select') . 'j'
      nnoremap <silent><buffer><expr> j line('.') == line('$') ? 'gg' : 'j'
      nnoremap <silent><buffer><expr> k line('.') == 1 ? 'G' : 'k'
      nnoremap <silent><buffer> J :call search('')<CR>
      nnoremap <silent><buffer> K :call search('', 'b')<CR>
      nnoremap <silent><buffer><expr> yy defx#do_action('yank_path')
      nnoremap <silent><buffer><expr> q defx#do_action('quit')
      silent exe 'nnoremap <silent><buffer><expr> tt defx#do_action("toggle_columns", "'.s:default_columns.':size:time")'
    endfunction
    
    " Defx git
    let g:defx_git#indicators = {
      \ 'Modified'  : '✹',
      \ 'Staged'    : '✚',
      \ 'Untracked' : '✭',
      \ 'Renamed'   : '➜',
      \ 'Unmerged'  : '═',
      \ 'Ignored'   : '☒',
      \ 'Deleted'   : '✖',
      \ 'Unknown'   : '?'
      \ }
    let g:defx_git#column_length = 0
    hi def link Defx_filename_directory NERDTreeDirSlash
    hi def link Defx_git_Modified Special
    hi def link Defx_git_Staged Function
    hi def link Defx_git_Renamed Title
    hi def link Defx_git_Unmerged Label
    hi def link Defx_git_Untracked Tag
    hi def link Defx_git_Ignored Comment
    
    " Defx icons
    " Requires nerd-font, install at https://github.com/ryanoasis/nerd-fonts or
    " brew cask install font-hack-nerd-font
    " Then set non-ascii font to Driod sans mono for powerline in iTerm2
    " disbale syntax highlighting to prevent performence issue
    let g:defx_icons_enable_syntax_highlight = 1


" FZF
    let $FZF_DEFAULT_COMMAND = 'rg --files --follow -g "!{.git,node_modules}/*" 2>/dev/null'
    let g:fzf_layout = { 'down': '~25%' }
    let g:fzf_buffers_jump = 1
    let g:fzf_tags_command = 'ctags -R'


    if isdirectory(".git")
        " if in a git project, use :GFiles
        nmap <silent> <leader>f :GFiles --cached --others --exclude-standard<cr>
    else
        " otherwise, use :FZF
        nmap <silent> <leader>f :FZF<cr>
    endif

    "nmap <silent> <leader>s :GFiles?<cr>
    nmap <silent> <leader>s :GFiles --cached --others --exclude-standard<cr>
    "nmap <silent> <leader>r :Buffers<cr>
    nmap ; :Buffers<cr>
    nmap <silent> <leader>e :FZF<cr>
    nmap <leader><tab> <plug>(fzf-maps-n)
    xmap <leader><tab> <plug>(fzf-maps-x)
    omap <leader><tab> <plug>(fzf-maps-o)

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


" ALE
    "仅仅在保存的时候跑 ale
    "let g:ale_lint_on_text_changed = 'normal'
    let g:ale_lint_on_text_changed = 'never'
    " You can disable this option too
    " if you don't want linters to run on opening a file
    let g:ale_lint_on_enter = 1

    let g:ale_set_highlights = 1
    "let g:ale_change_sign_column_color = 1


    " 关闭本地列表,使用 quickfix
    let g:ale_set_loclist = 0
    let g:ale_set_quickfix = 1
    "let g:ale_list_vertical = 1
    "let g:ale_open_list = 1

    let g:ale_sign_column_always = 0
    "let g:ale_sign_error = '✖'
    "let g:ale_sign_warning = '⚠'
    let g:ale_sign_error = '🔥'
    let g:ale_sign_warning = '🤔'
    let g:ale_echo_msg_error_str = '✖'
    let g:ale_echo_msg_warning_str = '⚠'
    let g:ale_echo_msg_format = '[%linter%] %code: %%s [%severity%]'
    "let g:ale_echo_msg_format = '%severity% %s [%linter%% %code%]'

    " 下降低语法检查程序的进程优先级（不要卡到前台进程）
    "let g:ale_command_wrapper = 'nice -n5'



    " for golang
    "let g:ale_linters = {'go': ['golint','govet','gobuild','gopls'],'python': ['flake8','pylint']}
    "let g:ale_linters = {'go': ['gopls','golint'],'python': ['flake8','pylint']}
    let g:ale_linters = {'go': ['golangci-lint'],'python': ['flake8','pylint']}
    let b:ale_fixers = {'python':['autopep8', 'yapf']}
    let g:ale_go_golangci_lint_options = '--fast --disable=errcheck --disable=deadcode --disable=ineffassign'
    let g:ale_go_golangci_lint_package = 1
    "let g:ale_go_gometalinter_options = '--fast --disable=gas --disable=goconst --disable=gocyclo --deadline=1s'
    "let g:ale_go_gometalinter_options = '--fast'
    "let g:ale_go_gometalinter_lint_package = 1
    let g:ale_python_flake8_options="--ignore=E114,E116,E131 --max-line-length=120"

    let g:ale_fixers = {}
    let g:ale_fixers['javascript'] = ['prettier']
    let g:ale_fixers['typescript'] = ['prettier', 'tslint']
    let g:ale_fixers['json'] = ['prettier']
    let g:ale_fixers['css'] = ['prettier']
    " fixers 由 vim-go 暂时接管
    let g:ale_fixers['go'] = []
    "let g:ale_fixers['golang'] = ['gofmt', 'goimports']
    let g:ale_javascript_prettier_use_local_config = 1
    let g:ale_fix_on_save = 1

    " 打开 ale 错误列表
    function! AleListToggle()
        if !exists('g:ale_open_list')
            return
        endif
        if(g:ale_open_list == 0) 
            ALEDisableBuffer 
            let g:ale_open_list = 1
            ALEEnableBuffer
        else
            let g:ale_open_list = 0
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

" Autoclose ------------------------------
"    " Fix to let ESC work as espected with Autoclose plugin
"    let g:AutoClosePumvisible = {"ENTER": "\<C-Y>", "ESC": "\<ESC>"}

" Signify ------------------------------
" 通过 coc 控制
"    let g:signify_vcs_list = [ 'git' ]
"    let g:signify_sign_add               = '┃'
"    let g:signify_sign_delete            = '-'
"    let g:signify_sign_delete_first_line = '_'
"    let g:signify_sign_change = '┃'


" Window Chooser ------------------------------

    " mapping
    nmap  -  <Plug>(choosewin)
    " show big letters
    let g:choosewin_overlay_enable = 1

" Airline ------------------------------

    
    let g:airline_powerline_fonts = 1
    " let g:airline_theme = 'bubblegum'
    let g:airline_theme = 'gruvbox'
    
    if !exists('g:airline_symbols')
       let g:airline_symbols = {}
    endif
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

    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#formatter = 'default'

    " 开启 coc 或 ale 支持
    let g:airline#extensions#coc#enabled = 1
    let g:airline#extensions#ale#enabled = 1

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

" coc.vim -----------------------------------------------
        " coc-prettier
        command! -nargs=0 Prettier :CocCommand prettier.formatFile
        nmap <leader>f :CocCommand prettier.formatFile<cr>

        "" coc tab 补全
        inoremap <silent><expr> <TAB>
              \ pumvisible() ? "\<C-n>" :
              \ <SID>check_back_space() ? "\<TAB>" :
              \ coc#refresh()
        inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
        
        function! s:check_back_space() abort
          let col = col('.') - 1
          return !col || getline('.')[col - 1]  =~# '\s'
        endfunction

        " Use <c-space> to trigger completion.
        inoremap <silent><expr> <c-space> coc#refresh()

        " 使用 回车 确认补全 Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
        " Coc only does snippet and additional edit on confirm.
        " inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
        " Or use `complete_info` if your vim support it, like:
        inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
        
       " Use `[g` and `]g` to navigate diagnostics
        nmap <silent> [g <Plug>(coc-diagnostic-prev)
        nmap <silent> ]g <Plug>(coc-diagnostic-next)
        
        "remap keys for gotos
        nmap <silent> gd <Plug>(coc-definition)
        nmap <silent> gy <Plug>(coc-type-definition)
        nmap <silent> gi <Plug>(coc-implementation)
        nmap <silent> gr <Plug>(coc-references)
        nmap <silent> gh <Plug>(coc-doHover)
        
        nnoremap <silent> K :call <SID>show_documentation()<CR>

        " Highlight symbol under cursor on CursorHold
        autocmd CursorHold * silent call CocActionAsync('highlight')
        
        function! s:show_documentation()
            if (index(['vim','help'], &filetype) >= 0)
                execute 'h '.expand('<cword>')
            else
                call CocAction('doHover')
            endif
        endfunction

        augroup coc
          autocmd!
          " Setup formatexpr specified filetype(s).
          autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
          " Update signature help on jump placeholder
          autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
        augroup end

        "" Using CocList
        "" Show all diagnostics
        "nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
        "" Manage extensions
        "nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
        "" Show commands
        "nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
        "" Find symbol of current document
        "nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
        "" Search workspace symbols
        "nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
        "" Do default action for next item.
        "nnoremap <silent> <space>j  :<C-u>CocNext<CR>
        "" Do default action for previous item.
        "nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
        "" Resume latest coc list
        "nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

        let g:coc_global_extensions = [
                \ 'coc-css',
                \ 'coc-json',
                \ 'coc-git',
                \ 'coc-pairs',
                \ 'coc-emoji',
                \ 'coc-vimlsp',
                \ 'coc-emmet',
                \ 'coc-prettier'
                \ ]





" vim-go 相关配置 --------------------------
      " 关闭 vim-go 的 gd :GoDef 由 coc 接管
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

      let g:go_decls_mode = 'fzf'

      " 关闭 vim-go 的 linter 
      let g:go_metalinter_autosave = 0
      let g:go_metalinter_autosave_enabled = ['golint', 'vet']
    
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
      "autocmd FileType go nmap <Leader>r <Plug>(go-run)
      "autocmd FileType go nmap <Leader>b <Plug>(go-build)
      "autocmd FileType go nmap <Leader>t <Plug>(go-test)
      "autocmd FileType go nmap <Leader>i <Plug>(go-info)
      "autocmd FileType go nmap <Leader>s <Plug>(go-implements)
      autocmd FileType go nmap <Leader>c <Plug>(go-coverage)
      autocmd FileType go nmap <Leadee <Plug>(go-rename)
      autocmd FileType go nmap <Leader>gi <Plug>(go-imports)
      autocmd FileType go nmap <Leader>gI <Plug>(go-install)
      "autocmd FileType go nmap <Leader>gd <Plug>(go-doc)
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

    
" Startify: Fancy startup screen for vim {{{
    " Don't change to directory when selecting a file
    let g:startify_files_number = 5
    let g:startify_change_to_dir = 0
    let g:startify_custom_header = [ ]
    let g:startify_relative_path = 1
    let g:startify_use_env = 1

    function! s:list_commits()
        let git = 'git -C ' . getcwd()
        let commits = systemlist(git . ' log --oneline | head -n5')
        let git = 'G' . git[1:]
        return map(commits, '{"line": matchstr(v:val, "\\s\\zs.*"), "cmd": "'. git .' show ". matchstr(v:val, "^\\x\\+") }')
    endfunction

    " Custom startup list, only show MRU from current directory/project
    let g:startify_lists = [
    \  { 'type': 'dir',       'header': [ 'Files '. getcwd() ] },
    \  { 'type': function('s:list_commits'), 'header': [ 'Recent Commits' ] },
    \  { 'type': 'sessions',  'header': [ 'Sessions' ]       },
    \  { 'type': 'bookmarks', 'header': [ 'Bookmarks' ]      },
    \  { 'type': 'commands',  'header': [ 'Commands' ]       },
    \ ]

    let g:startify_commands = [
    \   { 'up': [ 'Update Plugins', ':PlugUpdate' ] },
    \   { 'ug': [ 'Upgrade Plugin Manager', ':PlugUpgrade' ] },
    \ ]

    let g:startify_bookmarks = [
        \ { 'c': '~/code/dotfiles/config/nvim/init.vim' },
        \ { 'z': '~/code/dotfiles/zsh/zshrc.symlink' }
    \ ]

    autocmd User Startified setlocal cursorline
    nmap <leader>st :Startify<cr>
    
" ----------------------------------------------------------------------------
" 杂七杂八
" ----------------------------------------------------------------------------

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
    "let g:onedark_termcolors=16
    "let g:onedark_terminal_italics=1
    "colorscheme onedark
    colorscheme gruvbox
    "colorscheme dracula
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1

    " syntax highlight on and filetype reload
    syntax on
    filetype plugin indent on


augroup CloseLoclistWindowGroup
    autocmd!
    autocmd QuitPre * if empty(&buftype) | lclose | endif
augroup END

" Reloads vimrc after saving but keep cursor position
"if !exists('*ReloadVimrc')
"   fun! ReloadVimrc()
"       let save_cursor = getcurpos()
"       source $MYVIMRC
"       call setpos('.', save_cursor)
"   endfun
"endif
"autocmd! BufWritePost $MYVIMRC call ReloadVimrc()

" 自动刷新文件 
if ! exists("g:CheckUpdateStarted")
    let g:CheckUpdateStarted=1
    call timer_start(1,'CheckUpdate')
endif
function! CheckUpdate(timer)
    silent! checktime
    call timer_start(1000,'CheckUpdate')
endfunction

autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')

" Enter automatically into the files directory
autocmd BufEnter * silent! lcd %:p:h

