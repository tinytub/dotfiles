"let g:floaterm_position = 'center'
"let g:floaterm_wintype = 'floating'
"let g:floaterm_width=min([ &columns - 2, 400 ])
let g:floaterm_height=min([&lines - 2, max([20, &lines / 3])])
let g:floaterm_position='bottomleft'
"let g:floaterm_open_in_root='true'
"
"let g:floaterm_keymap_toggle = '<Leader>tt'
""let g:floaterm_keymap_next   = '<Leader>.'
""let g:floaterm_keymap_prev   = '<Leader>,'
"let g:floaterm_keymap_new    = '<Leader>tn'
"let g:floaterm_keymap_kill   = '<Leader>tk'

" Set floaterm window's background to black
hi Floaterm guibg=black
" Set floating window border line color to cyan, and background to orange
hi FloatermBorder guibg=none guifg=cyan

