
" For startify
let g:startify_padding_left = 30
let s:header = []
let s:footer = []

function! s:center(lines) abort
  let longest_line   = max(map(copy(a:lines), 'strwidth(v:val)'))
  let centered_lines = map(copy(a:lines),
        \ 'repeat(" ", (&columns / 2) - (longest_line / 2)) . v:val')
  return centered_lines
endfunction

let g:startify_custom_header = s:center(s:header)
let g:startify_custom_footer = s:center(s:footer)
autocmd! FileType startify
autocmd  FileType startify set laststatus=0
  \| autocmd BufLeave <buffer> set laststatus=2

autocmd User Startified setlocal buflisted
