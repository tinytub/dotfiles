"FZF
    nnoremap <silent> <leader>fc :Colors<CR>
    nnoremap <silent> <leader>bb :Buffers<CR>
    nnoremap <silent> <leader>ff :call Fzf_dev()<CR>
    nnoremap <silent> <leader>fr :Rg<CR>
    nnoremap <silent> <leader>fw :Rg <C-R><C-W><CR>

" buffet
    nmap <leader>1 <Plug>BuffetSwitch(1)
    nmap <leader>2 <Plug>BuffetSwitch(2)
    nmap <leader>3 <Plug>BuffetSwitch(3)
    nmap <leader>4 <Plug>BuffetSwitch(4)
    nmap <leader>5 <Plug>BuffetSwitch(5)
    nmap <leader>6 <Plug>BuffetSwitch(6)
    nmap <leader>7 <Plug>BuffetSwitch(7)
    nmap <leader>8 <Plug>BuffetSwitch(8)
    nmap <leader>9 <Plug>BuffetSwitch(9)
    nmap <leader>0 <Plug>BuffetSwitch(10)

" vista
    nnoremap <silent><localleader>v :Vista!!<CR>
    nnoremap <silent><leader>fv     :Vista finder coc<CR>

" whichkey
	nnoremap <silent> <leader>      :<c-u>WhichKey '\'<CR>
	nnoremap <silent> <localleader> :<c-u>WhichKey  ';'<CR>
	nnoremap <silent>[              :<c-u>WhichKey  '['<CR>
	nnoremap <silent>]              :<c-u>WhichKey  ']'<CR>

" coc
    " Using CocList
    " Show all diagnostics
    nnoremap <silent> <leader>cd  :<C-u>CocList diagnostics<cr>
    " Manage extensions
    nnoremap <silent> <leader>ce  :<C-u>CocList extensions<cr>
    " Show commands
    nnoremap <silent> <leader>cc  :<C-u>CocList commands<cr>
    " Find symbol of current document
    nnoremap <silent> <leader>co  :<C-u>CocList outline<cr>
    " Search workspace symbols
    nnoremap <silent> <leader>cs  :<C-u>CocList -I symbols<cr>
    " Do default action for next item.
    nnoremap <silent> <leader>cj  :<C-u>CocNext<CR>
    " Do default action for previous item.
    nnoremap <silent> <leader>ck  :<C-u>CocPrev<CR>
    " Resume latest coc list
    nnoremap <silent> <leader>cr  :<C-u>CocListResume<CR>
    " Use `[c` and `]c` for navigate diagnostics
    nmap <silent> ]c <Plug>(coc-diagnostic-prev)
    nmap <silent> [c <Plug>(coc-diagnostic-next)
    " Remap for rename current word
    nmap <leader>cn <Plug>(coc-rename)
    " Remap for format selected region
    vmap <leader>cf  <Plug>(coc-format-selected)
    nmap <leader>cf  <Plug>(coc-format-selected)
    " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
    xmap <leader>ca  <Plug>(coc-codeaction-selected)
    nmap <leader>ca  <Plug>(coc-codeaction-selected)
    " Remap for do codeAction of current line
    nmap <leader>ac  <Plug>(coc-codeaction)
    " Fix autofix problem of current line
    nmap <leader>qf  <Plug>(coc-fix-current)
    " Remap keys for gotos
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)
    " Use K for show documentation in float window
    nnoremap <silent> K :call CocActionAsync('doHover')<CR>
    " use <c-space> for trigger completion.
    inoremap <silent><expr> <c-space> coc#refresh()
    nmap [g <Plug>(coc-git-prevchunk)
    nmap ]g <Plug>(coc-git-nextchunk)
    " show chunk diff at current position
    nmap gs <Plug>(coc-git-chunkinfo)
    " show commit contains current position
    nmap gm <Plug>(coc-git-commit)
    nnoremap <silent> <leader>cg  :<C-u>CocList --normal gstatus<CR>
    " float window scroll
	nnoremap <expr><C-f> coc#util#has_float() ? coc#util#float_scroll(1) : "\<C-f>"
	nnoremap <expr><C-b> coc#util#has_float() ? coc#util#float_scroll(0) : "\<C-b>"
    " multiple cursors
    nmap <silent> <C-c> <Plug>(coc-cursors-position)
    nmap <expr> <silent> <C-m> <SID>select_current_word()
    xmap <silent> <C-d> <Plug>(coc-cursors-range)
    " use normal command like `<leader>xi(`
    nmap <leader>x  <Plug>(coc-cursors-operator)

    function! s:select_current_word()
        if !get(g:, 'coc_cursors_activated', 0)
            return "\<Plug>(coc-cursors-word)"
        endif
        return "*\<Plug>(coc-cursors-word):nohlsearch\<CR>"
    endfunc

    nnoremap <silent> <leader>cm ::CocSearch -w
    nnoremap <silent> <leader>cw ::CocSearch
    " use normal command like `<leader>xi(`
    nmap <leader>x  <Plug>(coc-cursors-operator)

    " coc-explorer
    noremap <silent> <leader>j :execute 'CocCommand explorer' .
        \ ' --toggle' .
        \ ' --sources=buffer+,file+' .
        \ ' --file-columns=git,selection,icon,clip,indent,filename,size ' . expand('%:p:h')<CR>

    " 使用 回车 确认补全 Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
    " Coc only does snippet and additional edit on confirm.
    " inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    " Or use `complete_info` if your vim support it, like:
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" defx
   " 第一个是默认打开 defx 的方式,当前使用最下面定位到当前文件的方式
    nnoremap <silent> <Leader>e
        \ :<C-u>Defx -resume -toggle -buffer-name=tab`tabpagenr()`<CR>
    nnoremap <silent> <Leader>F
		\ :<C-u>Defx -resume -toggle -search=`expand('%:p')` `getcwd()`<CR>
    "nnoremap <silent><Leader>n :call <sid>defx_open()<CR>
    "nnoremap <silent><Leader>e :call <sid>defx_open({ 'find_current_file': v:true })<CR>
    nnoremap <silent><F3> :call <sid>defx_open({ 'find_current_file': v:true })<CR>

" denite
    nnoremap <silent><LocalLeader>m :<C-u>Denite menu<CR>
    noremap zl :<C-u>call <SID>my_denite_outline(&filetype)<CR>
    noremap zL :<C-u>call <SID>my_denite_decls(&filetype)<CR>
    noremap zT :<C-u>call <SID>my_denite_file_rec_goroot()<CR>

    nnoremap <silent> <Leader>gl :<C-u>Denite gitlog:all<CR>
    nnoremap <silent> <Leader>gh :<C-u>Denite gitbranch<CR>
    function! s:my_denite_outline(filetype) abort
    execute 'Denite' a:filetype ==# 'go' ? "decls:'%:p'" : 'outline'
    endfunction
    function! s:my_denite_decls(filetype) abort
    if a:filetype ==# 'go'
        Denite decls
    else
        call denite#util#print_error('decls does not support filetypes except go')
    endif
    endfunction
    function! s:my_denite_file_rec_goroot() abort
    if !executable('go')
        call denite#util#print_error('`go` executable not found')
        return
    endif
    let out = system('go env | grep ''^GOROOT='' | cut -d\" -f2')
    let goroot = substitute(out, '\n', '', '')
    call denite#start(
            \ [{'name': 'file/rec', 'args': [goroot]}],
            \ {'input': '.go'})
    endfunction

"vim-go
	 nnoremap <silent> <LocalLeader>gi :GoImpl<CR>
	 nnoremap <silent> <LocalLeader>gd :GoDescribe<CR>
	 nnoremap <silent> <LocalLeader>gc :GoCallees<CR>
	 nnoremap <silent> <LocalLeader>gC :GoCallers<CR>
	 nnoremap <silent> <LocalLeader>gs :GoCallstack<CR>

" vim-go: 按键映射 -------------------------
"    augroup VimGo
"      autocmd!
"      " vim-go related mappings
"      "autocmd FileType go nmap <Leader>r <Plug>(go-run)
"      "autocmd FileType go nmap <Leader>b <Plug>(go-build)
"      "autocmd FileType go nmap <Leader>t <Plug>(go-test)
"      "autocmd FileType go nmap <Leader>i <Plug>(go-info)
"      "autocmd FileType go nmap <Leader>s <Plug>(go-implements)
"      autocmd FileType go nmap <Leader>c <Plug>(go-coverage)
"      autocmd FileType go nmap <Leader>re <Plug>(go-rename)
"      autocmd FileType go nmap <Leader>gi <Plug>(go-imports)
"      autocmd FileType go nmap <Leader>gI <Plug>(go-install)
"      "autocmd FileType go nmap <Leader>gd <Plug>(go-doc)
"      autocmd FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
"      autocmd FileType go nmap <Leader>gb <Plug>(go-doc-browser)
"      autocmd FileType go nmap <Leader>ds <Plug>(go-def-split)
"      autocmd FileType go nmap <Leader>dv <Plug>(go-def-vertical)
"      "autocmd FileType go nmap <Leader>dt <Plug>(go-def-tab)
"      autocmd FileType go set nocursorcolumn
"    augroup END

" Startify
    nnoremap <silent> <leader>s :Startify<CR>

"ale
    nmap [a <Plug>(ale_next_wrap)
    nmap ]a <Plug>(ale_previous_wrap)
