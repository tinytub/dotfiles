" Key-mappings

"" Elite-mode {{{
" ----------
if get(g:, 'elite_mode')

	" Disable arrow movement, resize splits instead.
	nnoremap <silent><Up>    :resize +1<CR>
	nnoremap <silent><Down>  :resize -1<CR>
	nnoremap <silent><Left>  :vertical resize +1<CR>
	nnoremap <silent><Right> :vertical resize -1<CR>

endif
" ===
    nnoremap <C-s> :<C-u>write<CR>

    " Editor UI
    " nmap <Leader>tn :setlocal nonumber!<CR>

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

" Windows, buffers and tabs {{{
" -------------------------
" Window-control prefix
nnoremap  [Window]   <Nop>
nmap      s [Window]

nnoremap <silent><C-w>z :vert resize<CR>:resize<CR>:normal! ze<CR>
nnoremap <silent> [Window]v  :<C-u>split<CR>
nnoremap <silent> [Window]g  :<C-u>vsplit<CR>
nnoremap <silent> [Window]t  :tabnew<CR>
nnoremap <silent> [Window]o  :<C-u>only<CR>
nnoremap <silent> [Window]b  :b#<CR>
nnoremap <silent> [Window]c  :close<CR>
nnoremap <silent> [Window]x  :<C-u>call <SID>window_empty_buffer()<CR>

" Split current buffer, go to previous window and previous buffer
nnoremap <silent> [Window]sv :split<CR>:wincmd p<CR>:e#<CR>
nnoremap <silent> [Window]sg :vsplit<CR>:wincmd p<CR>:e#<CR>

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

    " settings for resize splitted window
    "nmap <C-w>[ :vertical resize -3<CR>
    "nmap <C-w>] :vertical resize +3<CR>

    "buffer 切换
    nnoremap  [b :<C-u>bp<CR>
    nnoremap  ]b :<C-u>bn<CR>

    "delete buffer
    "nnoremap <C-x> :<C-u>BD<CR>
    nnoremap <C-x> :<C-u>bd<CR>

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
    "nmap <Leader>ss :<C-u>SessionSave<CR>
    "nmap <Leader>sl :<C-u>SessionLoad<CR>

    " Whitespace jump (see plugin/whitespace.vim)
    nnoremap ]w :<C-u>WhitespaceNext<CR>
    nnoremap [w :<C-u>WhitespacePrev<CR>
		" Remove spaces at the end of lines
    nnoremap <silent> <Space>/ :<C-u>silent! keeppatterns %substitute/\s\+$//e<CR>
    nnoremap <silent> <Space>cw :<C-u>silent! keeppatterns %substitute/\s\+$//e<CR>

" Scroll step sideways
nnoremap zl z4l
nnoremap zh z4h

" Resize tab windows after top/bottom window movement
"nnoremap <C-w>K <C-w>K<C-w>=
"nnoremap <C-w>J <C-w>J<C-w>=


" Non-standard
" ---
" vim: set foldmethod=marker ts=2 sw=2 tw=80 noet :
