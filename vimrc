scriptencoding utf-8

" Set main configuration directory, and where cache is stored.

let $VARPATH = expand(($XDG_CACHE_HOME ? $XDG_CACHE_HOME : '~/.cache').'/vim')

" Write history on idle, for sharing among different sessions
" autocmd MyAutoCmd CursorHold * if exists(':rshada') | rshada | wshada | endif

" Search and use environments specifically made for Neovim.
if isdirectory($VARPATH.'/venv/neovim2')
    let g:python_host_prog = $VARPATH.'/venv/neovim2/bin/python'
endif
if isdirectory($VARPATH.'/venv/neovim3')
    let g:python3_host_prog = $VARPATH.'/venv/neovim3/bin/python'
endif

" no vi-compatible
set nocompatible

" clipboard 配置
if has('unnamedplus')
  set clipboard^=unnamed
  set clipboard^=unnamedplus
endif

" vim-plug 自动更新
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

filetype off
filetype plugin indent on

" default map leader '\'

" ============================================================================
" Active plugins
" You can disable or add new ones here:

call plug#begin('~/.vim/plugged')

" Plugins from github repos:

" Better file browser
Plug 'scrooloose/nerdtree'
" Code commenter
Plug 'scrooloose/nerdcommenter'
" Class/module browser
Plug 'majutsushi/tagbar'
" Code and files fuzzy finder
Plug 'kien/ctrlp.vim'
" Extension to ctrlp, for fuzzy command finder
Plug 'fisadev/vim-ctrlp-cmdpalette'
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
Plug 'rosenfeld/conque-term'
" Pending tasks list
Plug 'fisadev/FixedTaskList.vim'
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
Plug 'zchee/deoplete-go' , { 'do': 'make'}

" python 补全插件
Plug 'davidhalter/jedi-vim' , {'for': ['python', 'python3']}
Plug 'zchee/deoplete-jedi', {'for': ['python', 'python3']}


" Snippets manager (SnipMate), dependencies, and snippets repo
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'honza/vim-snippets'
Plug 'garbas/vim-snipmate'
" awesome colorscheme
" Plugin 'joshdick/onedark.vim'
Plug 'morhetz/gruvbox'
" gruvbox 如果颜色不对,尝试执行~/.vim/bundle/gruvbox/gruvbox_256palette.sh 或 ~/.vim/bundle/gruvbox/gruvbox_256palette_osx.sh
"Plugin 'altercation/solarized'

" Git/mercurial/others diff icons on the side of the file lines
Plug 'mhinz/vim-signify'
" Automatically sort python imports
Plug 'fisadev/vim-isort'
" Drag visual blocks arround
Plug 'fisadev/dragvisuals.vim'
" Window chooser
Plug 't9md/vim-choosewin'
" Python and other languages code checker
Plug 'scrooloose/syntastic'
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
Plug 'fatih/vim-go'
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

" Plugins from vim-scripts repos:

"" Search results counter
"Plugin 'IndexedSearch'
" XML/HTML tags navigation
"Plugin 'matchit.zip'
" Gvim colorscheme
"Plugin 'Wombat'
" Yank history navigation 复制历史记录工具？
"Plugin 'YankRing.vim'

" html/js/css 格式化
" 需要cd ~/.vim/bundle/vim-jsbeautify && git submodule update --init --recursive
" 下载 js 库 wget https://github.com/beautify-web/js-beautify/archive/master.zip && unzip master.zip && cp -rf js-beautify-master/ /home/zhaopeng-iri/.vim/bundle/js-beautify/
" Plug 'maksimr/vim-jsbeautify'
call plug#end()


" tabs and spaces handling
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
" highlight cursor line and column
" set cursorline
" set cursorcolumn
" hidden startup messages
set shortmess=atI
" auto read and write
set autowrite
set autoread
" when deal with unsaved files ask what to do
set confirm
" no backup files
set nobackup
" other settings 
set langmenu=zh_CN.UTF-8
set mouse-=a
set whichwrap+=<,>,h,l,[,]
set background=dark
set encoding=utf-8

set backspace=2 " make backspace work like most other apps
set backspace=indent,eol,start

" tab length exceptions on some file types
 autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
 autocmd FileType htmldjango setlocal shiftwidth=2 tabstop=2 softtabstop=2
 autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2

" auto open or close NERDTree
autocmd vimenter * if !argc() | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" always show status bar
set laststatus=2

" incremental search
set incsearch
" highlighted search results
set hlsearch
" search ignore case
set ignorecase
" muting search highlighting 
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>
" 进入搜索Use sane regexes"
"nnoremap / /\v
"vnoremap / /\v

" 打开自动定位到最后编辑的位置, 需要确认 .viminfo 当前用户可写
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" syntax highlight on
syntax on

" show line numbers
set nu

" tab navigation mappings
map tn :tabn<CR>
map tp :tabp<CR>
map tm :tabm 
map tt :tabnew 
map ts :tab split<CR>
map <C-S-Right> :tabn<CR>
imap <C-S-Right> <ESC>:tabn<CR>
map <C-S-Left> :tabp<CR>
imap <C-S-Left> <ESC>:tabp<CR>

" navigate windows with meta+arrows
map <M-Right> <c-w>l
map <M-Left> <c-w>h
map <M-Up> <c-w>k
map <M-Down> <c-w>j
imap <M-Right> <ESC><c-w>l
imap <M-Left> <ESC><c-w>h
imap <M-Up> <ESC><c-w>k
imap <M-Down> <ESC><c-w>j

" old autocomplete keyboard shortcut
"imap <C-J> <C-X><C-O>

" 分屏窗口移动, Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" disbale paste mode when leaving insert mode
au InsertLeave * set nopaste

" 自动set paset
" Automatically set paste mode in Vim when pasting in insert mode
function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()


" Comment this line to enable autocompletion preview window
" (displays documentation related to the selected completion option)
" Disabled by default because preview makes the window flicker
set completeopt-=preview

" save as sudo
ca w!! w !sudo tee "%"

" simple recursive grep
" both recursive grep commands with internal or external (fast) grep
command! -nargs=1 RecurGrep lvimgrep /<args>/gj ./**/*.* | lopen | set nowrap
command! -nargs=1 RecurGrepFast silent exec 'lgrep! <q-args> ./**/*.*' | lopen
" mappings to call them
nmap ,R :RecurGrep 
nmap ,r :RecurGrepFast 
" mappings to call them with the default word as search text
nmap ,wR :RecurGrep <cword><CR>
nmap ,wr :RecurGrepFast <cword><CR>


" use 256 colors when possible
if has('nvim')
  set termguicolors
  colorscheme gruvbox
else
  if &term =~? 'mlterm\|xterm\|xterm-256\|screen-256'
      let &t_Co = 256
      "colorscheme onedark
      "colorscheme solarized
      colorscheme gruvbox
  else
      "colorscheme delek
      colorscheme gruvbox
  endif
endif

" colors for gvim
if has('gui_running')
    "colorscheme wombat
    colorscheme wombat
endif

" when scrolling, keep cursor 3 lines away from screen border
set scrolloff=3

" autocompletion of files and commands behaves like zsh
" (autocomplete menu)
set wildmenu
set wildmode=full

" better backup, swap and undos storage
set directory=~/.vim/dirs/tmp     " directory to place swap files in
set backup                        " make backup files
set backupdir=~/.vim/dirs/backups " where to put backup files
set undofile                      " persistent undos - undo after you re-open the file
set undodir=~/.vim/dirs/undos
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

" ============================================================================
" Plugins settings and mappings
" Edit them as you wish.

" Tagbar ----------------------------- 

" toggle tagbar display
map <F4> :TagbarToggle<CR>
" autofocus on tagbar open
let g:tagbar_autofocus = 1

" NERDTree ----------------------------- 

" toggle nerdtree display
map <F3> :NERDTreeToggle<CR>
" open nerdtree with the current file selected
nmap ,t :NERDTreeFind<CR>
" don;t show these file types
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']


" Tasklist ------------------------------

" show pending tasks list
map <F2> :TaskList<CR>

" CtrlP ------------------------------

" file finder mapping
let g:ctrlp_map = ',e'
" hidden some types files
let g:ctrlp_show_hidden = 1
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.png,*.jpg,*.gif           "Linux
" tags (symbols) in current file finder mapping
nmap ,g :CtrlPBufTag<CR>
" tags (symbols) in all files finder mapping
nmap ,G :CtrlPBufTagAll<CR>
" general code finder in all files mapping
nmap ,f :CtrlPLine<CR>
" recent files finder mapping
nmap ,m :CtrlPMRUFiles<CR>
" commands finder mapping
nmap ,c :CtrlPCmdPalette<CR>
" to be able to call CtrlP with default search text
function! CtrlPWithSearchText(search_text, ctrlp_command_end)
    execute ':CtrlP' . a:ctrlp_command_end
    call feedkeys(a:search_text)
endfunction
" same as previous mappings, but calling with current word as default text
nmap ,wg :call CtrlPWithSearchText(expand('<cword>'), 'BufTag')<CR>
nmap ,wG :call CtrlPWithSearchText(expand('<cword>'), 'BufTagAll')<CR>
nmap ,wf :call CtrlPWithSearchText(expand('<cword>'), 'Line')<CR>
nmap ,we :call CtrlPWithSearchText(expand('<cword>'), '')<CR>
nmap ,pe :call CtrlPWithSearchText(expand('<cfile>'), '')<CR>
nmap ,wm :call CtrlPWithSearchText(expand('<cword>'), 'MRUFiles')<CR>
nmap ,wc :call CtrlPWithSearchText(expand('<cword>'), 'CmdPalette')<CR>
" don't change working directory
let g:ctrlp_working_path_mode = 0
" ignore these files and folders on file finder
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|\.hg|\.svn)$',
  \ 'file': '\.pyc$\|\.pyo$',
  \ }

" Syntastic ------------------------------

" show list of errors and warnings on the current file
nmap <leader>e :Errors<CR>
" turn to next or previous errors, after open errors list
nmap <leader>n :lnext<CR>
nmap <leader>p :lprevious<CR>
" 通过 :Sc 命令进行语法检测
:command! Sc :SyntasticCheck 
" check also when just opened the file
" 太慢了，打开文件时不自动加载
let g:syntastic_check_on_open = 0
" 也不要每次保存的时候尝试加载，等我手动出发好了
let g:syntastic_check_on_wq = 0 
" 保持被动模式
let g:syntastic_mode_map = {'mode': 'passive'} 
" syntastic checker for javascript.
" eslint is the only tool support JSX.
" If you don't need write JSX, you can use jshint.
" And eslint is slow, but not a hindrance
" let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_javascript_checkers = ['eslint']
" python 好多检测插件，加载速度太慢了。。。只加载 pylint 好了
" let g:syntastic_disabled_filetypes=['python']
let g:syntastic_python_checkers = ['pylint']
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
" don't put icons on the sign column (it hides the vcs status icons of signify)
let g:syntastic_enable_signs = 0
" custom icons (enable them if you use a patched font, and enable the previous 
" setting)
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_style_error_symbol = '✗'
let g:syntastic_style_warning_symbol = '⚠'

" deoplete 相关配置
" ---
" let g:deoplete#enable_profile = 1
" call deoplete#enable_logging('DEBUG', 'deoplete.log')<CR>
" call deoplete#custom#source('tern', 'debug_enabled', 1)<CR>
" " General settings " {{{ 参考https://github.com/rafi/vim-config/config/plugins/deoplete.vim
" ---
" let g:deoplete#auto_complete_delay = 50  " Default is 50
" let g:deoplete#auto_refresh_delay = 500  " Default is 500
" let g:deoplete#auto_complete_delay = 50  " Default is 50
" let g:deoplete#auto_refresh_delay = 500  " Default is 500

let g:deoplete#enable_refresh_always = 1
let g:deoplete#enable_camel_case = 1
let g:deoplete#max_abbr_width = 35
let g:deoplete#max_menu_width = 20
let g:deoplete#skip_chars = ['(', ')', '<', '>']
let g:deoplete#tag#cache_limit_size = 800000
let g:deoplete#file#enable_buffer_path = 1

let g:deoplete#sources#jedi#statement_length = 30
let g:deoplete#sources#jedi#show_docstring = 1
let g:deoplete#sources#jedi#short_types = 1

let g:deoplete#sources#ternjs#filetypes = [
    \ 'jsx',
    \ 'javascript.jsx',
    \ 'vue',
    \ 'javascript'
    \ ]

let g:deoplete#sources#ternjs#timeout = 3
let g:deoplete#sources#ternjs#types = 1
let g:deoplete#sources#ternjs#docs = 1

call deoplete#custom#source('_', 'min_pattern_length', 2)

" }}}
" Limit Sources " {{{
" ---

"let g:deoplete#sources = get(g:, 'deoplete#sources', {})
"let g:deoplete#sources.go = ['vim-go']
"let g:deoplete#ignore_sources = get(g:, 'deoplete#ignore_sources', {})


" deoplete 我的 go 相关配置
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#go#gocode_binary = '$GOPATH/bin/gocode'
" let g:deoplete#file#enable_buffer_path=1
let g:deoplete#sources#go#pointer = 1
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const', 'pointer']
let g:deoplete#keyword_patterns={}
"let g:deoplete#keyword_patterns.clojure='[\w!$%&*+/:<=>?@\^_~\-\.]*'

"inoremap <silent><expr> <TAB>
"    \ pumvisible() ? "\<C-n>" :
"    \ <SID>check_back_space() ? "\<TAB>" :
"    \ deoplete#mappings#manual_complete()
"function! s:check_back_space() abort "{{{
"    let col = col('.') - 1
"    return !col || getline('.')[col - 1]  =~ '\s'
"endfunction"}}}

" <Tab> completion:
" 1. If popup menu is visible, select and insert next item
" 2. Otherwise, if within a snippet, jump to next input
" 3. Otherwise, if preceding chars are whitespace, insert tab char
" 4. Otherwise, start manual autocomplete
imap <silent><expr><Tab> pumvisible() ? "\<Down>"
    \ : (<SID>is_whitespace() ? "\<Tab>"
    \ : deoplete#manual_complete())

smap <silent><expr><Tab> pumvisible() ? "\<Down>"
    \ : (<SID>is_whitespace() ? "\<Tab>"
    \ : deoplete#manual_complete())

inoremap <expr><S-Tab>  pumvisible() ? "\<Up>" : "\<C-h>"

function! s:is_whitespace()
    let col = col('.') - 1
    return ! col || getline('.')[col - 1] =~? '\s'
endfunction

" }}}

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
" nicer colors
highlight DiffAdd           cterm=bold ctermbg=none ctermfg=119
highlight DiffDelete        cterm=bold ctermbg=none ctermfg=167
highlight DiffChange        cterm=bold ctermbg=none ctermfg=227
highlight SignifySignAdd    cterm=bold ctermbg=237  ctermfg=119
highlight SignifySignDelete cterm=bold ctermbg=237  ctermfg=167
highlight SignifySignChange cterm=bold ctermbg=237  ctermfg=227

" Window Chooser ------------------------------

" mapping
nmap  -  <Plug>(choosewin)
" show big letters
let g:choosewin_overlay_enable = 1

" Airline ------------------------------

let g:airline_powerline_fonts = 1
" let g:airline_theme = 'bubblegum'
let g:airline_theme = 'gruvbox'
"let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#whitespace#enabled = 1

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

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" new file set title and turn to endline
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

augroup go
  autocmd!
  " vim-go related mappings
  autocmd FileType go nmap <Leader>r <Plug>(go-run)
  autocmd FileType go nmap <Leader>b <Plug>(go-build)
  autocmd FileType go nmap <Leader>t <Plug>(go-test)
  autocmd FileType go nmap <Leader>i <Plug>(go-info)
  autocmd FileType go nmap <Leader>s <Plug>(go-implements)
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
  autocmd FileType go syntax sync minlines=256
  autocmd FileType go set synmaxcol=128
  autocmd FileType go set re=1
  autocmd FileType go set lazyredraw
  autocmd FileType go set ttyfast
augroup END

"if &filetype == 'go'
  let g:go_autodetect_gopath = 1
  let g:go_list_type = "quickfix"
  let g:go_auto_type_info = 1
  "let g:go_info_mode = 'guru'
  "guru 在当前版本进行 go to def 会有问题,暂时用 godef 代替
  let g:go_def_mode = 'godef'
  set updatetime=100

  let g:go_fmt_command = "goimports"
  let g:go_fmt_experimental = 0
  let g:go_dispatch_enabled = 0 " vim-dispatch needed
  "let g:go_metalinter_autosave = 1
  "let g:go_metalinter_autosave_enabled = ['vet', 'golint']
  "let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
  let g:go_term_enabled = 0
  " 自动添加标签
  let g:go_addtags_transform = "snakecase"
  let g:go_term_mode = "vertical"

  let g:go_highlight_types = 1
  let g:go_highlight_fields = 1
  let g:go_highlight_functions = 1
  let g:go_highlight_function_calls = 1
  let g:go_highlight_interfaces = 1
  let g:go_highlight_methods = 1
  let g:go_highlight_structs = 1
  let g:go_highlight_operators = 1
  let g:go_highlight_build_constraints = 1
  let g:go_highlight_chan_whitespace_error = 1
  let g:go_highlight_extra_types = 1
  let g:go_highlight_generate_tags = 1
"endif

"if &filetype == 'python'
"  hook_add: |
"    let g:jedi#completions_enabled = 0
"    let g:jedi#auto_vim_configuration = 0
"    let g:jedi#smart_auto_mappings = 0
"    let g:jedi#show_call_signatures = 1
"  hook_source: |
"    let g:jedi#use_tag_stack = 0
"    let g:jedi#popup_select_first = 0
"    let g:jedi#popup_on_dot = 0
"    let g:jedi#max_doc_height = 100
"    let g:jedi#quickfix_window_height = 10
"    let g:jedi#use_splits_not_buffers = 'right'
    let g:jedi#auto_vim_configuration = 0
    let g:jedi#auto_configuration = 0
    " 禁用自动补全
    let g:jedi#completions_enabled = 0
    let g:jedi#use_tabs_not_buffers = 1
    " 键位什么的
    let g:jedi#goto_command = "<leader>d"
    let g:jedi#goto_assignments_command = "<leader>g"
    " goto_definitions_command 已废弃，但是仍可使用
    let g:jedi#goto_definitions_command = "gd" 
    let g:jedi#documentation_command = "K"
    let g:jedi#usages_command = "<leader>n"
    let g:jedi#completions_command = "<C-Space>"
    let g:jedi#rename_command = "<leader>r"
"endif


" 前端 jsbeautify 命令
"augroup json,javascript,jsx,html,css
"  autocmd!
"  autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
"  " for json
"  autocmd FileType json noremap <buffer> <c-f> :call JsonBeautify()<cr>
"  " for jsx
"  autocmd FileType jsx noremap <buffer> <c-f> :call JsxBeautify()<cr>
"  " for html
"  autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
"  " for css or scss
"  autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>
"augroup END

" 解决 vim-multiple-cursors deoplete 冲突问题
function! Multiple_cursors_before()
  if exists(':NeoCompleteLock')==2
    exe 'NeoCompleteLock'
  endif
endfunction

function! Multiple_cursors_after()
  if exists(':NeoCompleteUnlock')==2
    exe 'NeoCompleteUnlock'
  endif
endfunction

" 回头添加 vim venv


" AutoGroups {{{
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
" }}}
" 

" Enter automatically into the files directory
autocmd BufEnter * silent! lcd %:p:h
