" 先关掉 powerline font 支持,不然 tmux 穿模...
" https://github.com/vim-airline/vim-airline/issues/1745#issuecomment-397060719
let g:airline_powerline_fonts = 1
"let g:airline_symbols_ascii = 1
"let g:airline_theme = 'bubblegum'
"let g:airline_theme = 'ayu_dark'
"let g:airline_theme = 'one'
"let g:airline_theme = 'nord'
"let g:airline_theme = 'wombat'
"let g:airline_theme = 'one'
"let g:airline_theme = 'gruvbox'
let g:airline_theme = 'forest_night'
"let g:airline_theme = 'molokai'

if !exists('g:airline_symbols')
   let g:airline_symbols = {}
endif

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
"let g:airline_left_sep = ''
"let g:airline_left_alt_sep = ''
"let g:airline_right_sep = ''
"let g:airline_right_alt_sep = ''
"let g:airline_left_sep = ''
"let g:airline_left_alt_sep = ''
"let g:airline_right_sep = ''
"let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = ''
"let g:airline_symbols.paste = 'Þ'
"let g:airline_symbols.spell = ''
"let g:airline_symbols.notexists = 'Ɇ'
"let g:airline_symbols.whitespace = 'Ξ'

" unicode symbols
"let g:airline_left_sep = '»'
"let g:airline_left_sep = '▶'
"let g:airline_right_sep = '«'
"let g:airline_right_sep = '◀'
"let g:airline_symbols.linenr = '␊'
"let g:airline_symbols.linenr = '␤'
"let g:airline_symbols.linenr = '¶'
"let g:airline_symbols.branch = '⎇'
"let g:airline_symbols.paste = 'ρ'
"let g:airline_symbols.paste = 'Þ'
"let g:airline_symbols.paste = '∥'
"let g:airline_symbols.whitespace = 'Ξ'



"打开 airline 提供的 tabline, 不使用 buffet 的
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'default'

" 开启 coc
let g:airline#extensions#coc#enabled = 1
let airline#extensions#coc#error_symbol = '✖'
let airline#extensions#coc#warning_symbol = '⚠'

" 关闭 ale 支持
let g:airline#extensions#ale#enabled = 0
" 关闭 vista 支持
let g:airline#extensions#vista#enabled=0
