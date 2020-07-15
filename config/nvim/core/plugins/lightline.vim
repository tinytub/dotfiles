let g:lightline = {
    \   'colorscheme': 'deus',
    \   'active': {
    \       'left': [ [ 'mode', 'paste' ],
    \               [ 'gitbranch' ],
    \               [  'readonly', 'filetype', 'filename'],['coc_status']],
    \       'right': [ [ 'percent' ], [ 'lineinfo' ],
    \               [ 'fileformat', 'fileencoding' ],
    \               [ 'coc_error', 'coc_warning', 'coc_ok'],
    \               [ 'gitblame', 'currentfunction']]
    \   },
    \   'component_expand': {
    \       'buffers'     : 'lightline#bufferline#buffers',
    \       'coc_error'   : 'lightline#coc#errors',
    \       'coc_warning' : 'lightline#coc#warnings',
    \       'coc_ok'      : 'lightline#coc#ok',
    \       'coc_status'  : 'lightline#coc#status',
    \   },
    \   'component_type': {
    \       'readonly': 'error',
    \       'linter_warnings': 'warning',
    \       'linter_errors': 'error',
    \       'buffers': 'tabsel',
    \       'coc_error': 'error',
    \       'coc_warning': 'warning',
    \       'coc_ok': 'right',
    \   },
    \   'component_function': {
    \       'fileencoding': 'FileEncoding',
    \       'filename': 'FileName',
    \       'fileformat': 'FileFormat',
    \       'filetype': 'FileType',
    \       'gitbranch': 'GitBranch',
    \       'currentfunction': 'CurrentFunction',
    \       'gitblame': 'GitBlame',
    \   },
    \   'tabline': {
    \       'left': [ [ 'buffers' ] ],
    \       'right': [ [ 'close' ] ]
    \   },
    \   'tab': {
    \       'active': [ 'filename', 'modified' ],
    \       'inactive': [ 'filename', 'modified' ],
    \   },
    \   'separator': { 'left': '', 'right': '' },
    \   'subseparator': { 'left': '', 'right': '' }
\ }

function! FileName() abort
    let filename = winwidth(0) > 70 ? expand('%') : expand('%:t')
    if filename =~ 'NERD_tree'
        return ''
    endif
    let modified = &modified ? ' +' : ''
    return fnamemodify(filename, ":~:.") . modified
endfunction

function! FileEncoding()
    " only show the file encoding if it's not 'utf-8'
    return &fileencoding == 'utf-8' ? '' : &fileencoding
endfunction

function! FileFormat()
    " only show the file format if it's not 'unix'
    let format = &fileformat == 'unix' ? '' : &fileformat
    return winwidth(0) > 70 ? format . ' ' . WebDevIconsGetFileFormatSymbol() . ' ' : ''
endfunction

function! FileType()
    return WebDevIconsGetFileTypeSymbol()
endfunction

function! GitBranch()
    "return "\uE725" . (exists('*fugitive#head') ? ' ' . fugitive#head() : '')
    return "\uE725" . (exists('*FugitiveHead') ? ' ' . fugitive#head() : '')
endfunction

function! CurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

function! GitBlame()
    return winwidth(0) > 100 ? strpart(substitute(get(b:, 'coc_git_blame', ''), '[\(\)]', '', 'g'), 0, 50) : ''
    " return winwidth(0) > 100 ? strpart(get(b:, 'coc_git_blame', ''), 0, 20) : ''
endfunction



"let g:lightline = {}
"let g:lightline.active = {
"        \   'left': [
"        \       [ 'mode', 'paste' ],
"        \       [ 'readonly', 'filename', 'modified' ],
"        \       [ 'method' ],
"        \   ],
"        \   'right':[
"        \       [ 'coc_error', 'coc_warning', 'coc_hint', 'coc_info' ],
"        \       [ 'filetype', 'fileencoding', 'lineinfo', 'percent' ],
"        \       [ 'vsstatus' ],
"        \   ],
"        \ }
"
"let g:lightline.inactive = {
"        \   'left': [
"        \       [ 'readonly', 'filename', 'modified' ],
"        \   ],
"        \   'right':[
"        \       [ 'filetype', 'fileencoding', 'lineinfo', 'percent' ],
"        \   ],
"        \ }
"
"let g:lightline.tabline = {
"        \   'left': [
"        \       [ 'buffers' ],
"        \   ],
"        \   'right': [
"        \       [ 'filepath', '' ],
"        \   ],
"        \ }
"
"let g:lightline.tab = {
"        \ 'active': [ 'tabnum', 'filename', 'modified' ],
"        \ 'inactive': [ 'tabnum', 'filename', 'modified' ],
"        \ }
"
"let g:lightline.component = {
"        \ 'close': '%999X   ',
"        \ 'modified': '%{&modified ? "" : &modifiable ? "" : "-"}',
"        \ 'paste': '%{&paste?"":""}',
"        \ 'readonly': '%{&readonly ? "" : ""}',
"        \ }
"
"let g:lightline.component_function = {
"        \ }
"
"let g:lightline.tab_component_function = {
"        \   'modified' : 'LightlineTabModified',
"        \ }
"
"let g:lightline.component_expand = {
"        \   'buffers'     : 'lightline#bufferline#buffers',
"        \   'coc_error'   : 'LightlineCocErrors',
"        \   'coc_fix'     : 'LightlineCocFixes',
"        \   'coc_hint'    : 'LightlineCocHints',
"        \   'coc_info'    : 'LightlineCocInfos',
"        \   'coc_warning' : 'LightlineCocWarnings',
"        \   'cocstatus'   : 'coc#status',
"        \   'filepath'    : 'LightLineFilePath',
"        \   'vsstatus'    : 'LightlineVerCtrlStatus',
"        \   'method'      : 'LightlineCocCurrentFunction',
"        \   'modifiedx'   : 'LightlineModified',
"        \   'readonlyx'   : 'LightlineReadonly',
"        \ }
"
"let g:lightline.component_type = {
"        \   'coc_error'   : 'error',
"        \   'coc_warning' : 'warning',
"        \   'coc_info'    : 'tabsel',
"        \   'coc_hint'    : 'middle',
"        \   'coc_fix'     : 'middle',
"        \   'buffers'     : 'tabsel',
"        \ }
"
"let g:lightline.colorscheme = 'gruvbox'
"let g:lightline.separator = { 'left': '', 'right': '' }
"let g:lightline.tabline_subseparator = { 'left': '', 'right': '|' }
"
"let g:lightline.enable = {
"        \   'tabline': 1,
"        \ }
"
""function! LightLineFilePath() abort
""    let icon = lib#icons#file_node_ext_icon(&filetype, expand('%:t'), expand('%:e'))
""    let icon = empty(icon) ? '' : icon.'  '
""    return icon.expand('%')
""endfunction
"
"function! LightLineFilepath()
"	return winwidth(0) <=120 ? expand('%:h') : ''
"endfunction
"
"function! LightlineReadonly() abort
"    return &readonly && &filetype !=# 'help' ? '' : ''
"endfunction
"
"" function! LightlineReadonlyN() abort
""     let t = tabnr()
""     let w = winnr()
""     return gettabwinvar(t, w, '&readonly') &&
""             \ gettabwinvar(t, w, '&filetype') !=# 'help' ? '' : '~'
"" endfunction
"
"function! LightlineModified() abort
"    return &modified ? '' :
"            \ &modifiable ? '' : '-'
"endfunction
"
"function! LightlineTabModified(n) abort
"    let winnr = tabpagewinnr(a:n)
"    return gettabwinvar(a:n, winnr, '&modified') ? '' :
"            \ gettabwinvar(a:n, winnr, '&modifiable') ? '' : '-'
"endfunction
"
"function! LightlineBufferline() abort
"    call bufferline#refresh_status()
"    return [
"            \ g:bufferline_status_info.before,
"            \ g:bufferline_status_info.current,
"            \ g:bufferline_status_info.after
"            \ ]
"endfunction
"
"function s:git_status()
"    let gitbranch = trim(get(g:, 'coc_git_status', ''))
"    if empty(gitbranch) | return '' | endif
"
"    let gitcount = trim(get(b:, 'coc_git_status', ''))
"    if empty(gitcount)
"        return printf('%s', gitbranch)
"    else
"        return printf('%s [%s]', gitbranch, gitcount)
"    endif
"endfunction
"
"function s:svn_status()
"    let svnstatus = lib#svn#status()
"    if empty(svnstatus) | return '' | endif
"
"    let svncount = lib#svn#count()
"    if empty(svncount) || svncount ==# ' '
"        return printf('%s', svnstatus)
"    else
"        return printf('%s [%s]', svnstatus, svncount)
"    endif
"endfunction
"
"function! LightlineVerCtrlStatus() abort
"    if winwidth(0) < 80
"        return ''
"    endif
"    let status = s:git_status()
"    if empty(status) | let status = s:svn_status() | endif
"    return status
"endfunction
"
"function! s:lightline_coc_diagnostic(kind, sign) abort
"    let info = get(b:, 'coc_diagnostic_info', 0)
"    if empty(info) || get(info, a:kind, 0) == 0
"        return ''
"    endif
"    return printf('%s %d', a:sign, info[a:kind])
"endfunction
"
"function! s:lightline_ale_diagnostic(kind, sign) abort
"    if !lib#bundle#has_loaded('ale')
"        return ''
"    endif
"    let info = ale#statusline#Count(bufnr(''))
"    if empty(info) || get(info, a:kind, 0) == 0
"        return ''
"    endif
"    return printf('%s %d', a:sign, info[a:kind])
"endfunction
"
"function! LightlineCocErrors() abort
"    let msg = s:lightline_coc_diagnostic('error', '✖')
"    if empty(msg)
"        let msg = s:lightline_ale_diagnostic('error', '✖')
"    endif
"    return msg
"endfunction
"
"function! LightlineCocWarnings() abort
"    let msg = s:lightline_coc_diagnostic('warning', '')
"    if empty(msg)
"        let msg = s:lightline_ale_diagnostic('warning', '')
"    endif
"    return msg
"endfunction
"
"function! LightlineCocInfos() abort
"    let msg = s:lightline_coc_diagnostic('information', '')
"    if empty(msg)
"        let msg = s:lightline_ale_diagnostic('info', '')
"    endif
"    return msg
"endfunction
"
"function! LightlineCocHints() abort
"    return s:lightline_coc_diagnostic('hints', '')
"endfunction
"
"let s:show_function = 0
"
"function s:show_function_toggle()
"    let s:show_function = xor(s:show_function, 1)
"endfunction
"
"function! LightlineCocCurrentFunction()
"    if s:show_function == 0
"        return ''
"    else
"        return get(b:, 'coc_current_function', '')
"    endif
"endfunction
"
""augroup my_conf_lightline_vim
""    autocmd!
""
""    autocmd CursorHold *  call lightline#update()
""    autocmd CursorHoldI * call lightline#update()
""
""    autocmd User CocDiagnosticChange call lightline#update()
""    autocmd User ALEJobStarted       call lightline#update()
""    autocmd User ALELintPost         call lightline#update()
""    autocmd User ALEFixPost          call lightline#update()
""augroup END
"
"command! -nargs=0 ShowFunctionToggle
"        \ call s:show_function_toggle()
"
"let g:lightline#bufferline#show_number  = 2
"let g:lightline#bufferline#shorten_path = 1
"let g:lightline#bufferline#enable_devicons = 1
"let g:lightline#bufferline#unicode_symbols = 1
"let g:lightline#bufferline#filename_modifier = ':t'
"let g:lightline#bufferline#unnamed      = '[No Name]'
"let g:lightline#bufferline#clickable = 1
"
"let g:lightline.colorscheme = "forest_night"


"" https://github.com/szorfein/dotfiles
"" default lightline configuration
"let g:lightline = {
"  \ 'tabline': {
"  \     'left': [['buffers']], 'right': [['close']]
"  \ },
"  \ 'active' : {
"  \   'left':  [ [ 'mode', 'paste' ],
"  \              [ 'fugitive', 'readonly', 'filename', 'modified' ],
"  \              [ 'cocstatus', 'currentfunction' ]],
"  \   'right': [ [ 'coc_error', 'coc_warning', 'coc_info', 'coc_hint' ],
"  \              [ 'lineinfo' ],
"  \              [ 'percent' ],
"  \              [ 'filetype' , 'fileformat', 'fileencoding' ]
"  \            ]
"  \ },
"  \ 'component': {
"  \   'lineinfo': ' %3l:%-2v'
"  \ },
"  \ 'component_raw': {
"  \   'buffers': 1
"  \ },
"  \ 'component_function': {
"  \   'filename': 'FileName',
"  \   'gitbranch': 'GitBranch',
"  \   'filencode': 'FileEncoding',
"  \   'readonly': 'LightLineReadonly',
"  \   'fugitive': 'LightlineFugitive',
"  \   'filename_active': 'LightlineFilenameActive',
"  \   'filetype': 'LightLineFiletype',
"  \   'fileformat': 'LightLineFileformat',
"  \   'cocstatus': 'coc#status',
"  \   'currentfunction': 'CocCurrentFunction'
"  \ },
"  \ 'component_expand': {
"  \   'coc_error': 'LightlineCocErrors',
"  \   'coc_warning': 'LightlineCocWarnings',
"  \   'coc_info': 'LightlineCocInfos',
"  \   'coc_hint': 'LightlineCocHints',
"  \   'buffers': 'lightline#bufferline#buffers',
"  \ },
"  \ 'component_type': {
"  \   'coc_error': 'error',
"  \   'coc_warning': 'warning',
"  \   'coc_info': 'tabsel',
"  \   'coc_hint': 'middle',
"  \   'coc_fix': 'middle',
"  \   'buffers': 'tabsel',
"  \ },
"  \ 'separator': {
"  \     'left': '', 'right': ''
"  \ },
"  \ 'subseparator': {
"  \     'left': '', 'right': ''
"  \ }
"  \}
"
"let g:lightline.colorscheme = "forest_night"
"
"" lighline functions
"function! FileName()
"  "let l:fn = expand("%:t")
"  let l:fn = expand("%")
"  let l:ro = &ft !~? 'help' && &readonly ? " RO" : ""
"  let l:mo = &modifiable && &modified ? " +" : ""
"  return l:fn . l:ro . l:mo
"endfunction
"
"function! GitBranch()abort
"  return !IsTree() ? exists('*fugitive#head') ? fugitive#head() : '' : ''
"endfunction
"
"" shows a nice representation of the current branch (needs a powerline font)
"function! LightlineFugitive()
"  if exists('*FugitiveHead')
"  	let branch = FugitiveHead()
"  	return branch !=# '' ? ''.branch : ''
"  endif
"  return ''
"endfunction
"
"function FileEncoding()
"  return winwidth(0) > 70 ? (strlen(&fenc) ? &enc : &enc) : ''
"endfunction
"
"function LightLineFiletype()
"  "return winwidth(0) > 70 ? (strlen(&filetype) ? ' ' . WebDevIconsGetFileTypeSymbol() . ' ' . &filetype : '') : ''
"  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
"endfunction
"
"function! LightLineFileformat()
"  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
"endfunction
"
"function! IsTree()
"  let l:name = expand('%:t')
"  return l:name =~ 'NetrwTreeListing\|undotree\|NERD' ? 1 : 0
"endfunction
"
"""""""""""""""""
"let g:lightline#bufferline#show_number  = 2
"let g:lightline#bufferline#shorten_path = 1
"let g:lightline#bufferline#enable_devicons = 1
"let g:lightline#bufferline#unicode_symbols = 1
"let g:lightline#bufferline#filename_modifier = ':t'
"let g:lightline#bufferline#unnamed      = '[No Name]'
"let g:lightline#bufferline#clickable = 1
"
""let g:lightline#bufferline#number_map = {
""  \ 0: '⓿ ', 1: '❶ ', 2: '❷ ', 3: '❸ ', 4: '❹ ',
""  \ 5: '❺ ', 6: '❻ ', 7: '❼ ', 8: '❽ ', 9: '❾ '}
"

"function! CocCurrentFunction()
"    return get(b:, 'coc_current_function', '')
"endfunction
"
"autocmd BufWritePost,TextChanged,TextChangedI * call lightline#update()
"
