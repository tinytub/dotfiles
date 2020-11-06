"let g:buffet_always_show_tabline = 1
"let g:buffet_show_index = 1
"let g:buffet_powerline_separators = 1
"let g:buffet_tab_icon = "\uf00a"
"let g:buffet_left_trunc_icon = "\uf0a8"
"let g:buffet_right_trunc_icon = "\uf0a9"
let g:buffet_tab_icon = "﬘"
let g:buffet_new_buffer_name = "☲"
let g:buffet_powerline_separators = 1
let g:buffet_show_index = 1
let g:buffet_use_devicons = 0
let g:buffet_hidden_buffers = ['terminal']

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

"function! g:BuffetSetCustomColors()
"    hi! link BuffetCurrentBuffer TabLineSel
"    hi! link BuffetActiveBuffer  TabAlt
"    hi! link BuffetBuffer        TabLine
"    hi! link BuffetTab           Block
"    "hi! BuffetCurrentBuffer cterm=NONE ctermbg=106 ctermfg=8 guibg=#b8bb26 guifg=#000000
"    "hi! BuffetTrunc cterm=bold ctermbg=66 ctermfg=8 guibg=#458588 guifg=#000000
"    "hi! BuffetBuffer cterm=NONE ctermbg=239 ctermfg=8 guibg=#504945 guifg=#000000
"    "hi! BuffetTab cterm=NONE ctermbg=66 ctermfg=8 guibg=#458588 guifg=#000000
"    "hi! BuffetActiveBuffer cterm=NONE ctermbg=10 ctermfg=239 guibg=#999999 guifg=#504945
""    if &background == 'dark'
""            hi! BuffetCurrentBuffer guibg=#528bff guifg=#2C323C
""            hi! BuffetActiveBuffer guibg=#528bff guifg=#2C323C
""            hi! BuffetBuffer guifg=#abb2bf guibg=#282c34
""            hi! BuffetTab guifg=#2C323C guibg=#C678DD
""        else
""            hi! BuffetCurrentBuffer guibg=#528bff guifg=#2C323C
""            hi! BuffetActiveBuffer guibg=#528bff guifg=#2C323C
""            hi! BuffetBuffer guifg=#abb2bf guibg=#282c34
""            hi! BuffetTab guifg=#2C323C guibg=#C678DD
""    endif
"
""    if g:colors_name == 'one'
""        if &background == 'dark'
""            hi! BuffetCurrentBuffer guibg=#528bff guifg=#2C323C
""            hi! BuffetActiveBuffer guibg=#528bff guifg=#2C323C
""            hi! BuffetBuffer guifg=#abb2bf guibg=#282c34
""            hi! BuffetTab guifg=#2C323C guibg=#C678DD
""        else
""            hi! BuffetCurrentBuffer guibg=#528bff guifg=#2C323C
""            hi! BuffetActiveBuffer guibg=#528bff guifg=#2C323C
""            hi! BuffetBuffer guifg=#abb2bf guibg=#282c34
""            hi! BuffetTab guifg=#2C323C guibg=#C678DD
""        endif
""    elseif g:colors_name == 'gruvbox'
""        hi! BuffetCurrentBuffer guibg=#5482FF guifg=white
""        hi! BuffetActiveBuffer guibg=#1F1F24 guifg=white
""        hi! BuffetBuffer guifg=#1F1F24 guibg=white
""        hi! BuffetTab guifg=white guibg=#1F1F24
""    endif
"endfunction
