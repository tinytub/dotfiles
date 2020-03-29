let g:ale_disable_lsp = 0
let g:ale_echo_delay = 100
let g:ale_lint_delay = 1000
let g:ale_echo_msg_format = '[%linter%] %code: %%s [%severity%]'
let g:ale_history_enabled = 0
let g:ale_sign_error = '🔥'
let g:ale_sign_warning = '🤔'
let g:ale_echo_msg_error_str = '✖'
let g:ale_echo_msg_warning_str = '⚠'
let g:ale_maximum_file_size = 500000

"仅仅在保存的时候跑 ale
"let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_text_changed = 'never'
" if you don't want linters to run on opening a file
let g:ale_lint_on_enter = 1
"let g:ale_change_sign_column_color = 1
"let g:ale_close_preview_on_insert = 1
" 关闭本地列表,使用 quickfix
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
"let g:ale_list_vertical = 1
"let g:ale_open_list = 0
let g:ale_sign_column_always = 1
let g:ale_set_highlights = 0
"let g:ale_sign_error = '✖'
"let g:ale_sign_warning = '⚠'
"let g:ale_echo_msg_format = '%severity% %s [%linter%% %code%]'
" 下降低语法检查程序的进程优先级（不要卡到前台进程）
"let g:ale_command_wrapper = 'nice -n5'
" for golang
"let g:ale_linters = {'go': ['gopls'],'python': ['flake8','pylint']}
"先整体关掉这些 lint,由 coc 来接管
let g:ale_linters = {
\   'c': [], 'cpp': [], 'rust': [], 'go': [], 'python': [], 'sh': [],
\   'html': [], 'css': [], 'javascript': [], 'typescript': [], 'reason': [],
\   'json': [], 'vue': [],
\   'tex': [], 'latex': [], 'bib': [], 'bibtex': []
\ }
let b:ale_fixers = {'python':['autopep8', 'yapf']}
let g:ale_go_golangci_lint_options = '--fast --disable=errcheck --disable=deadcode --disable=ineffassign'
let g:ale_go_golangci_lint_package = 1
"let g:ale_go_gometalinter_options = '--fast --disable=gas --disable=goconst --disable=gocyclo --deadline=1s'
"let g:ale_go_gometalinter_options = '--fast'
"let g:ale_go_gometalinter_lint_package = 1
let g:ale_python_flake8_options="--ignore=E114,E116,E131 --max-line-length=120"

let g:ale_fixers = {}
let g:ale_fixers['javascript'] = ['prettier']
let g:ale_fixers['typescript'] = ['prettier', 'tslint']
let g:ale_fixers['json'] = ['prettier']
let g:ale_fixers['css'] = ['prettier']
" fixers 由 vim-go 暂时接管
let g:ale_fixers['go'] = []
"let g:ale_fixers['golang'] = ['gofmt', 'goimports']
let g:ale_javascript_prettier_use_local_config = 1
let g:ale_fix_on_save = 1

" 打开 ale 错误列表
function! AleListToggle()
    if !exists('g:ale_open_list')
        return
    endif
    if(g:ale_open_list == 0)
        "ALEDisableBuffer
        let g:ale_open_list = 1
        "ALEEnableBuffer
        copen
        "lopen
    else
        let g:ale_open_list = 0
        cclose
        "lclose
        return
    endif
endfunction

nnoremap <silent> <F5> :call AleListToggle()<CR>
