if dein#tap('fzf-preview.vim')
    nnoremap <silent> <leader>fc :Colors<CR>
        nnoremap <silent> <leader>bb :<C-u>FzfPreviewBuffers<CR>
        nnoremap <silent> <leader>bB :<C-u>FzfPreviewAllBuffers<CR>
        nnoremap <silent> <leader>ff :<C-u>FzfPreviewDirectoryFiles<CR>
        nnoremap <silent> <leader>fr :<C-u>FzfPreviewProjectGrep .<CR>
        nnoremap <silent> <leader>fw :<C-u>FzfPreviewProjectGrep <C-R><C-W><CR>
        nnoremap <silent> <leader>fo :<C-u>FzfPreviewOldFiles<CR>
        nnoremap <silent> <leader>fm :<C-u>FzfPreviewMruFiles<CR>
        nnoremap <silent> <leader>fp :<C-u>FzfPreviewProjectFiles<CR>
        nnoremap <silent> <leader>fP :<C-u>FzfPreviewFromResources project_mru git<CR>
endif

if dein#tap('vim-easy-align')
    " Start interactive EasyAlign in visual mode (e.g. vipga)
    xmap ga <Plug>(EasyAlign)
    " Start interactive EasyAlign for a motion/text object (e.g. gaip)
    nmap ga <Plug>(EasyAlign)
endif

if dein#tap('vista.vim')
    "nnoremap <silent><localleader>v :Vista!!<CR>
    nnoremap <silent><localleader>v :Vista coc<CR>
    nnoremap <silent><leader>fv     :Vista finder coc<CR>
endif

if dein#tap('ale')
        nmap [a <Plug>(ale_next_wrap)
        nmap ]a <Plug>(ale_previous_wrap)
endif

if dein#tap('vim-easymotion')
        nmap <Leader><Leader>w <Plug>(easymotion-w)
	    nmap <Leader><Leader>f <Plug>(easymotion-f)
	    nmap <Leader><Leader>b <Plug>(easymotion-b)
endif

if dein#tap('vim-which-key')
"		nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
    	nnoremap <silent> <leader>      :<c-u>WhichKey '\'<CR>
		nnoremap <silent> <localleader> :<c-u>WhichKey  ';'<CR>
		nnoremap <silent>[              :<c-u>WhichKey  '['<CR>
		nnoremap <silent>]              :<c-u>WhichKey  ']'<CR>
endif

" git
"	nnoremap <silent> <Leader>gd :Gdiff<CR>
"	nnoremap <silent> <Leader>gc :Gcommit<CR>
"	nnoremap <silent> <Leader>gb :Gblame<CR>
"	nnoremap <silent> <Leader>gB :Gbrowse<CR>
"	nnoremap <silent> <Leader>gS :Gstatus<CR>

if dein#tap('vim-smartchr')
    inoremap <expr> , smartchr#one_of(',', ',')
    autocmd FileType go inoremap <buffer><expr> ;
            \ smartchr#loop(':=',';')
    autocmd FileType go inoremap <buffer> <expr> .
          \ smartchr#loop('.', '<-', '->','...')
endif

if dein#tap('coc.nvim')
    " Using CocList
    " Remap for do codeAction of selected region
    function! s:cocActionsOpenFromSelected(type) abort
        execute 'CocCommand actions.open ' . a:type
    endfunction
    xmap <silent> <leader>ca :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
    nmap <silent> <leader>ca :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@
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
    "xmap <leader>ca  <Plug>(coc-codeaction-selected)
    "nmap <leader>ca  <Plug>(coc-codeaction-selected)
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
    "和回车冲突
    "nmap <expr> <silent> <C-m> <SID>select_current_word()
    xmap <silent> <C-d> <Plug>(coc-cursors-range)

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

    nnoremap <silent> <leader>ot :<C-u>CocCommand floaterm.new<cr>

    " coc-explorer
"    noremap <silent> <leader>j :CocCommand explorer<cr>
    noremap <silent> <leader>j :execute 'CocCommand explorer' .
    \ ' --toggle' .
    \ ' --position=floating' .
    \ ' --sources=file+'<CR>

    " 使用 回车 确认补全 Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
    " Coc only does snippet and additional edit on confirm.
    " inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    " Or use `complete_info` if your vim support it, like:
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
endif

if dein#tap('defx.nvim')
   " 第一个是默认打开 defx 的方式,当前使用最下面定位到当前文件的方式
    nnoremap <silent> <Leader>e
        \ :<C-u>Defx -resume -toggle -buffer-name=tab`tabpagenr()`<CR>
    nnoremap <silent> <Leader>F
		\ :<C-u>Defx -resume -buffer-name=tab`tabpagenr()` -search=`expand('%:p')`<CR>
		"\ :<C-u>Defx -resume -toggle -search=`expand('%:p')` `getcwd()`<CR>
    "nnoremap <silent><F3> :call <sid>defx_open({ 'find_current_file': v:true })<CR>
endif

if dein#tap('committia.vim')
	let g:committia_hooks = {}
	function! g:committia_hooks.edit_open(info)
		imap <buffer><C-d> <Plug>(committia-scroll-diff-down-half)
		imap <buffer><C-u> <Plug>(committia-scroll-diff-up-half)

		setlocal winminheight=1 winheight=1
		resize 10
		startinsert
	endfunction
endif

if dein#tap('vim-quickrun')
    nnoremap <silent> <localleader>r :QuickRun<CR>
endif

if dein#tap('dash.vim')
        nnoremap <silent><leader>d :Dash<CR>
endif

if dein#tap('vim-expand-region')
        xmap v <Plug>(expand_region_expand)
        xmap V <Plug>(expand_region_shrink)
endif

if dein#tap('splitjoin.vim')
        let g:splitjoin_join_mapping = ''
        let g:splitjoin_split_mapping = ''
        nmap sj :SplitjoinJoin<CR>
        nmap sk :SplitjoinSplit<CR>
endif



if dein#tap('denite.nvim')
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
	" nnoremap <silent><LocalLeader>r :<C-u>Denite -resume -refresh -no-start-filter<CR>
	" nnoremap <silent><LocalLeader>f :<C-u>Denite file/rec<CR>
	" nnoremap <silent><LocalLeader>b :<C-u>Denite buffer file_mru -default-action=switch<CR>
	" nnoremap <silent><LocalLeader>d :<C-u>Denite directory_rec directory_mru -default-action=cd<CR>
    " "nnoremap <silent><LocalLeader>v :<C-u>Denite neoyank -buffer-name=register<CR>
    " "xnoremap <silent><LocalLeader>v :<C-u>Denite neoyank -buffer-name=register -default-action=replace<CR>
    " "nnoremap <silent><LocalLeader>l :<C-u>Denite location_list -buffer-name=list -no-start-filter<CR>
	" "nnoremap <silent><LocalLeader>q :<C-u>Denite quickfix -buffer-name=list -no-start-filter<CR>
	" "nnoremap <silent><LocalLeader>n :<C-u>Denite dein<CR>
	" nnoremap <silent><LocalLeader>g :<C-u>Denite grep -no-start-filter<CR>
	" nnoremap <silent><LocalLeader>j :<C-u>Denite jump change file/point<CR>
	" "nnoremap <silent><LocalLeader>u :<C-u>Denite junkfile:new junkfile -buffer-name=list<CR>
	" nnoremap <silent><LocalLeader>o :<C-u>Denite outline<CR>
	" nnoremap <silent><LocalLeader>s :<C-u>Denite session -buffer-name=list<CR>
	" nnoremap <silent><LocalLeader>t :<C-u>Denite tag<CR>
	" nnoremap <silent><LocalLeader>p :<C-u>Denite jump<CR>
	" nnoremap <silent><LocalLeader>h :<C-u>Denite help<CR>
	" nnoremap <silent><LocalLeader>m :<C-u>Denite file/rec -buffer-name=memo -path=~/docs/books<CR>
	" " nnoremap <silent><LocalLeader>m :<C-u>Denite mpc -buffer-name=mpc<CR>
	" nnoremap <silent><LocalLeader>z :<C-u>Denite z -buffer-name=list<CR>
"	nnoremap <silent><LocalLeader>; :<C-u>Denite command command_history<CR>
"	nnoremap <silent><LocalLeader>/ :<C-u>Denite line<CR>
"	nnoremap <silent><LocalLeader>* :<C-u>DeniteCursorWord line<CR>

"	" chemzqm/denite-git
"	nnoremap <silent> <Leader>gl :<C-u>Denite gitlog:all -no-start-filter<CR>
"	nnoremap <silent> <Leader>gs :<C-u>Denite gitstatus -no-start-filter<CR>
"	nnoremap <silent> <Leader>gc :<C-u>Denite gitbranch -no-start-filter<CR>
"
"	" Open Denite with word under cursor or selection
"	nnoremap <silent> <Leader>gt :DeniteCursorWord tag:include -buffer-name=tag -immediately<CR>
"	nnoremap <silent> <Leader>gf :DeniteCursorWord file/rec<CR>
"	nnoremap <silent> <Leader>gg :DeniteCursorWord grep -buffer-name=search<CR>
"	vnoremap <silent> <Leader>gg
"		\ :<C-u>call <SID>get_selection('/')<CR>
"		\ :execute 'Denite -buffer-name=search grep:::'.@/<CR><CR>
"
"	function! s:get_selection(cmdtype)
"		let temp = @s
"		normal! gv"sy
"		let @/ = substitute(escape(@s, '\' . a:cmdtype), '\n', '\\n', 'g')
"		let @s = temp
"	endfunction
endif

if dein#tap('vim-go')
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
endif

if dein#tap('vimagit')
	nnoremap <silent> <Leader>gg :Magit<CR>
endif

if dein#tap('gina.vim')
	nnoremap <silent><Leader>gp :Gina push<CR>
endif

if dein#tap('vim-mundo')
    nnoremap <silent> <leader>m :MundoToggle<CR>
endif

if dein#tap('vim-choosewin')
	nmap -         <Plug>(choosewin)
	nmap <Leader>- :<C-u>ChooseWinSwapStay<CR>
endif

if dein#tap('accelerated-jk')
	nmap <silent>j <Plug>(accelerated_jk_gj)
	nmap <silent>k <Plug>(accelerated_jk_gk)
endif

if dein#tap('dsf.vim')
	nmap dsf <Plug>DsfDelete
	nmap csf <Plug>DsfChange
endif

if dein#tap('comfortable-motion.vim')
    nnoremap <silent> <C-d> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * 2)<CR>
    nnoremap <silent> <C-u> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * -2)<CR>
    nnoremap <silent> <C-f> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * 4)<CR>
    nnoremap <silent> <C-b> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * -4)<CR>
endif

if dein#tap('python_match.vim')
	nmap <buffer> {{ [%
	nmap <buffer> }} ]%
endif

if dein#tap('goyo.vim')
	nnoremap <Leader>G :Goyo<CR>
endif

if dein#tap('caw.vim')
    function! InitCaw() abort
		if ! &l:modifiable
			silent! nunmap <buffer> gc
			silent! xunmap <buffer> gc
			silent! nunmap <buffer> gcc
			silent! xunmap <buffer> gcc
		else
			nmap <buffer> gc <Plug>(caw:prefix)
			xmap <buffer> gc <Plug>(caw:prefix)
			nmap <buffer> gcc <Plug>(caw:hatpos:toggle)
			xmap <buffer> gcc <Plug>(caw:hatpos:toggle)
		endif
	endfunction
	autocmd FileType * call InitCaw()
	call InitCaw()
endif

if dein#tap('vim-startify')
    nnoremap <silent> <leader>s :Startify<CR>
endif

if dein#tap('vim-sandwich')
     nmap <silent> sa <Plug>(operator-sandwich-add)
     xmap <silent> sa <Plug>(operator-sandwich-add)
     omap <silent> sa <Plug>(operator-sandwich-g@)
     nmap <silent> sd <Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)
     xmap <silent> sd <Plug>(operator-sandwich-delete)
     nmap <silent> sr <Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)
     xmap <silent> sr <Plug>(operator-sandwich-replace)
     nmap <silent> sdb <Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)
     nmap <silent> srb <Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)
     omap ib <Plug>(textobj-sandwich-auto-i)
     xmap ib <Plug>(textobj-sandwich-auto-i)
     omap ab <Plug>(textobj-sandwich-auto-a)
     xmap ab <Plug>(textobj-sandwich-auto-a)
     omap is <Plug>(textobj-sandwich-query-i)
     xmap is <Plug>(textobj-sandwich-query-i)
     omap as <Plug>(textobj-sandwich-query-a)
     xmap as <Plug>(textobj-sandwich-query-a)
endif

if dein#tap('vim-operator-replace')
	xmap p <Plug>(operator-replace)
endif

if dein#tap('vim-textobj-multiblock')
	omap <silent> ab <Plug>(textobj-multiblock-a)
	omap <silent> ib <Plug>(textobj-multiblock-i)
	xmap <silent> ab <Plug>(textobj-multiblock-a)
	xmap <silent> ib <Plug>(textobj-multiblock-i)
endif

if dein#tap('vim-textobj-function')
	omap <silent> af <Plug>(textobj-function-a)
	omap <silent> if <Plug>(textobj-function-i)
	xmap <silent> af <Plug>(textobj-function-a)
	xmap <silent> if <Plug>(textobj-function-i)
endif
