let g:lightline = {
    \   'colorscheme': 'forest_night',
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
    return "\uE725" . (exists('*FugitiveHead') ? ' ' . fugitive#head() : '')
endfunction

function! CurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

function! GitBlame()
    return winwidth(0) > 100 ? strpart(substitute(get(b:, 'coc_git_blame', ''), '[\(\)]', '', 'g'), 0, 50) : ''
endfunction

