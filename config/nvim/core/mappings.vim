" Key-mappings
" ===
    " 关闭最后一次查询的高亮
    nnoremap <F2> :set hlsearch!<CR>

    " 取消查询结果高亮
    nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

    " tab 导航 按键映射
    noremap <leader>tn :tabnew<cr>
    noremap <leader>te :tabedit
    noremap <leader>tm :tabmove

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
    nnoremap j gj
    nnoremap gj j
    nnoremap k gk
    nnoremap gk k

    "buffer 切换
    nnoremap  ]b :bp<CR>
    nnoremap  [b :bn<CR>
    "delete buffer
    nnoremap <C-x>  :bd<CR>

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

    " Improve scroll, credits: https://github.com/Shougo
    nnoremap <expr> zz (winline() == (winheight(0)+1) / 2) ?
	\ 'zt' : (winline() == 1) ? 'zb' : 'zz'
    noremap <expr> <C-f> max([winheight(0) - 2, 1])
	\ ."\<C-d>".(line('w$') >= line('$') ? "L" : "M")
    noremap <expr> <C-b> max([winheight(0) - 2, 1])
	\ ."\<C-u>".(line('w0') <= 1 ? "H" : "M")
    noremap <expr> <C-e> (line("w$") >= line('$') ? "j" : "3\<C-e>")
    noremap <expr> <C-y> (line("w0") <= 1         ? "k" : "3\<C-y>")




" Non-standard
" ---
