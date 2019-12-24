" ----------------------------------------------------------------------------
"  插件加载
" ----------------------------------------------------------------------------
call functions#PlugLoad()
call plug#begin('~/.config/nvim/plugged')

    " 还是需要再把插件详细分类一下
    " 配色大全
    " Plug 'sheerun/vim-polyglot'

    " 启动页
    Plug 'mhinz/vim-startify'

    " tmux integration for vim
    Plug 'benmills/vimux'

    "displays available keybindings in popup.
    "Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] , 'do': function('RegisterWhichKey') }
    Plug 'liuchengxu/vim-which-key'
 
    Plug 'sbdchd/neoformat', {'on': ['Neoformat','Neoformat!']}

    " Better file browser
    "Plug 'scrooloose/nerdtree'
    "Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'ryanoasis/vim-devicons'

    "Plug 'tiagofumo/vim-nerdtree-syntax-highlight'


    Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins'}
    Plug 'kristijanhusak/defx-git'
    Plug 'kristijanhusak/defx-icons'

    " tab控制,和 ale 有冲突,暂时不用
    "Plug 'bagrat/vim-buffet'

    " Class/module 浏览器
    " tag 管理工具
    " 可以同vista, tagbar 搭配使用
    Plug 'ludovicchabant/vim-gutentags'

    " Zen coding
    Plug 'mattn/emmet-vim'

    " 可能是最好的 git 继承插件
    " 同 coc-git 一起食用
    Plug 'tpope/vim-fugitive'

    " Airline
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    " Surround
    Plug 'tpope/vim-surround'

    "Plug 'liuchengxu/vista.vim', {'on': ['Vista', 'Vista!', 'Vista!!']}
    Plug 'liuchengxu/vista.vim'
    "Plug 'Yggdroot/indentLine' 

    " Better autocompletion 暂时先使用 coc
    "if has('nvim')
    "  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    "else
    "  Plug 'Shougo/deoplete.nvim'
    "  Plug 'roxma/nvim-yarp'
    "  Plug 'roxma/vim-hug-neovim-rpc'
    "endif
    "" deoplete golang 插件, 需要手动make
    "Plug 'zchee/deoplete-go' , {'for':'go', 'do': 'make'}

    " 据说比 deoplete 好用
    Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}

    " python 补全插件
    Plug 'davidhalter/jedi-vim' , {'for': ['python', 'python3']}

    " Plugin 'joshdick/onedark.vim'
    Plug 'morhetz/gruvbox'
    Plug 'taigacute/gruvbox9'
    " gruvbox 如果颜色不对,尝试执行~/.vim/bundle/gruvbox/gruvbox_256palette.sh 或 ~/.vim/bundle/gruvbox/gruvbox_256palette_osx.sh

    Plug 'jacoborus/tender.vim'
    Plug 'joshdick/onedark.vim'
    Plug 'dracula/vim', { 'as': 'dracula' }

    "" Git/mercurial/others diff icons on the side of the file lines
    "Plug 'mhinz/vim-signify'

    " Window chooser
    Plug 't9md/vim-choosewin'
    " Asynchonous linting engine
    Plug 'w0rp/ale'

    " JS 相关暂时用不到
    
    " Golang Plugins
    Plug 'fatih/vim-go', {'for':'go', 'do': ':GoInstallBinaries' }

    "Plug 'plasticboy/vim-markdown'
    Plug 'tpope/vim-markdown'

    "JSON TOML XML
    Plug 'elzr/vim-json', { 'for': 'json' }
    let g:vim_json_syntax_conceal = 0
    Plug 'cespare/vim-toml', { 'for': 'toml' }
    Plug 'vim-scripts/xml.vim', { 'for': 'xml' }
    Plug 'pearofducks/ansible-vim', { 'for': ['ansible_host','yaml.ansible'] }


    " 传说中的自动补全神器?
    "git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    "~/.fzf/install
    if has("nvim")
        Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
        Plug 'junegunn/fzf.vim'
        " 黑魔法查询框架, 先不用,后期可以看看thinkvim 的配置
        Plug 'Shougo/denite.nvim'
    endif
call plug#end()




" ----------------------------------------------------------------------------
" 插件配置
" ----------------------------------------------------------------------------

" Polyglot
    let g:polyglot_disabled = ['go']

" vista  tags 展示,类似 tagbar,但是使用虚拟窗口
let g:vista#renderer#enable_icon = 1
let g:vista_default_executive = 'ctags'
let g:vista_fzf_preview = ['right:50%']

let g:vista_executive_for = {
  \ 'go': 'ctags',
  \ 'javascript': 'coc',
  \ 'javascript.jsx': 'coc',
  \ 'python': 'ctags',
  \ }

" gutentags tags管理
let g:gutentags_cache_dir = $VARPATH . '/tags'
let g:gutentags_project_root = ['.root', '.git', '.svn', '.hg', '.project','go.mod','/usr/local']
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_new = 0
let g:gutentags_exclude_filetypes = [ 'defx', 'denite', 'vista', 'magit' ]
let g:gutentags_ctags_extra_args = ['--output-format=e-ctags']
let g:gutentags_ctags_exclude = ['*.json', '*.js', '*.ts', '*.jsx', '*.css', '*.less', '*.sass', '*.go', '*.dart', 'node_modules', 'dist', 'vendor']


" indentline
""    let g:indentline_enabled = 1
""    let g:indentline_char='┆'
""    let g:indentLine_fileTypeExclude = ['defx', 'denite','startify','tagbar','vista_kind','vista']
""    let g:indentLine_concealcursor = 'niv'
""    let g:indentLine_color_term = 96
""    let g:indentLine_color_gui= '#725972'
""    let g:indentLine_showFirstIndentLevel =1

" Tagbar -----------------------------
" 可以改成 fzf+vista 或者直接使用 denite
" https://github.com/hardcoreplayers/ThinkVim/issues/29
    " toggle tagbar display
"    map <F4> :TagbarToggle<CR>
"    nnoremap <silent> <LocalLeader>t :<C-u>TagbarToggle<CR>
"    " autofocus on tagbar open
"    let g:tagbar_autofocus = 1
"    "autocmd BufReadPost *.cpp,*.c,*.h,*.go,*.cc,*.py call tagbar#autoopen()
"    let g:tagbar_width=25
"    let g:tagbar_type_go = {
"        \ 'ctagstype' : 'go',
"        \ 'kinds' : [
"            \ 'p:package',
"            \ 'i:imports:1',
"            \ 'c:constants',
"            \ 'v:variables',
"            \ 't:types',
"            \ 'n:interfaces',
"            \ 'w:fields',
"            \ 'e:embedded',
"            \ 'm:methods',
"            \ 'r:constructor',
"            \ 'f:functions'
"        \ ],
"        \ 'sro' : '.',
"        \ 'kind2scope' : {
"            \ 't' : 'ctype',
"            \ 'n' : 'ntype'
"        \ },
"        \ 'scope2kind' : {
"            \ 'ctype' : 't',
"            \ 'ntype' : 'n'
"        \ },
"        \ 'ctagsbin' : 'gotags',
"        \ 'ctagsargs' : '-sort -silent'
"        \ }

" NERDTree -----------------------------
""    " 切换 nerdtre 显示
""    " map <F3> :NERDTreeToggle<CR>
""    " 打开 nerdree 并选中当前打开的文件
""    map <F3> :call ToggleNerdTree()<CR>
""
""
""    let g:WebDevIconsOS = 'Darwin'
""    let g:WebDevIconsUnicodeDecorateFolderNodes = 1
""    "let g:WebDevIconsUnicodeDecorateFolderNodes = v:true
""    let g:WebDevIconsNerdTreeBeforeGlyphPadding = ''
""    let g:DevIconsEnableFoldersOpenClose = 1
""    let g:DevIconsEnableFolderExtensionPatternMatching = 1
""    let NERDTreeDirArrowExpandable = "\u00a0" " make arrows invisible
""    let NERDTreeDirArrowCollapsible = "\u00a0" " make arrows invisible
""    let NERDTreeNodeDelimiter = "\u263a" " smiley face
""
""    " 不要显示如下文件类型
""    let NERDTreeIgnore=['\.o','\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
""
""    " 自动开关 NERDTree
""    autocmd vimenter * if !argc() | NERDTree | endif
""    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
""
""    augroup nerdtree
""        autocmd!
""        autocmd FileType nerdtree setlocal nolist " turn off whitespace characters
""        autocmd FileType nerdtree setlocal nocursorline " turn off line highlighting for performance
""    augroup END
""
""    " Toggle NERDTree
""    function! ToggleNerdTree()
""        if @% != "" && @% !~ "Startify" && (!exists("g:NERDTree") || (g:NERDTree.ExistsForTab() && !g:NERDTree.IsOpen()))
""            :NERDTreeFind
""        else
""            :NERDTreeToggle
""        endif
""    endfunction
""
""    " " find the current file in nerdtree without needing to reload the drawer
""    nmap <silent> <leader>y :NERDTreeFind<cr>
""
""    let NERDTreeShowHidden=1
""    " let NERDTreeDirArrowExpandable = '▷'
""    " let NERDTreeDirArrowCollapsible = '▼'
""    let g:NERDTreeIndicatorMapCustom = {
""    \ "Modified"  : "✹",
""    \ "Staged"    : "✚",
""    \ "Untracked" : "✭",
""    \ "Renamed"   : "➜",
""    \ "Unmerged"  : "═",
""    \ "Deleted"   : "✖",
""    \ "Dirty"     : "✗",
""    \ "Clean"     : "✔︎",
""    \ 'Ignored'   : '☒',
""    \ "Unknown"   : "?"
""    \ }

" WhichKey
"    nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

" Defx 代替 nerdtree -----------------------------
" Defx settings
" ---
" See https://github.com/shougo/defx.nvim
" See https://github.com/rafi/vim-config/blob/master/config/plugins/defx.vim
    nnoremap <silent><F3> :call <sid>defx_open({ 'find_current_file': v:true })<CR>
    call defx#custom#option('_', {
    	\ 'columns': 'indent:git:icons:filename',
    	\ 'winwidth': 25,
    	\ 'split': 'vertical',
    	\ 'direction': 'topleft',
    	\ 'listed': 1,
    	\ 'show_ignored_files': 0,
    	\ 'root_marker': ' ',
    	\ 'ignored_files':
    	\     '.mypy_cache,.pytest_cache,.git,.hg,.svn,.stversions'
    	\   . ',__pycache__,.sass-cache,*.egg-info,.DS_Store,*.pyc'
    	\ })

    call defx#custom#column('git', {
    	\   'indicators': {
    	\     'Modified'  : '•',
    	\     'Staged'    : '✚',
    	\     'Untracked' : 'ᵁ',
    	\     'Renamed'   : '≫',
    	\     'Unmerged'  : '≠',
    	\     'Ignored'   : 'ⁱ',
    	\     'Deleted'   : '✖',
    	\     'Unknown'   : '⁇'
    	\   }
    	\ })

    call defx#custom#column('mark', { 'readonly_icon': '✗', 'selected_icon': '✓' })
    " call defx#custom#column('filename', { 'min_width': 20, 'max_width': -95 })

    " defx-icons plugin
    let g:defx_icons_column_length = 2
    let g:defx_icons_mark_icon = ''

    " Events
    " ---

    augroup user_plugin_defx
    	autocmd!

    	" FIXME
    	" autocmd DirChanged * call s:defx_refresh_cwd(v:event)

    	" Delete defx if it's the only buffer left in the window
    	" autocmd WinEnter * if &filetype == 'defx' && winnr('$') == 1 | q | endif

    	" Move focus to the next window if current buffer is defx
    	autocmd TabLeave * if &filetype == 'defx' | wincmd w | endif

    	autocmd TabClosed * call s:defx_close_tab(expand('<afile>'))

    	" Define defx window mappings
    	autocmd FileType defx call s:defx_mappings()

    augroup END

    " Internal functions
    " ---

    function! s:defx_close_tab(tabnr)
    	" When a tab is closed, find and delete any associated defx buffers
    	for l:nr in range(1, bufnr('$'))
    		let l:defx = getbufvar(l:nr, 'defx')
    		if empty(l:defx)
    			continue
    		endif
    		let l:context = get(l:defx, 'context', {})
    		if get(l:context, 'buffer_name', '') ==# 'tab' . a:tabnr
    			silent! execute 'bdelete '.l:nr
    			break
    		endif
    	endfor
    endfunction

    function! s:defx_toggle_tree() abort
    	" Open current file, or toggle directory expand/collapse
    	if defx#is_directory()
    		return defx#do_action('open_or_close_tree')
    	endif
    	return defx#do_action('multi', ['drop', 'quit'])
    endfunction

    function! s:defx_refresh_cwd(event)
    	" Automatically refresh opened Defx windows when changing working-directory
    	let l:cwd = get(a:event, 'cwd', '')
    	let l:scope = get(a:event, 'scope', '')   " global, tab, window
    	let l:is_opened = bufwinnr('defx') > -1
    	if ! l:is_opened || empty(l:cwd) || empty(l:scope)
    		return
    	endif

    	" Abort if Defx is already on the cwd triggered (new files trigger this)
    	let l:paths = get(getbufvar('defx', 'defx', {}), 'paths', [])
    	if index(l:paths, l:cwd) >= 0
    		return
    	endif

    	let l:tab = tabpagenr()
    	call execute(printf('Defx -buffer-name=tab%s %s', l:tab, l:cwd))
    	wincmd p
    endfunction

    function! s:jump_dirty(dir) abort
    	" Jump to the next position with defx-git dirty symbols
    	let l:icons = get(g:, 'defx_git_indicators', {})
    	let l:icons_pattern = join(values(l:icons), '\|')

    	if ! empty(l:icons_pattern)
    		let l:direction = a:dir > 0 ? 'w' : 'bw'
    		return search(printf('\(%s\)', l:icons_pattern), l:direction)
    	endif
    endfunction

    function! s:defx_mappings() abort
    	" Defx window keyboard mappings
    	setlocal signcolumn=no expandtab

    	nnoremap <silent><buffer><expr> <CR>  defx#do_action('drop')
    	nnoremap <silent><buffer><expr> l     <SID>defx_toggle_tree()
    	nnoremap <silent><buffer><expr> h     defx#async_action('cd', ['..'])
    	nnoremap <silent><buffer><expr> t     defx#do_action('multi', [['drop', 'tabnew'], 'quit'])
    	nnoremap <silent><buffer><expr> s     defx#do_action('open', 'botright vsplit')
    	nnoremap <silent><buffer><expr> i     defx#do_action('open', 'botright split')
    	nnoremap <silent><buffer><expr> P     defx#do_action('open', 'pedit')
    	nnoremap <silent><buffer><expr> K     defx#do_action('new_directory')
    	nnoremap <silent><buffer><expr> N     defx#do_action('new_multiple_files')
    	nnoremap <silent><buffer><expr> dd    defx#do_action('remove_trash')
    	nnoremap <silent><buffer><expr> r     defx#do_action('rename')
    	nnoremap <silent><buffer><expr> x     defx#do_action('execute_system')
    	nnoremap <silent><buffer><expr> .     defx#do_action('toggle_ignored_files')
    	nnoremap <silent><buffer><expr> yy    defx#do_action('yank_path')
    	nnoremap <silent><buffer><expr> ~     defx#async_action('cd')
    	nnoremap <silent><buffer><expr> q     defx#do_action('quit')
    	nnoremap <silent><buffer><expr> <Tab> winnr('$') != 1 ?
     		\ ':<C-u>wincmd w<CR>' :
     		\ ':<C-u>Defx -buffer-name=temp -split=vertical<CR>'
    	nnoremap <silent><buffer>       [g :<C-u>call <SID>jump_dirty(-1)<CR>
    	nnoremap <silent><buffer>       ]g :<C-u>call <SID>jump_dirty(1)<CR>

    	nnoremap <silent><buffer><expr><nowait> \  defx#do_action('cd', getcwd())
    	nnoremap <silent><buffer><expr><nowait> &  defx#do_action('cd', getcwd())
    	nnoremap <silent><buffer><expr><nowait> c  defx#do_action('copy')
    	nnoremap <silent><buffer><expr><nowait> m  defx#do_action('move')
    	nnoremap <silent><buffer><expr><nowait> p  defx#do_action('paste')

    	nnoremap <silent><buffer><expr><nowait> <Space>
    		\ defx#do_action('toggle_select') . 'j'

    	nnoremap <silent><buffer><expr> '      defx#do_action('toggle_select') . 'j'
    	nnoremap <silent><buffer><expr> *      defx#do_action('toggle_select_all')
    	nnoremap <silent><buffer><expr> <C-r>  defx#do_action('redraw')
    	nnoremap <silent><buffer><expr> <C-g>  defx#do_action('print')

    	nnoremap <silent><buffer><expr> S  defx#do_action('toggle_sort', 'Time')
    	nnoremap <silent><buffer><expr> C
    		\ defx#do_action('toggle_columns', 'indent:mark:filename:type:size:time')

    	" Tools
    	nnoremap <silent><buffer><expr> w   defx#do_action('call', '<SID>toggle_width')
    	nnoremap <silent><buffer><expr> gx  defx#async_action('execute_system')
    	nnoremap <silent><buffer><expr> gd  defx#async_action('multi', ['drop', ['call', '<SID>git_diff']])
    	nnoremap <silent><buffer><expr> gr  defx#do_action('call', '<SID>grep')
    	nnoremap <silent><buffer><expr> gf  defx#do_action('call', '<SID>find_files')
    	nnoremap <silent><buffer><expr> gl  defx#async_action('call', '<SID>explorer')
    endfunction

    " TOOLS
    " ---

    function! s:git_diff(context) abort
    	execute 'GdiffThis'
    endfunction

    function! s:find_files(context) abort
    	" Find files in parent directory with Denite
    	let l:target = a:context['targets'][0]
    	let l:parent = fnamemodify(l:target, ':h')
    	silent execute 'wincmd w'
    	silent execute 'Denite file/rec:'.l:parent
    endfunction

    function! s:grep(context) abort
    	" Grep in parent directory with Denite
    	let l:target = a:context['targets'][0]
    	let l:parent = fnamemodify(l:target, ':h')
    	silent execute 'wincmd w'
    	silent execute 'Denite grep:'.l:parent
    endfunction

    function! s:toggle_width(context) abort
    	" Toggle between defx window width and longest line
    	let l:max = 0
    	let l:original = a:context['winwidth']
    	for l:line in range(1, line('$'))
    		let l:len = len(getline(l:line))
    		if l:len > l:max
    			let l:max = l:len
    		endif
    	endfor
    	execute 'vertical resize ' . (l:max == winwidth('.') ? l:original : l:max)
    endfunction

    function! s:explorer(context) abort
    	" Open file-explorer split with tmux
    	let l:explorer = s:find_file_explorer()
    	if empty('$TMUX') || empty(l:explorer)
    		return
    	endif
    	let l:target = a:context['targets'][0]
    	let l:parent = fnamemodify(l:target, ':h')
    	let l:cmd = 'split-window -p 30 -c ' . l:parent . ' ' . l:explorer
    	silent execute '!tmux ' . l:cmd
    endfunction

    function! s:find_file_explorer() abort
    	" Detect terminal file-explorer
    	let s:file_explorer = get(g:, 'terminal_file_explorer', '')
    	if empty(s:file_explorer)
    		for l:explorer in ['lf', 'hunter', 'ranger', 'vifm']
    			if executable(l:explorer)
    				let s:file_explorer = l:explorer
    				break
    			endif
    		endfor
    	endif
    	return s:file_explorer
    endfunction

    function s:get_project_root() abort
      let l:git_root = ''
      let l:path = expand('%:p:h')
      let l:cmd = systemlist('cd '.l:path.' && git rev-parse --show-toplevel')
      if !v:shell_error && !empty(l:cmd)
        let l:git_root = fnamemodify(l:cmd[0], ':p:h')
      endif

      if !empty(l:git_root)
        return l:git_root
      endif

      return getcwd()
    endfunction

    function! s:defx_open(...) abort
      let l:opts = get(a:, 1, {})
      let l:is_file = has_key(l:opts, 'dir') && !isdirectory(l:opts.dir)

      if  &filetype ==? 'defx' || l:is_file
        return
      endif

      let l:path = s:get_project_root()

      if has_key(l:opts, 'dir') && isdirectory(l:opts.dir)
        let l:path = l:opts.dir
      endif

      let l:args = '-winwidth=40 -direction=topleft -split=vertical'

      if has_key(l:opts, 'find_current_file')
        call execute(printf('Defx %s -search=%s %s', l:args, expand('%:p'), l:path))
      else
        call execute(printf('Defx -toggle %s %s', l:args, l:path))
        call execute('wincmd p')
      endif

      return execute("norm!\<C-w>=")
    endfunction

" FZF ----------------------------------------
    let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit' }
    
    " Customize fzf colors to match your color scheme
    let g:fzf_colors =
    \ { 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', '#5f5f87'],
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
    
    let g:fzf_commits_log_options = '--graph --color=always
      \ --format="%C(yellow)%h%C(red)%d%C(reset)
      \ - %C(bold green)(%ar)%C(reset) %s %C(blue)<%an>%C(reset)"'
    
    "let $FZF_DEFAULT_COMMAND = 'ag --hidden -l -g ""'
    " ripgrep
    if executable('rg')
        let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
        set grepprg=rg\ --vimgrep
        command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
    endif
    
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
    
    " Files + devicons
    function! Fzf_dev()
    let l:fzf_files_options = ' -m --bind ctrl-d:preview-page-down,ctrl-u:preview-page-up --preview "bat --color always --style numbers {2..}"'
        function! s:files()
            let l:files = split(system($FZF_DEFAULT_COMMAND), '\n')
            return s:prepend_icon(l:files)
            "return l:files
        endfunction
        function! s:prepend_icon(candidates)
            let result = []
            for candidate in a:candidates
                let filename = fnamemodify(candidate, ':p:t')
                let icon = WebDevIconsGetFileTypeSymbol(filename, isdirectory(filename))
                call add(result, printf("%s %s", icon, candidate))
            endfor
            return result
        endfunction
        function! s:edit_file(items)
            let items = a:items
            let i = 1
            let ln = len(items)
            while i < ln
                let item = items[i]
                let parts = split(item, ' ')
                let file_path = get(parts, 1, '')
                let items[i] = file_path
                let i += 1
            endwhile
            call s:Sink(items)
        endfunction
        let opts = fzf#wrap({})
        let opts.source = <sid>files()
        let s:Sink = opts['sink*']
        let opts['sink*'] = function('s:edit_file')
        let opts.options .= l:fzf_files_options
        call fzf#run(opts)
    endfunction

" ALE
    "仅仅在保存的时候跑 ale
    "let g:ale_lint_on_text_changed = 'normal'
    let g:ale_lint_on_text_changed = 'never'
    " You can disable this option too
    " if you don't want linters to run on opening a file
    let g:ale_lint_on_enter = 1

    let g:ale_set_highlights = 1
    "let g:ale_change_sign_column_color = 1


    " 关闭本地列表,使用 quickfix
    let g:ale_set_loclist = 0
    let g:ale_set_quickfix = 1
    "let g:ale_list_vertical = 1
    let g:ale_open_list = 0

    let g:ale_sign_column_always = 0
    "let g:ale_sign_error = '✖'
    "let g:ale_sign_warning = '⚠'
    let g:ale_sign_error = '🔥'
    let g:ale_sign_warning = '🤔'
    let g:ale_echo_msg_error_str = '✖'
    let g:ale_echo_msg_warning_str = '⚠'
    let g:ale_echo_msg_format = '[%linter%] %code: %%s [%severity%]'
    "let g:ale_echo_msg_format = '%severity% %s [%linter%% %code%]'

    " 下降低语法检查程序的进程优先级（不要卡到前台进程）
    "let g:ale_command_wrapper = 'nice -n5'



    " for golang
    "let g:ale_linters = {'go': ['golint','govet','gobuild','gopls'],'python': ['flake8','pylint']}
    "let g:ale_linters = {'go': ['gopls','golint'],'python': ['flake8','pylint']}
    let g:ale_linters = {'go': ['golangci-lint'],'python': ['flake8','pylint']}
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

" vim-devicons
    let g:webdevicons_enable = 1
    let g:webdevicons_enable_denite = 1

"" deoplete 相关配置
"    " ---
"    " let g:deoplete#enable_profile = 1
"    " call deoplete#enable_logging('DEBUG', 'deoplete.log')<CR>
"    " call deoplete#custom#source('tern', 'debug_enabled', 1)<CR>
"    " " General settings "  参考https://github.com/rafi/vim-config/config/plugins/deoplete.vim
"    " ---
"    " let g:deoplete#auto_complete_delay = 50  " Default is 50
"    " let g:deoplete#auto_refresh_delay = 500  " Default is 500
"    " let g:deoplete#auto_complete_delay = 50  " Default is 50
"    " let g:deoplete#auto_refresh_delay = 500  " Default is 500
"
"    " let g:deoplete#sources#go#debug#log_file = '/tmp/deoplete-go.log'
"
"    let g:deoplete#enable_refresh_always = 1
"    let g:deoplete#enable_camel_case = 1
"    let g:deoplete#max_abbr_width = 35
"    let g:deoplete#max_menu_width = 20
"    let g:deoplete#skip_chars = ['(', ')', '<', '>']
"    let g:deoplete#tag#cache_limit_size = 800000
"    let g:deoplete#file#enable_buffer_path = 1
"
"    let g:deoplete#sources#jedi#statement_length = 30
"    let g:deoplete#sources#jedi#show_docstring = 1
"    let g:deoplete#sources#jedi#short_types = 1
"    "let g:deoplete#sources#jedi#enable_typeinfo = 0
"
"    let g:deoplete#sources#ternjs#filetypes = [
"        \ 'jsx',
"        \ 'javascript.jsx',
"        \ 'vue',
"        \ 'javascript'
"        \ ]
"
"    let g:deoplete#sources#ternjs#timeout = 3
"    let g:deoplete#sources#ternjs#types = 1
"    let g:deoplete#sources#ternjs#docs = 1
"
"    call deoplete#custom#source('_', 'min_pattern_length', 2)
"
"    " }}}
"    " Limit Sources " 
"    " ---
"
"    "let g:deoplete#sources = get(g:, 'deoplete#sources', {})
"    "let g:deoplete#sources.go = ['vim-go']
"    "let g:deoplete#ignore_sources = get(g:, 'deoplete#ignore_sources', {})
"
"
"    " deoplete 我的 go 相关配置
"    let g:deoplete#enable_at_startup = 1
"    let g:deoplete#sources#go#gocode_binary = '$GOPATH/bin/gocode'
"    " let g:deoplete#file#enable_buffer_path=1
"    let g:deoplete#sources#go#pointer = 1
"    let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const', 'pointer']
"    let g:deoplete#keyword_patterns={}
"    "let g:deoplete#keyword_patterns.clojure='[\w!$%&*+/:<=>?@\^_~\-\.]*'
"
"    " <Tab> completion:
"    " 1. If popup menu is visible, select and insert next item
"    " 2. Otherwise, if within a snippet, jump to next input
"    " 3. Otherwise, if preceding chars are whitespace, insert tab char
"    " 4. Otherwise, start manual autocomplete
"    imap <silent><expr><Tab> pumvisible() ? "\<Down>"
"        \ : (<SID>is_whitespace() ? "\<Tab>"
"        \ : deoplete#manual_complete())
"
"    smap <silent><expr><Tab> pumvisible() ? "\<Down>"
"        \ : (<SID>is_whitespace() ? "\<Tab>"
"        \ : deoplete#manual_complete())
"
"    inoremap <expr><S-Tab>  pumvisible() ? "\<Up>" : "\<C-h>"
"
"    function! s:is_whitespace()
"        let col = col('.') - 1
"        return ! col || getline('.')[col - 1] =~? '\s'
"    endfunction
"
"    " 解决 vim-multiple-cursors deoplete 冲突问题
"    function! Multiple_cursors_before()
"        let g:deoplete#disable_auto_complete = 1
"      "if exists(':NeoCompleteLock')==2
"      "  exe 'NeoCompleteLock'
"      "endif
"    endfunction
"
"    function! Multiple_cursors_after()
"        let g:deoplete#disable_auto_complete = 0
"      "if exists(':NeoCompleteUnlock')==2
"      "  exe 'NeoCompleteUnlock'
"      "endif
"    endfunction

" Autoclose ------------------------------
"    " Fix to let ESC work as espected with Autoclose plugin
"    let g:AutoClosePumvisible = {"ENTER": "\<C-Y>", "ESC": "\<ESC>"}

" buffet
"    let g:buffet_tab_icon = "\uf00a"
"    function! g:BuffetSetCustomColors()
"        hi! BuffetCurrentBuffer cterm=NONE ctermbg=106 ctermfg=8 guibg=#b8bb26 guifg=#000000
"        hi! BuffetTrunc cterm=bold ctermbg=66 ctermfg=8 guibg=#458588 guifg=#000000
"        hi! BuffetBuffer cterm=NONE ctermbg=239 ctermfg=8 guibg=#504945 guifg=#000000
"        hi! BuffetTab cterm=NONE ctermbg=66 ctermfg=8 guibg=#458588 guifg=#000000
"        hi! BuffetActiveBuffer cterm=NONE ctermbg=10 ctermfg=239 guibg=#999999 guifg=#504945
"    endfunction

" Signify ------------------------------
" 通过 coc 控制
"    let g:signify_vcs_list = [ 'git' ]
"    let g:signify_sign_add               = '┃'
"    let g:signify_sign_delete            = '-'
"    let g:signify_sign_delete_first_line = '_'
"    let g:signify_sign_change = '┃'


" Window Chooser ------------------------------
    " mapping
    nmap  -  <Plug>(choosewin)
    " show big letters
    let g:choosewin_overlay_enable = 1
    let g:choosewin_label = 'SDFJKLZXCV'
    let g:choosewin_overlay_enable = 1
    let g:choosewin_statusline_replace = 1
    let g:choosewin_overlay_clear_multibyte = 0
    let g:choosewin_blink_on_land = 0

    let g:choosewin_color_label = {
    	\ 'cterm': [ 236, 2 ], 'gui': [ '#555555', '#000000' ] }
    let g:choosewin_color_label_current = {
    	\ 'cterm': [ 234, 220 ], 'gui': [ '#333333', '#000000' ] }
    let g:choosewin_color_other = {
    	\ 'cterm': [ 235, 235 ], 'gui': [ '#333333' ] }
    let g:choosewin_color_overlay = {
    	\ 'cterm': [ 2, 10 ], 'gui': [ '#88A2A4' ] }
    let g:choosewin_color_overlay_current = {
    	\ 'cterm': [ 72, 64 ], 'gui': [ '#7BB292' ] }
" Airline ------------------------------

    let g:airline_powerline_fonts = 1
    " let g:airline_theme = 'bubblegum'
    let g:airline_theme = 'gruvbox'

    if !exists('g:airline_symbols')
       let g:airline_symbols = {}
    endif
    let g:airline_left_sep = ''
    let g:airline_left_alt_sep = ''
    let g:airline_right_sep = ''
    let g:airline_right_alt_sep = ''
    let g:airline_symbols.branch = ''
    let g:airline_symbols.readonly = ''
    let g:airline_symbols.crypt = '🔒'
    let g:airline_symbols.linenr = '¶'
    let g:airline_symbols.maxlinenr = ''
    let g:airline_symbols.paste = 'Þ'
    let g:airline_symbols.spell = ''
    let g:airline_symbols.notexists = 'Ɇ'
    let g:airline_symbols.whitespace = 'Ξ'

    "打开 airline 提供的 tabline, 不使用 buffet 的
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#formatter = 'default'

    " 开启 coc 或 ale 支持
    let g:airline#extensions#coc#enabled = 1
    let g:airline#extensions#ale#enabled = 1

" Vim-markdown ------------------------------

    " Disabled automatically folding
    let g:vim_markdown_folding_disabled=1
    " LeTeX math
    let g:vim_markdown_math=1
    " Highlight YAML frontmatter
    let g:vim_markdown_frontmatter=1

" Vim-instant-markdown -----------------

    " If it takes your system too much, you can specify
    " let g:instant_markdown_slow = 1
    " if you don't want to manually control it
    " you can open this setting
    " and when you open this, you can manually trigger preview
    " via the command :InstantMarkdownPreview
    let g:instant_markdown_autostart = 0

" vim-JSON ---------------------------
    let g:vim_json_syntax_conceal = 0

" coc.vim -----------------------------------------------
        "" coc tab 补全
        inoremap <silent><expr> <TAB>
              \ pumvisible() ? "\<C-n>" :
              \ <SID>check_back_space() ? "\<TAB>" :
              \ coc#refresh()
        inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

        function! s:check_back_space() abort
          let col = col('.') - 1
          return !col || getline('.')[col - 1]  =~# '\s'
        endfunction

        " Highlight symbol under cursor on CursorHold
        autocmd CursorHold * silent call CocActionAsync('highlight')

        function! s:show_documentation()
            if (index(['vim','help'], &filetype) >= 0)
                execute 'h '.expand('<cword>')
            else
                call CocAction('doHover')
            endif
        endfunction

        augroup coc
          autocmd!
          " Setup formatexpr specified filetype(s).
          autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
          " Update signature help on jump placeholder
          autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
        augroup end

        augroup MyCoCAutoCmd
          autocmd!
          " Setup formatexpr specified filetype(s).
          autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
          " Update signature help on jump placeholder
          autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
        augroup end

        let g:coc_global_extensions = [
                \ 'coc-go',
                \ 'coc-python',
                \ 'coc-css',
                \ 'coc-json',
                \ 'coc-git',
                \ 'coc-pairs',
                \ 'coc-emoji',
                \ 'coc-vimlsp',
                \ 'coc-emmet',
                \ 'coc-prettier',
                \ 'coc-explorer'
                \ ]


" vim-go 相关配置 --------------------------
    " 关闭 vim-go 的 gd :GoDef 由 coc 接管
    let g:go_def_mapping_enabled = 0
    
    "let g:go_autodetect_gopath = 1
    "let g:go_list_type = "quickfix"
    "let g:go_def_mode = 'guru'
    "let g:go_def_mode = 'gopls'
    "let g:go_info_mode = 'gopls'
    "let g:go_def_mode = 'godef'
    let g:go_def_reuse_buffer = 1
    
    let g:go_fmt_command = "goimports"
    " 自动添加标签
    let g:go_addtags_transform = "snakecase"
    "let g:go_term_mode = "split"
    "let g:go_term_enabled = 1
    
    "据说可以解决和 ale 的冲突
    let g:go_fmt_fail_silently = 1
    
    let g:go_decls_mode = 'fzf'
    
    " 关闭 vim-go 的 linter
    let g:go_metalinter_autosave = 0
    let g:go_metalinter_autosave_enabled = ['golint', 'vet']

"     let g:go_highlight_functions = 1
"     let g:go_highlight_methods = 1
"     let g:go_highlight_structs = 1
"     let g:go_highlight_interfaces = 1
"     let g:go_highlight_operators = 1
"     let g:go_highlight_build_constraints = 1
"     let g:go_highlight_extra_types = 1

    let g:go_highlight_types = 1
    let g:go_highlight_fields = 1
    let g:go_highlight_functions = 1
    let g:go_highlight_function_calls = 1
    let g:go_highlight_methods = 1
    let g:go_highlight_structs = 1
    let g:go_highlight_operators = 1
    let g:go_highlight_extra_types = 1
    let g:go_highlight_build_constraints = 1
    let g:go_highlight_generate_tags = 1

    "disable use K to run godoc
    let g:go_doc_keywordprg_enabled = 0

    autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')

" vim-jedi: 相关配置 ------------------------------
    "let g:jedi#auto_vim_configuration = 0
    "let g:jedi#auto_configuration = 0
    let g:jedi#smart_auto_mappings = 1
    " 禁用自动补全
    let g:jedi#completions_enabled = 0
    let g:jedi#use_tabs_not_buffers = 1
    " 键位什么的
    let g:jedi#goto_command = "gd"
    let g:jedi#goto_assignments_command = "<leader>g"
    let g:jedi#documentation_command = "K"
    let g:jedi#usages_command = "<leader>n"
    let g:jedi#completions_command = "<C-Space>"
    let g:jedi#rename_command = "<leader>r"
    let g:jedi#auto_close_doc = 1


" Startify: Fancy startup screen for vim -----------------------------------
    " Don't change to directory when selecting a file
    let g:startify_files_number = 5
    let g:startify_change_to_dir = 0
    let g:startify_custom_header = [ ]
    let g:startify_relative_path = 1
    let g:startify_use_env = 1

    function! s:list_commits()
        let git = 'git -C ' . getcwd()
        let commits = systemlist(git . ' log --oneline | head -n5')
        let git = 'G' . git[1:]
        return map(commits, '{"line": matchstr(v:val, "\\s\\zs.*"), "cmd": "'. git .' show ". matchstr(v:val, "^\\x\\+") }')
    endfunction

    " Custom startup list, only show MRU from current directory/project
    let g:startify_lists = [
    \  { 'type': 'dir',       'header': [ 'Files '. getcwd() ] },
    \  { 'type': function('s:list_commits'), 'header': [ 'Recent Commits' ] },
    \  { 'type': 'sessions',  'header': [ 'Sessions' ]       },
    \  { 'type': 'bookmarks', 'header': [ 'Bookmarks' ]      },
    \  { 'type': 'commands',  'header': [ 'Commands' ]       },
    \ ]

    let g:startify_commands = [
    \   { 'up': [ 'Update Plugins', ':PlugUpdate' ] },
    \   { 'ug': [ 'Upgrade Plugin Manager', ':PlugUpgrade' ] },
    \ ]

    let g:startify_bookmarks = [
        \ { 'c': '~/code/dotfiles/config/nvim/init.vim' },
        \ { 'z': '~/code/dotfiles/zsh/zshrc.symlink' }
    \ ]

    autocmd User Startified setlocal cursorline

" which key
    let g:which_key_map =  {}
    let g:which_key_map = {
          \ 'name' : '+Vim root ' ,
          \ 'a' : {
                \ 'name' : '+coc-code-action',
                \ 'c' : 'code action',
                \ },
          \ 'b' : {
                \ 'name' : '+buffer',
                \ 'b' : 'buffer list',
                \ 'c' : 'keep current buffer',
                \ 'o' : 'keep input buffer',
                \ },
          \ 'e' : 'open file explorer' ,
          \ '-' : 'choose window by {prompt char}' ,
          \ 'G' : 'distraction free writing' ,
          \ 'f' : {
                \ 'name' : '+search {files cursorword word outline}',
                \ 'f' : 'find file',
                \ 'r' : 'search {word}',
                \ 'c' : 'change colorscheme',
                \ 'w' : 'search cursorword 光标词',
                \ 'v' : 'search outline 标签查询',
                \ },
          \ 'F' : 'find current file' ,
          \ 'j' : 'open coc-explorer',
          \ 'g'  :{
                    \'name':'+git-operate',
                    \ 'd'    : 'Gdiff',
                    \ 'c'    : 'Gcommit',
                    \ 'b'    : 'Gblame',
                    \ 'B'    : 'Gbrowse',
                    \ 'S'    : 'Gstatus',
                    \ 'p'    : 'git push',
                    \ 'l'    : 'GitLogAll',
                    \ 'h'    : 'GitBranch',
                    \},
          \ 'c'    : {
                  \ 'name' : '+coc list' ,
                  \ 'a'    : 'coc CodeActionSelected',
                  \ 'd'    : 'coc Diagnostics',
                  \ 'c'    : 'coc Commands',
                  \ 'e'    : 'coc Extensions',
                  \ 'j'    : 'coc Next',
                  \ 'k'    : 'coc Prev',
                  \ 'o'    : 'coc OutLine',
                  \ 'r'    : 'coc Resume',
                  \ 'n'    : 'coc Rename',
                  \ 's'    : 'coc Isymbols',
                  \ 'g'    : 'coc Gitstatus',
                  \ 'f'    : 'coc Format',
                  \ 'm'    : 'coc search word to multiple cursors',
                  \ },
          \ 'q' : {
                \ 'name' : '+coc-quickfix',
                \ 'f' : 'coc fixcurrent',
                \ },
          \ 't' : {
                \ 'name' : '+tab-operate',
                \ 'n' : 'new tab',
                \ 'e' : 'edit tab',
                \ 'm' : 'move tab',
                \ },
        \}
    let g:which_key_map[' '] = {
          \ 'name' : '+easymotion-jumpto-word ' ,
          \ 'b' : ['<plug>(easymotion-b)' , 'beginning of word backward'],
          \ 'f' : ['<plug>(easymotion-f)' , 'find {char} to the left'],
          \ 'w' : ['<plug>(easymotion-w)' , 'beginning of word forward'],
          \ }
    
    let g:which_key_localmap ={
          \ 'name' : '+LocalLeaderKey'  ,
          \ 'v'    : 'open vista show outline',
          \ 'r'    : 'quick run',
          \ 'm'    : 'toolkit Menu',
          \ 'g' : {
                \ 'name' : '+golang-toolkit',
                \ 'i'    : 'go impl',
                \ 'd'    : 'go describe',
                \ 'c'    : 'go callees',
                \ 'C'    : 'go callers',
                \ 's'    : 'go callstack',
                \ },
          \ }
    
    let g:which_key_rsbgmap = {
          \ 'name' : '+RightSquarebrackets',
          \ 'a'    : 'ale nextwarp',
          \ 'c'    : 'coc nextdiagnostics',
          \ 'b'    : 'next buffer',
          \ 'g'    : 'coc gitnextchunk',
          \ ']'    : 'jump prefunction-golang',
          \ }
    
    
    let g:which_key_lsbgmap = {
          \ 'name' : '+LeftSquarebrackets',
          \ 'a'    : 'ale prewarp',
          \ 'c'    : 'coc prediagnostics',
          \ 'b'    : 'pre buffer',
          \ 'g'    : 'coc gitprevchunk',
          \ '['    : 'jump nextfunction-golang',
          \ }
    
    let s:current_colorscheme = get(g:,"colors_name","")
    if  s:current_colorscheme == "base16-default-dark"
        highlight WhichKeySeperator guibg=NONE ctermbg=NONE guifg=#a1b56c ctermfg=02
    endif

    call which_key#register('\', 'g:which_key_map')
    call which_key#register(';', 'g:which_key_localmap')
    call which_key#register(']', 'g:which_key_rsbgmap')
    call which_key#register('[', 'g:which_key_lsbgmap')

"NeoFormat
    let g:neoformat_try_formatprg = 1
    let g:jsx_ext_required = 0
    let g:neoformat_enabled_javascript=['prettier']
    let g:neoformat_enabled_html=['js-beautify']

"tpope/vim-markdown
    let g:markdown_fenced_languages = [
      \ 'html',
      \ 'bash=sh',
      \ 'css',
      \ 'javascript',
      \ 'jsx=javascriptreact',
      \ 'tsx=typescriptreact',
      \ 'go',
      \]

"denite
call denite#custom#option('_', {
		\ 'cached_filter': v:true,
		\ 'cursor_shape': v:true,
		\ 'cursor_wrap': v:true,
		\ 'highlight_filter_background': 'DeniteFilter',
		\ 'highlight_matched_char': 'Underlined',
		\ 'matchers': 'matcher/fuzzy',
		\ 'prompt': 'λ ',
		\ 'split': 'floating',
		\ 'start_filter': v:false,
		\ 'statusline': v:false,
		\ })
function! s:denite_detect_size() abort
    let s:denite_winheight = 20
    let s:denite_winrow = &lines > s:denite_winheight ? (&lines - s:denite_winheight) / 2 : 0
    let s:denite_winwidth = &columns > 240 ? &columns / 2 : 120
    let s:denite_wincol = &columns > s:denite_winwidth ? (&columns - s:denite_winwidth) / 2 : 0
    call denite#custom#option('_', {
         \ 'wincol': s:denite_wincol,
         \ 'winheight': s:denite_winheight,
         \ 'winrow': s:denite_winrow,
         \ 'winwidth': s:denite_winwidth,
         \ })
  endfunction
   augroup denite-detect-size
    autocmd!
    autocmd VimResized * call <SID>denite_detect_size()
  augroup END
  call s:denite_detect_size()


call denite#custom#option('search', { 'start_filter': 0, 'no_empty': 1 })
call denite#custom#option('list', { 'start_filter': 0 })
call denite#custom#option('jump', { 'start_filter': 0 })
call denite#custom#option('git', { 'start_filter': 0 })
call denite#custom#option('mpc', { 'winheight': 20 })


" MATCHERS
" Default is 'matcher/fuzzy'
call denite#custom#source('tag', 'matchers', ['matcher/substring'])
call denite#custom#source('file/rec', 'matchers', ['matcher/fuzzy'])

if has('nvim') && &runtimepath =~# '\/cpsm'
	call denite#custom#source(
		\ 'buffer,file_mru,file/old,file/rec,grep,mpc,line,neoyank',
		\ 'matchers', ['matcher/cpsm', 'matcher/fuzzy'])
endif


" CONVERTERS
" Default is none
call denite#custom#source(
	\ 'buffer,file_mru,file/old,file/rec,directory/rec,directory_mru',
	\ 'converters', ['devicons_denite_converter','converter_relative_word'])

" FIND and GREP COMMANDS
if executable('ag')
	" The Silver Searcher
	call denite#custom#var('file/rec', 'command',
		\ ['ag', '-U', '--hidden', '--follow', '--nocolor', '--nogroup', '-g', ''])

	" Setup ignore patterns in your .agignore file!
	" https://github.com/ggreer/the_silver_searcher/wiki/Advanced-Usage

	call denite#custom#var('grep', 'command', ['ag'])
	call denite#custom#var('grep', 'recursive_opts', [])
	call denite#custom#var('grep', 'pattern_opt', [])
	call denite#custom#var('grep', 'separator', ['--'])
	call denite#custom#var('grep', 'final_opts', [])
	call denite#custom#var('grep', 'default_opts',
		\ [ '--skip-vcs-ignores', '--vimgrep', '--smart-case', '--hidden' ])

elseif executable('ack')
	" Ack command
	call denite#custom#var('grep', 'command', ['ack'])
	call denite#custom#var('grep', 'recursive_opts', [])
	call denite#custom#var('grep', 'pattern_opt', ['--match'])
	call denite#custom#var('grep', 'separator', ['--'])
	call denite#custom#var('grep', 'final_opts', [])
	call denite#custom#var('grep', 'default_opts',
			\ ['--ackrc', $HOME.'/.config/ackrc', '-H',
			\ '--nopager', '--nocolor', '--nogroup', '--column'])

elseif executable('rg')
	" Ripgrep
  call denite#custom#var('file/rec', 'command',
        \ ['rg', '--files', '--glob', '!.git'])
  call denite#custom#var('grep', 'command', ['rg', '--threads', '1'])
  call denite#custom#var('grep', 'recursive_opts', [])
  call denite#custom#var('grep', 'final_opts', [])
  call denite#custom#var('grep', 'separator', ['--'])
  call denite#custom#var('grep', 'default_opts',
        \ ['-i', '--vimgrep', '--no-heading'])
endif


" KEY MAPPINGS
autocmd FileType denite call s:denite_settings()
function! s:denite_settings() abort
	highlight! link CursorLine Visual
	nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
	nnoremap <silent><buffer><expr> i    denite#do_map('open_filter_buffer')
	nnoremap <silent><buffer><expr> d    denite#do_map('do_action', 'delete')
	nnoremap <silent><buffer><expr> p    denite#do_map('do_action', 'preview')
	nnoremap <silent><buffer><expr> st   denite#do_map('do_action', 'tabopen')
	nnoremap <silent><buffer><expr> sv   denite#do_map('do_action', 'vsplit')
	nnoremap <silent><buffer><expr> si   denite#do_map('do_action', 'split')
	nnoremap <silent><buffer><expr> '    denite#do_map('quick_move')
	nnoremap <silent><buffer><expr> q    denite#do_map('quit')
	nnoremap <silent><buffer><expr> r    denite#do_map('redraw')
	nnoremap <silent><buffer><expr> yy   denite#do_map('do_action', 'yank')
	nnoremap <silent><buffer><expr> <Esc>   denite#do_map('quit')
	nnoremap <silent><buffer><expr> <C-u>   denite#do_map('restore_sources')
	nnoremap <silent><buffer><expr> <C-f>   denite#do_map('do_action', 'defx')
	nnoremap <silent><buffer><expr> <C-x>   denite#do_map('choose_action')
	nnoremap <silent><buffer><expr><nowait> <Space> denite#do_map('toggle_select').'j'
endfunction

autocmd FileType denite-filter call s:denite_filter_settings()
function! s:denite_filter_settings() abort
	nnoremap <silent><buffer><expr> <Esc>  denite#do_map('quit')
	" inoremap <silent><buffer><expr> <Esc>  denite#do_map('quit')
	nnoremap <silent><buffer><expr> q      denite#do_map('quit')
	imap <silent><buffer> <C-c> <Plug>(denite_filter_quit)
	"inoremap <silent><buffer><expr> <C-c>  denite#do_map('quit')
	nnoremap <silent><buffer><expr> <C-c>  denite#do_map('quit')
	inoremap <silent><buffer>       kk     <Esc><C-w>p
	nnoremap <silent><buffer>       kk     <C-w>p
	inoremap <silent><buffer>       jj     <Esc><C-w>p
	nnoremap <silent><buffer>       jj     <C-w>p
endfunction


let s:menus = {}

let s:menus.vimplug = { 'description': 'Plugin management' }
let s:menus.vimplug.command_candidates = [
  \   ['🐬 vim-plug: Plugins Install      🔸', 'PlugInstall'],
  \   ['🐬 vim-plug: Plugins Update       🔸', 'PlugUpdate'],
  \   ['🐬 vim-plug: Plugins Status       🔸', 'PlugStatus'],
  \   ['🐬 vim-plug: vim-plug Upgrade     🔸', 'PlugUpgrade'],
  \ ]

let s:menus.project = { 'description': 'Project & Structure' }
let s:menus.project.command_candidates = [
  \   ['🐳 File Explorer        🔸<Leader>e',        'Defx -resume -toggle -buffer-name=tab`tabpagenr()`<CR>'],
  \   ['🐳 Outline              🔸<LocalLeader>t',   'TagbarToggle'],
  \   ['🐳 Git Status           🔸<LocalLeader>gs',  'Denite gitstatus'],
  \   ['🐳 Mundo Tree           🔸<Leader>m',  'MundoToggle'],
  \ ]

let s:menus.files = { 'description': 'File tools' }
let s:menus.files.command_candidates = [
  \   ['📂 Denite: Find in files…    🔹 ',  'Denite grep:.'],
  \   ['📂 Denite: Find files        🔹 ',  'Denite file/rec'],
  \   ['📂 Denite: Buffers           🔹 ',  'Denite buffer'],
  \   ['📂 Denite: MRU               🔹 ',  'Denite file/old'],
  \   ['📂 Denite: Line              🔹 ',  'Denite line'],
  \ ]

let s:menus.tools = { 'description': 'Dev Tools' }
let s:menus.tools.command_candidates = [
  \   ['🐠 Git commands       🔹', 'Git'],
  \   ['🐠 Git log            🔹', 'Denite gitlog:all'],
  \   ['🐠 Goyo               🔹', 'Goyo'],
  \   ['🐠 Tagbar             🔹', 'TagbarToggle'],
  \   ['🐠 File explorer      🔹', 'Defx -resume -toggle -buffer-name=tab`tabpagenr()`<CR>'],
  \ ]

let s:menus.config = { 'description': 'Zsh Tmux Configuration' }
let s:menus.config.file_candidates = [
  \   ['🐠 Zsh Configurationfile            🔸', '~/.zshrc'],
  \   ['🐠 Tmux Configurationfile           🔸', '~/.tmux.conf'],
  \ ]

let s:menus.myvim = {'description': 'MyVim Configuration files'}
let s:menus.myvim.file_candidates = [
  \   ['🐠 MainVimrc          settings: vimrc               🔹', $VIM_PATH.'/core/vimrc'],
  \   ['🐠 Initial            settings: init.vim            🔹', $VIM_PATH.'/core/init.vim'],
  \   ['🐠 General            settings: general.vim         🔹', $VIM_PATH.'/core/general.vim'],
  \   ['🐠 FileTypes          settings: filetype.vim        🔹', $VIM_PATH.'/core/filetype.vim'],
  \   ['🐠 Installed       LoadPlugins: plugins.yaml        🔹', $VIM_PATH.'/core/plugins.yaml'],
  \   ['🐠 Plugins  Key        Mapping: plugins_mapping.vim 🔹', $VIM_PATH.'/core/plugins_mapping.vim'],
  \   ['🐠 Global   Key    Vimmappings: mappings.vim        🔹', $VIM_PATH.'/core/mappings.vim'],
  \   ['🐠 Theme              settings: theme.vim           🔹', $VIM_PATH.'/core/theme.vim'],
  \ ]

call denite#custom#var('menu', 'menus', s:menus)

"let s:menus.sessions = { 'description': 'Sessions' }
"let s:menus.sessions.command_candidates = [
  "\   ['▶ Restore session │ ;s', 'Denite session'],
  "\   ['▶ Save session…   │', 'Denite session/new'],
  "\ ]
