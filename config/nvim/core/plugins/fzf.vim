" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_buffers_jump = 1

" map <C-f> :Files<CR>
" map <leader>b :Buffers<CR>
" nnoremap <leader>g :Rg<CR>
" nnoremap <leader>t :Tags<CR>
" nnoremap <leader>m :Marks<CR>


let g:fzf_tags_command = 'ctags -R'
" Border color
let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', 'border': 'sharp' } }

let $FZF_DEFAULT_OPTS = '--layout=reverse --inline-info'
let $FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git/**'"
"-g '!{node_modules,.git}'

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

"Get Files
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--inline-info']}), <bang>0)


" Get text in files with Rg
" command! -bang -nargs=* Rg
"   \ call fzf#vim#grep(
"   \   "rg --column --line-number --no-heading --color=always --smart-case --glob '!.git/**' ".shellescape(<q-args>), 1,

 " Make Ripgrep ONLY search file contents and not filenames
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --hidden --smart-case --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
  \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4.. -e'}, 'right:50%', '?'),
  \   <bang>0)

" Ripgrep advanced
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" Git grep
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)













""set wildmode=list:longest,list:full
"set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
"let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"
""let $FZF_DEFAULT_COMMAND = 'ag --hidden -l -g ""'
"" ripgrep
""if executable('rg')
""    let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
""    set grepprg=rg\ --vimgrep
""    command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
""endif
"
"" use rg by default
"if executable('rg')
"  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
"  set grepprg=rg\ --vimgrep
"endif
"
"let $FZF_DEFAULT_OPTS='--layout=reverse'
""let g:fzf_layout = { 'down': '~25%' }
"let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
""let g:fzf_preview_window = 'down:30%'
""let g:fzf_layout = { 'window': 'call CreateCenteredFloatingWindow()' }
"
"" advanced grep(faster with preview)
"function! RipgrepFzf(query, fullscreen)
"    let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
"    let initial_command = printf(command_fmt, shellescape(a:query))
"    let reload_command = printf(command_fmt, '{q}')
"    let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
"    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
"endfunction
"command! -nargs=* -bang Rg call RipgrepFzf(<q-args>, <bang>0)
"
"" floating fzf window with borders
""function! CreateCenteredFloatingWindow()
""    "let width = min([&columns - 4, max([80, &columns - 20])])
""    "let height = min([&lines - 4, max([20, &lines - 10])])
""    let width = float2nr(&columns * 0.6)
""    let height = float2nr(&lines * 0.6)
""    let top = ((&lines - height) / 2) - 1
""    let left = (&columns - width) / 2
""    let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}
""
""    let top = "╭" . repeat("─", width - 2) . "╮"
""    let mid = "│" . repeat(" ", width - 2) . "│"
""    let bot = "╰" . repeat("─", width - 2) . "╯"
""    let lines = [top] + repeat([mid], height - 2) + [bot]
""    let s:buf = nvim_create_buf(v:false, v:true)
""    call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
""    call nvim_open_win(s:buf, v:true, opts)
""    set winhl=Normal:Floating
""    let opts.row += 1
""    let opts.height -= 2
""    let opts.col += 2
""    let opts.width -= 4
""    call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
""    au BufWipeout <buffer> exe 'bw '.s:buf
""endfunction
