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

		" Equalize window dimensions when resizing vim window
		autocmd VimResized * tabdo wincmd =


		" Force write shada on leaving nvim
		autocmd VimLeave * if has('nvim') | wshada! | else | wviminfo! | endif

		" Check if file changed when its window is focus, more eager than 'autoread'
		autocmd FocusGained * checktime

		autocmd Syntax * if line('$') > 5000 | syntax sync minlines=200 | endif

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
		"autocmd BufReadPost *
	""		\ if &ft !~# 'commit' && ! &diff &&
	""		\      line("'\"") >= 1 && line("'\"") <= line("$")
	""		\|   execute 'normal! g`"zvzz'
	""		\| endif

		"autocmd WinEnter,InsertLeave * set cursorline
		"autocmd WinLeave,InsertEnter * set nocursorline
  	autocmd WinEnter,InsertLeave * if &ft !~# '^\(denite\|clap_\)' |
  		\ set cursorline | endif
  	autocmd WinLeave,InsertEnter * if &ft !~# '^\(denite\|clap_\)' |
  		\ set nocursorline | endif

    " Automatically set read-only for files being edited elsewhere
    autocmd SwapExists * nested let v:swapchoice = 'o'

    " Equalize window dimensions when resizing vim window
    autocmd VimResized * tabdo wincmd =

    " Force write shada on leaving nvim
    autocmd VimLeave * if has('nvim') | wshada! | else | wviminfo! | endif

    " Check if file changed when its window is focus, more eager than 'autoread'
    autocmd FocusGained * checktime

		"autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif

		"autocmd Syntax * if 5000 < line('$') | syntax sync minlines=200 | endif

		autocmd FileType css setlocal equalprg=csstidy\ -\ --silent=true

	  " https://webpack.github.io/docs/webpack-dev-server.html#working-with-editors-ides-supporting-safe-write
	  autocmd FileType css,javascript,javascriptreact setlocal backupcopy=yes

		autocmd FileType json syntax match Comment +\/\/.\+$+

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
		" Magit
		autocmd User VimagitEnterCommit startinsert

augroup END "}}}

" vim: set foldmethod=marker ts=2 sw=2 tw=80 noet :
