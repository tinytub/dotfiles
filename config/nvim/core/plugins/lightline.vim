" https://github.com/szorfein/dotfiles
" default lightline configuration
let g:lightline = {
  \ 'colorscheme': 'gruvbox',
  \ 'tabline': {
  \     'left': [['buffers']], 'right': [['close']]
  \ },
  \ 'active' : {
  \   'left':  [ [ 'mode', 'paste' ],
  \              [ 'fugitive', 'readonly', 'filename', 'modified' ],
  \              [ 'cocstatus', 'currentfunction' ]],
  \   'right': [ [ 'lineinfo' ],
  \              [ 'coc_error', 'coc_warning', 'coc_info', 'coc_hint' ],
  \              [ 'percent' ],
  \              [ 'fileformat', 'fileencoding', 'filetype' ],]
  \ },
  \ 'inactive': {
  \   'left':  [ [ 'filename' ] ],
  \   'right': [ [ 'lineinfo' ],
  \              [ 'percent' ],
  \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
  \ },
  \ 'component': {
  \   'lineinfo': ' %3l:%-2v'
  \ },
  \ 'component_raw': {
  \   'buffers': 1
  \ },
  \ 'component_function': {
  \   'filename': 'FileName',
  \   'gitbranch': 'GitBranch',
  \   'filencode': 'FileEncoding',
  \   'readonly': 'LightLineReadonly',
  \   'fugitive': 'LightlineFugitive',
  \   'filename_active': 'LightlineFilenameActive',
  \   'filetype': 'LightLineFiletype',
  \   'fileformat': 'LightLineFileformat',
  \   'cocstatus': 'coc#status',
  \   'currentfunction': 'CocCurrentFunction'
  \ },
  \ 'component_expand': {
 \   'coc_error': 'LightlineCocErrors',
  \   'coc_warning': 'LightlineCocWarnings',
  \   'coc_info': 'LightlineCocInfos',
  \   'coc_hint': 'LightlineCocHints',
  \   'buffers': 'lightline#bufferline#buffers',
  \ },
  \ 'component_type': {
  \   'readonly': 'error',
  \   'coc_error': 'error',
  \   'coc_warning': 'warning',
  \   'coc_info': 'tabsel',
  \   'coc_hint': 'middle',
  \   'coc_fix': 'middle',
  \   'buffers': 'tabsel',
  \ },
    \ 'separator': {
    \     'left': '', 'right': ''
    \ },
    \ 'subseparator': {
    \     'left': '', 'right': ''
    \ }
  \}

" lighline functions
function! FileName()
  "let l:fn = expand("%:t")
  let l:fn = expand("%")
  let l:ro = &ft !~? 'help' && &readonly ? " RO" : ""
  let l:mo = &modifiable && &modified ? " +" : ""
  return l:fn . l:ro . l:mo
endfunction

function! GitBranch()abort
  return !IsTree() ? exists('*fugitive#head') ? fugitive#head() : '' : ''
endfunction

" shows a nice representation of the current branch (needs a powerline font)
function! LightlineFugitive()
  if exists('*FugitiveHead')
  	let branch = FugitiveHead()
  	return branch !=# '' ? ''.branch : ''
  endif
  return ''
endfunction

function FileEncoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &enc : &enc) : ''
endfunction

function LightLineFiletype()
  "return winwidth(0) > 70 ? (strlen(&filetype) ? ' ' . WebDevIconsGetFileTypeSymbol() . ' ' . &filetype : '') : ''
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! LightLineFileformat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

function! IsTree()
  let l:name = expand('%:t')
  return l:name =~ 'NetrwTreeListing\|undotree\|NERD' ? 1 : 0
endfunction

""""""""""""""""
let g:lightline#bufferline#show_number  = 2
let g:lightline#bufferline#shorten_path = 1
let g:lightline#bufferline#enable_devicons = 1
let g:lightline#bufferline#unicode_symbols = 1
let g:lightline#bufferline#filename_modifier = ':t'
let g:lightline#bufferline#unnamed      = '[No Name]'
let g:lightline#bufferline#clickable = 1
"let g:lightline#bufferline#number_map = {
"  \ 0: '⓿ ', 1: '❶ ', 2: '❷ ', 3: '❸ ', 4: '❹ ',
"  \ 5: '❺ ', 6: '❻ ', 7: '❼ ', 8: '❽ ', 9: '❾ '}

" Leader is ,
"nmap <Leader>1 <Plug>lightline#bufferline#go(1)
"nmap <Leader>2 <Plug>lightline#bufferline#go(2)
"nmap <Leader>3 <Plug>lightline#bufferline#go(3)
"nmap <Leader>4 <Plug>lightline#bufferline#go(4)
"nmap <Leader>5 <Plug>lightline#bufferline#go(5)
"nmap <Leader>6 <Plug>lightline#bufferline#go(6)
"nmap <Leader>7 <Plug>lightline#bufferline#go(7)
"nmap <Leader>8 <Plug>lightline#bufferline#go(8)
"nmap <Leader>9 <Plug>lightline#bufferline#go(9)
"nmap <Leader>0 <Plug>lightline#bufferline#go(10)


" Helper function for LightlineCoc*() functions.
function! s:lightline_coc_diagnostic(kind, sign) abort
  let info = get(b:, 'coc_diagnostic_info', 0)
  if empty(info) || get(info, a:kind, 0) == 0
    return ''
  endif
  return printf("%s %d", a:sign, info[a:kind])
endfunction

" Used in LightLine config to show diagnostic messages.
function! LightlineCocErrors() abort
  return s:lightline_coc_diagnostic('error', '✖')
endfunction
function! LightlineCocWarnings() abort
    return s:lightline_coc_diagnostic('warning', "⚠")
endfunction
function! LightlineCocInfos() abort
  return s:lightline_coc_diagnostic('information', "ℹ")
endfunction
function! LightlineCocHints() abort
  return s:lightline_coc_diagnostic('hints', "ℹ")
endfunction

function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

autocmd BufWritePost,TextChanged,TextChangedI * call lightline#update()

