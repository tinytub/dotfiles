augroup user_plugin_filetype
		autocmd!

 	" Reload vim config automatically
		autocmd BufWritePost $VIM_PATH/{*.vim,*.yaml,vimrc} nested
			\ source $MYVIMRC | redraw

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
			\ if &ft !~# 'commit' && ! &diff &&
			\      line("'\"") >= 1 && line("'\"") <= line("$")
			\|   execute 'normal! g`"zvzz'
			\| endif

		autocmd WinEnter,InsertLeave * set cursorline
		
		autocmd WinLeave,InsertEnter * set nocursorline
		
		"autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif
		
		"autocmd Syntax * if 5000 < line('$') | syntax sync minlines=200 | endif
		
		autocmd FileType css setlocal equalprg=csstidy\ -\ --silent=true
		
		autocmd BufWritePre *.js,*.jsx,*.less,*.css,*.html Neoformat

		autocmd FileType javascript,javascriptreact set shiftwidth=2
		
		autocmd FileType json syntax match Comment +\/\/.\+$+
		
		" Go (Google)
		autocmd FileType go let b:coc_pairs_disabled = ['<']
		
		" set filetypes as typescript && tsx
		"autocmd BufNewFile,BufRead *.ts  set filetype=typescript
		"autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx
		
		" HTML (.gohtml and .tpl for server side)
		autocmd BufNewFile,BufRead *.html,*.htm,*.gohtml,*.tpl  setf html
		" Magit
		autocmd User VimagitEnterCommit startinsert
		
		" https://webpack.github.io/docs/webpack-dev-server.html#working-with-editors-ides-supporting-safe-write
		"autocmd FileType css,javascript,jsx,javascript.jsx setlocal backupcopy=yes
		autocmd FileType css,javascript,javascriptreact setlocal backupcopy=yes
augroup END

" vim: set foldmethod=marker ts=2 sw=2 tw=80 noet :
