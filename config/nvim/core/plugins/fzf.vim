set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"
"let $FZF_DEFAULT_COMMAND = 'ag --hidden -l -g ""'
" ripgrep
"if executable('rg')
"    let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
"    set grepprg=rg\ --vimgrep
"    command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
"endif

let $FZF_DEFAULT_OPTS='--layout=reverse'
let g:fzf_layout = { 'window': 'call FloatingFZF()' }
function! FloatingFZF()
    let buf = nvim_create_buf(v:false, v:true)
    call setbufvar(buf, 'number', 'no')
    let height = float2nr(&lines/2)
    let width = float2nr(&columns - (&columns * 2 / 10))
    "let width = &columns
    let row = float2nr(&lines / 3)
    let col = float2nr((&columns - width) / 3)
    let opts = {
          \ 'relative': 'editor',
          \ 'row': row,
          \ 'col': col,
          \ 'width': width,
          \ 'height':height,
          \ }
    let win =  nvim_open_win(buf, v:true, opts)
    call setwinvar(win, '&number', 0)
    call setwinvar(win, '&relativenumber', 0)
endfunction
" Add fzf quit mapping
let g:fzf_preview_quit_map = 1
"https://gist.github.com/danmikita/d855174385b3059cd6bc399ad799555e
"" let g:fzf_buffers_jump = 1

" Use floating window (for neovim)
let g:fzf_preview_use_floating_window = 1
" floating window size ratio
let g:fzf_preview_floating_window_rate = 0.7
" floating window winblend value
let g:fzf_preview_floating_window_winblend = 15
" Commands used for fzf preview.
" The file name selected by fzf becomes {}
" let g:fzf_preview_command = 'head -100 {-1}'                       " Not installed bat
" let g:fzf_preview_command = 'bat --color=always --style=grid {-1}' " Installed bat
let g:fzf_preview_command = 'bat --color=always --style=grid --theme=ansi-dark {-1}'
" g:fzf_binary_preview_command is executed if this command succeeds, and g:fzf_preview_command is executed if it fails
let g:fzf_preview_if_binary_command = '[[ "$(file --mime {})" =~ binary ]]'
