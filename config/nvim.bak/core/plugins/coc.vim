"" seems like coc will crash on large files?
"let g:trigger_size = 0.5 * 1048576
"
"augroup hugefile
"  autocmd!
"  autocmd BufReadPre *
"        \ let size = getfsize(expand('<afile>')) |
"        \ if (size > g:trigger_size) || (size == -2) |
"        \   echohl WarningMsg | echomsg 'WARNING: altering options for this huge file!' | echohl None |
"        \   exec 'CocDisable' |
"        \ else | \   exec 'CocEnable' |
"        \ endif |
"        \ unlet size
"augroup END
"CoC configlet

let g:coc_snippet_next = '<TAB>'
let g:coc_snippet_prev = '<S-TAB>'
let g:coc_status_error_sign = '•'
let g:coc_status_warning_sign = '•'
let g:coc_global_extensions = [
        \ 'coc-html',
        \ 'coc-css',
        \ 'coc-snippets',
        \ 'coc-pairs',
        \ 'coc-json',
        \ 'coc-highlight',
        \ 'coc-git',
        \ 'coc-lists',
        \ 'coc-post',
        \ 'coc-yaml',
        \ 'coc-gitignore',
        \ 'coc-vimlsp',
        \ 'coc-explorer',
        \ 'coc-sql',
        \ 'coc-python',
        \ ]

" Don't load the defx-git plugin file, not needed
let b:defx_git_loaded = 1

augroup MyCoCAutoCmd
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

"" coc tab 补全
"inoremap <silent><expr> <TAB>
"      \ pumvisible() ? "\<C-n>" :
"      \ <SID>check_back_space() ? "\<TAB>" :
"      \ coc#refresh()
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" Use <Tab> for trigger completion and navigate to the next complete item
inoremap <silent><expr> <Tab>
	\ pumvisible() ? "\<C-n>" :
	\ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
	\ <SID>check_back_space() ? "\<Tab>" :
	\ coc#refresh()
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm() :
	\"\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
"inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm() :
"	\ delimitMate#WithinEmptyPair() ? "\<C-R>=delimitMate#ExpandReturn()\<CR>" :
"	\"\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


augroup user_plugin_coc
	autocmd!
	autocmd CompleteDone * if pumvisible() == 0 | pclose | endif
augroup END

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" 关闭 coclist goto reference 的 preview
let g:coc_enable_locationlist = 0
autocmd User CocLocationsChange CocList --normal location
