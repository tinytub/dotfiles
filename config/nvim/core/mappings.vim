" Key-mappings
" ===
    nnoremap <C-s> :<C-u>write<CR>

    " Editor UI
    nmap <Leader>tn :setlocal nonumber!<CR>


    " 关闭最后一次查询的高亮
    nnoremap <F2> :set hlsearch!<CR>

    " 取消查询结果高亮
    nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

   "" tab 导航 按键映射
   "noremap <leader>tn :tabnew<cr>
   "noremap <leader>te :tabedit
   "noremap <leader>tm :tabmove
   "
   "buffer
   nnoremap <leader>bc :BufOnly<CR>
   nnoremap <Leader>bo :BufOnly<Space>
   "yank to end
   nnoremap Y y$

   " window
   nnoremap <leader>ws :<C-u>sp<CR>
   nnoremap <leader>wv :<C-u>vs<CR>
   nnoremap <leader>wh <C-w>h
   nnoremap <leader>wj <C-w>j
   nnoremap <leader>wk <C-w>k
   nnoremap <leader>wl <C-w>l
   nnoremap <leader>wH <C-w>H
   nnoremap <leader>wJ <C-w>J
   nnoremap <leader>wK <C-w>K
   nnoremap <leader>wL <C-w>L
   nnoremap <leader>wx <C-w>x
   nnoremap <leader>wc <C-w>c
   nnoremap <leader>wo <C-w>o
   nnoremap <leader>wR <C-w>R

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

		" window
		nnoremap <leader>ws :<C-u>sp<CR>
		nnoremap <leader>wv :<C-u>vs<CR>
		nnoremap <leader>wh <C-w>h
		nnoremap <leader>wj <C-w>j
		nnoremap <leader>wk <C-w>k
		nnoremap <leader>wl <C-w>l
		nnoremap <leader>wH <C-w>H
		nnoremap <leader>wJ <C-w>J
		nnoremap <leader>wK <C-w>K
		nnoremap <leader>wL <C-w>L
		nnoremap <leader>wx <C-w>x
		nnoremap <leader>wc <C-w>c
		nnoremap <leader>wo <C-w>o
		nnoremap <leader>wR <C-w>R

    " settings for resize splitted window
    "nmap <C-w>[ :vertical resize -3<CR>
    "nmap <C-w>] :vertical resize +3<CR>

    "buffer 切换
    nnoremap  [b :<C-u>bp<CR>
    nnoremap  ]b :<C-u>bn<CR>
    "delete buffer
    nnoremap <C-x> :<C-u>BD<CR>
    "nnoremap <C-x> :<C-u>bd<CR>

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

    " Session management shortcuts (see plugin/sessions.vim)
    nmap <Leader>ss :<C-u>SessionSave<CR>
    nmap <Leader>sl :<C-u>SessionLoad<CR>

    " Whitespace jump (see plugin/whitespace.vim)
    nnoremap ]w :<C-u>WhitespaceNext<CR>
    nnoremap [w :<C-u>WhitespacePrev<CR>
		" Remove spaces at the end of lines
    nnoremap <silent> <Space>/ :<C-u>silent! keeppatterns %substitute/\s\+$//e<CR>
    nnoremap <silent> <Space>cw :<C-u>silent! keeppatterns %substitute/\s\+$//e<CR>




" Non-standard
" ---
" vim: set foldmethod=marker ts=2 sw=2 tw=80 noet :
