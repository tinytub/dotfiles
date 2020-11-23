augroup user_plugin_filetype
		autocmd!

 	" Reload vim config automatically
		autocmd BufWritePost $VIM_PATH/{*.vim,*.yaml,vimrc} nested
			\ source $MYVIMRC | redraw
		        \ source $MYVIMRC | redraw
  " Reload Vim script automatically if setlocal autoread
    autocmd BufWritePost,FileWritePost *.vim nested
        \ if &l:autoread > 0 | source <afile> |
        \   echo 'source ' . bufname('%') |
        \ endif
  " Update filetype on save if empty
    autocmd BufWritePost * nested
        \ if &l:filetype ==# '' || exists('b:ftdetect')
        \ |   unlet! b:ftdetect
        \ |   filetype detect
        \ | endif

		" Automatically set read-only for files being edited elsewhere
		autocmd SwapExists * nested let v:swapchoice = 'o'

	  " Update diff comparison once leaving insert mode
	  autocmd InsertLeave * if &l:diff | diffupdate | endif

		" Equalize window dimensions when resizing vim window
		autocmd VimResized * wincmd =


		" Force write shada on leaving nvim
		autocmd VimLeave * if has('nvim') | wshada! | else | wviminfo! | endif

		" Check if file changed when its window is focus, more eager than 'autoread'
		autocmd FocusGained * checktime

		autocmd Syntax * if line('$') > 5000 | syntax sync minlines=200 | endif

	  if has('nvim-0.5')
		    autocmd TermClose * buffer #
		    " autocmd TextYankPost *
		    "	\ silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=150}
		    try
		    	autocmd TextYankPost *
		    		\ silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=150}
		    endtry
		endif

		" Update filetype on save if empty
		autocmd BufWritePost * nested
			\ if &l:filetype ==# '' || exists('b:ftdetect')
			\ |   unlet! b:ftdetect
			\ |   filetype detect
			\ | endif

		" Reload Vim script automatically if setlocal autoread
		autocmd BufWritePost,FileWritePost *.vim nested
			\ if &l:autoread > 0 | source <afile> |
			\   echo 'source ' . bufname('%') |
			\ endif

		" When editing a file, always jump to the last known cursor position.
		" Don't do it when the position is invalid or when inside an event handler
		" Credits: https://github.com/farmergreg/vim-lastplace
		"autocmd BufReadPost *
	""		\ if &ft !~# 'commit' && ! &diff &&
	""		\      line("'\"") >= 1 && line("'\"") <= line("$")
	""		\|   execute 'normal! g`"zvzz'
	""		\| endif
	  autocmd BufReadPost *
	  	\ if index(['gitcommit', 'gitrebase', 'svn', 'hgcommit'], &buftype) == -1 &&
	  	\      index(['quickfix', 'nofile', 'help'], &buftype) == -1 &&
	  	\      ! &diff && ! &previewwindow &&
	  	\      line("'\"") > 0 && line("'\"") <= line("$")
	  	\|   if line("w$") == line("$")
	  	\|     execute "normal! g`\""
	  	\|   elseif line("$") - line("'\"") > ((line("w$") - line("w0")) / 2) - 1
	  	\|     execute "normal! g`\"zz"
	  	\|   else
	  	\|     execute "normal! \G'\"\<c-e>"
	  	\|   endif
	  	\|   if foldclosed('.') != -1
	  	\|     execute 'normal! zvzz'
	  	\|   endif
	  	\| endif

    " Highlight current line only on focused window
		autocmd WinEnter,BufEnter,InsertLeave *
    	\ if ! &cursorline && &filetype !~# '^\(denite\|clap_\)'
    	\      && ! &previewwindow && ! pumvisible()
    	\ | setlocal cursorline
    	\ | endif
	  autocmd WinLeave,BufLeave,InsertEnter *
    	\ if &cursorline && &filetype !~# '^\(denite\|clap_\)'
    	\      && ! &previewwindow && ! pumvisible()
    	\ | setlocal nocursorline
    	\ | endif

		"autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif

		"autocmd Syntax * if 5000 < line('$') | syntax sync minlines=200 | endif

		"autocmd FileType css setlocal equalprg=csstidy\ -\ --silent=true

	  " https://webpack.github.io/docs/webpack-dev-server.html#working-with-editors-ides-supporting-safe-write
	  autocmd FileType css,javascript,javascriptreact setlocal backupcopy=yes

		"autocmd FileType json syntax match Comment +\/\/.\+$+
    autocmd Filetype json,markdown let g:indentLine_enabled = 0

		" Go (Google)
    autocmd FileType go
          \  let b:coc_pairs_disabled = ['<']
          \ | let b:coc_root_patterns = ['.git', 'go.mod']

    autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')
    " Python
    autocmd FileType python
          \ setlocal expandtab smarttab nosmartindent
          \ | setlocal tabstop=4 softtabstop=4 shiftwidth=4 textwidth=80


		" set filetypes as typescript && tsx
		"autocmd BufNewFile,BufRead *.ts  set filetype=typescript
		"autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx

		" HTML (.gohtml and .tpl for server side)
		autocmd BufNewFile,BufRead *.html,*.htm,*.gohtml,*.tpl  setf html

	  " Make directory automatically.
    autocmd BufWritePre * call s:mkdir_as_necessary(expand('<afile>:p:h'), v:cmdbang)

augroup END "}}}

" Credits: https://github.com/Shougo/shougo-s-github/blob/master/vim/rc/options.rc.vim#L147
function! s:mkdir_as_necessary(dir, force) abort
  if !isdirectory(a:dir) && &l:buftype == '' &&
        \ (a:force || input(printf('"%s" does not exist. Create? [y/N]',
        \              a:dir)) =~? '^y\%[es]$')
    call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
  endif
endfunction

" FileType plugin config

"MaxMEllon/vim-jsx-pretty
if dein#tap('vim-jsx-pretty')
  let g:vim_jsx_pretty_highlight_close_tag = 1
endif

if dein#tap('html5.vim')
  let g:html5_event_handler_attributes_complete = 0
  let g:html5_rdfa_attributes_complete = 0
  let g:html5_microdata_attributes_complete = 0
  let g:html5_aria_attributes_complete = 0
endif

" vim: set foldmethod=marker ts=2 sw=2 tw=80 noet :
