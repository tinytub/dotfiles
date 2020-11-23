let s:user_zshrc = expand($HOME . '/.zshrc')

let g:clap_cache_directory = $DATA_PATH . '/clap'
let g:clap_disable_run_rooter = v:true
"let g:clap_theme = 'gruvbox_light'
let g:clap_theme = 'atom_dark'
"let g:clap_theme = 'solarized'
"let g:clap_theme = 'material_design_dark'
let g:clap_current_selection_sign = {
	\ 'text': '',
	\ 'texthl': 'ClapCurrentSelection',
	\ 'linehl': 'ClapCurrentSelection',
	\ }
let g:clap_selected_sign = {
	\ 'text': '',
	\ 'texthl': 'ClapSelected',
	\ 'linehl': 'ClapSelected',
	\ }
let g:clap_layout = { 'relative': 'editor' }
"let g:clap_enable_icon = 1
"let g:clap_search_box_border_style = 'curve'
"let g:clap_provider_grep_enable_icon = 1
let g:clap_prompt_format = '%spinner%%forerunner_status% %provider_id%: '
let g:clap_enable_background_shadow = v:false

"let g:clap_provider_grep_delay = 50
"let g:clap_provider_grep_opts = '-H --no-heading --vimgrep --smart-case --hidden -g "!.git/"'

highlight! link ClapMatches Function
highlight! link ClapNoMatchesFound WarningMsg

"" A funtion to config highlight of ClapSymbol
"" when the background color is opactiy
"function! s:ClapSymbolHL() abort
"    let s:current_bgcolor = synIDattr(hlID("Normal"), "bg")
"    if s:current_bgcolor == ''
"        hi ClapSymbol guibg=NONE ctermbg=NONE
"    endif
"endfunction
"
"autocmd User ClapOnEnter call s:ClapSymbolHL()

"function! MyClapOnEnter() abort
"  augroup ClapEnsureAllClosed
"    autocmd!
"    autocmd BufEnter,WinEnter,WinLeave * ++once call clap#floating_win#close()
"  augroup END
"endfunction
"
"autocmd User ClapOnEnter call MyClapOnEnter()

autocmd FileType clap_input call s:clap_mappings()
function! s:clap_mappings()
    nnoremap <silent> <buffer> <nowait>' :call clap#handler#tab_action()<CR>
    inoremap <silent> <buffer> <Tab>   <C-R>=clap#navigation#linewise('down')<CR>
    inoremap <silent> <buffer> <S-Tab> <C-R>=clap#navigation#linewise('up')<CR>
    nnoremap <silent> <buffer> <C-f> :<c-u>call clap#navigation#scroll('down')<CR>
    nnoremap <silent> <buffer> <C-b> :<c-u>call clap#navigation#scroll('up')<CR>

    "nnoremap <silent> <buffer> sg  :<c-u>call clap#handler#try_open('ctrl-v')<CR>
    "nnoremap <silent> <buffer> sv  :<c-u>call clap#handler#try_open('ctrl-x')<CR>
    "nnoremap <silent> <buffer> st  :<c-u>call clap#handler#try_open('ctrl-t')<CR>

    nnoremap <silent> <buffer> q     :<c-u>call clap#handler#exit()<CR>
    nnoremap <silent> <buffer> <Esc> :call clap#handler#exit()<CR>
    inoremap <silent> <buffer> <Esc> <C-R>=clap#navigation#linewise('down')<CR><C-R>=clap#navigation#linewise('up')<CR><Esc>
    inoremap <silent> <buffer> jj    <C-R>=clap#navigation#linewise('down')<CR><C-R>=clap#navigation#linewise('up')<CR><Esc>
endfunction
