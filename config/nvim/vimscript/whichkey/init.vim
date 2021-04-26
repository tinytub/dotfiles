" Leader Key Maps

" Timeout
let g:which_key_timeout = 100

let g:which_key_display_names = {'<CR>': '↵', '<TAB>': '⇆', " ": 'SPC'}

" Map leader to which_key
nnoremap <silent> <leader> :silent <c-u> :silent WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>

let g:which_key_map =  {}
let g:which_key_sep = '→'

" Not a fan of floating windows for this
let g:which_key_use_floating_win = 0 " 使用 floatwin
let g:which_key_max_size = 0

" Hide status line
autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler

"let g:which_key_map['/'] = 'comment toggle'
let g:which_key_map[';'] = [ ':Dashboard'                                      , 'home screen' ]
let g:which_key_map['F'] = [ ':NvimTreeFindFile'                               , 'find current file' ]
let g:which_key_map['e'] = [ ':NvimTreeToggle'                                 , 'explorer' ]
"let g:which_key_map['f'] = [ ':Telescope find_files'                           , 'find files' ]
let g:which_key_map['M'] = [ ':MarkdownPreviewToggle'                          , 'markdown preview']
let g:which_key_map['h'] = [ ':let @/ = ""'                                    , 'no highlight' ]
" TODO create entire treesitter section
"let g:which_key_map['T'] = [ ':TSHighlightCapturesUnderCursor'                 , 'treesitter highlight' ]
let g:which_key_map['v'] = [ '<C-W>v'                                          , 'split right']
let g:which_key_map['V'] = [ 'Vista'                                          , 'Vista']
" TODO play nice with status line

" Group mappings

" a is for actions
let g:which_key_map.a = {
      \ 'name' : '+actions' ,
      \ 'c' : [':ColorizerToggle'        , 'colorizer'],
      \ 'h' : [':let @/ = ""'            , 'remove search highlight'],
      \ 'i' : [':IndentBlanklineToggle'  , 'toggle indent lines'],
      \ 'n' : [':set nonumber!'          , 'line-numbers'],
      \ 's' : [':s/\%V\(.*\)\%V/"\1"/'   , 'surround'],
      \ 'r' : [':set norelativenumber!'  , 'relative line nums'],
      \ }
      " \ 'l' : [':Bracey'                 , 'start live server'],
      " \ 'L' : [':BraceyStop'             , 'stop live server'],

" b is for buffer
let g:which_key_map.b = {
      \ 'name' : '+buffer' ,
      \ '>' : [':BufferMoveNext'        , 'move next'],
      \ '<' : [':BufferMovePrevious'    , 'move prev'],
      \ 'P' : [':BufferPick'            , 'pick buffer'],
      \ 'd' : [':BufferClose'           , 'delete-buffer'],
      \ 'n' : ['bnext'                  , 'next-buffer'],
      \ 'p' : ['bprevious'              , 'previous-buffer'],
      \ '?' : ['Buffers'                , 'fzf-buffer'],
      \ 'b' : [':Telescope buffers'                , 'find bufers'],
      \ }

" d is for debug
let g:which_key_map.d = {
      \ 'name' : '+debug' ,
      \ 'b' : ['DebugToggleBreakpoint '        , 'toggle breakpoint'],
      \ 'c' : ['DebugContinue'                 , 'continue'],
      \ 'i' : ['DebugStepInto'                 , 'step into'],
      \ 'o' : ['DebugStepOver'                 , 'step over'],
      \ 'r' : ['DebugToggleRepl'               , 'toggle repl'],
      \ 's' : ['DebugStart'                    , 'start'],
      \ }
      " \ 'O' : ['DebugStepOut'                  , 'next-buffer'],
      " \ 'S' : ['DebugGetSession '              , 'fzf-buffer'],

let g:which_key_map.p = {
    \ 'name' : 'Packer' ,
    \ 'u'    : ["PackerUpdate"      ,  'packer update'],
    \ 'i'    : ["PackerInstall"     ,  'packer install'],
    \ 'c'    : ["PackerCompile"     ,  'packer compile'],
    \ 's'    : ["PackerSync"        ,  'packer sync'],
    \ }


" s is for search powered by telescope
let g:which_key_map.f = {
      \ 'name' : '+search' ,
      \ '.' : [':Telescope filetypes'                   , 'filetypes'],
      \ 'B' : [':Telescope git_branches'                , 'git branches'],
      \ 'd' : [':Telescope lsp_document_diagnostics'    , 'document_diagnostics'],
      \ 'D' : [':Telescope lsp_workspace_diagnostics'   , 'workspace_diagnostics'],
      \ 'f' : [':Telescope find_files'                  , 'files'],
      \ 'h' : [':Telescope command_history'             , 'history'],
      \ 'i' : [':Telescope media_files'                 , 'media files'],
      \ 'm' : [':Telescope marks'                       , 'marks'],
      \ 'M' : [':Telescope man_pages'                   , 'man_pages'],
      \ 'v' : [':Telescope vim_options'                 , 'vim_options'],
      \ 'a' : [':Telescope live_grep'                   , 'text'],
      \ 'r' : [':Telescope registers'                   , 'registers'],
      \ 'b' : [':Telescope file_browser'                , 'file browser'],
      \ 'u' : [':Telescope colorscheme'                 , 'colorschemes'],
      \ 'g' : [':Telescope git_files'                   , 'git_files'],
      \ 'w' : [':Telescope grep_string'                 , 'grep_string'],
      \ 'o' : [':Telescope oldfiles'                    , 'oldfiles'],
      \ 'c' : [':Telescope git_commits'                 , 'git_commits'],
      \ }

" S is for Session
let g:which_key_map.S = {
      \ 'name' : '+Session' ,
      \ 's' : [':SessionSave'           , 'save session'],
      \ 'l' : [':SessionLoad'           , 'load Session'],
      \ }

" g is for git
let g:which_key_map.g = {
      \ 'name' : '+git' ,
      \ 'b' : [':Git blame'                        , 'blame'],
      \ 'd' : [':Git diff'                         , 'diff'],
      \ 'l' : [':Git log'                          , 'log'],
      \ 'S' : [':Git status'                       , 'status'],
      \ }
      " \ 'n' : [':Neogit'                           , 'neogit'],

" l is for language server protocol
let g:which_key_map.l = {
      \ 'name' : '+lsp' ,
      \ 'a' : [':Lspsaga code_action'                , 'code action'],
      \ 'A' : [':Lspsaga range_code_action'          , 'selected action'],
      \ 'd' : [':Telescope lsp_document_diagnostics' , 'document diagnostics'],
      \ 'D' : [':Telescope lsp_workspace_diagnostics', 'workspace diagnostics'],
      \ 'f' : [':LspFormatting'                      , 'format'],
      \ 'i' : [':LspInfo'                            , 'lsp info'],
      \ 'v' : [':LspVirtualTextToggle'               , 'lsp toggle virtual text'],
      \ 'l' : [':Lspsaga lsp_finder'                 , 'lsp finder'],
      \ 'L' : [':Lspsaga show_line_diagnostics'      , 'line_diagnostics'],
      \ 'p' : [':Lspsaga preview_definition'         , 'preview definition'],
      \ 'q' : [':Telescope quickfix'                 , 'quickfix'],
      \ 'r' : [':Lspsaga rename'                     , 'rename'],
      \ 'R' : [':Lspsaga restart'                     , 'lsp restart'],
      \ 'T' : [':LspTypeDefinition'                  , 'type defintion'],
      \ 'x' : [':cclose'                             , 'close quickfix'],
      \ 's' : [':Telescope lsp_document_symbols'     , 'document symbols'],
      \ 'S' : [':Telescope lsp_workspace_symbols'    , 'workspace symbols'],
      \ }
      " \ 'H' : [':Lspsaga signature_help'             , 'signature_help'],
      " \ 'o' : [':Vista!!'                            , 'outline'],

" t is for terminal
let g:which_key_map.t = {
      \ 'name' : '+terminal' ,
      \ ';' : [':FloatermNew --wintype=normal --height=6'       , 'terminal'],
      \ 'f' : [':FloatermNew fzf'                               , 'fzf'],
      \ 'g' : [':FloatermNew lazygit'                           , 'git'],
      \ 'n' : [':FloatermNew node'                              , 'node'],
      \ 'p' : [':FloatermNew python'                            , 'python'],
      \ 't' : [':FloatermToggle'                                , 'toggle'],
      \ 'k' : [':FloatermKill'                                  , 'kill term'],
      \ }
    "["t|<A-d>"]          = map_cu([[<C-\><C-n>:FloatermKill<CR>]]):with_noremap():with_silent(),
    "
call which_key#register('<Space>', "g:which_key_map")
