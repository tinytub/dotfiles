let g:which_key_map =  {}
let g:which_key_map = {
      \ 'name' : '+ThinkVim root ' ,
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
      \ 'd' : 'search cursor word on Dash.app' ,
      \ 'g' : {
            \ 'name' : 'version control',
            \ 'g' : 'Magit status',
            \ },
      \ 'G' : 'distraction free writing' ,
      \ 'F' : 'find current file' ,
      \ 'f' : {
            \ 'name' : '+search {files cursorword word outline}',
            \ 'f' : 'find file on directory',
            \ 'r' : 'search {word} on project',
            \ 'c' : 'change colorscheme',
            \ 'o' : 'find old files',
            \ 'm' : 'find mru files',
            \ 'p' : 'find on a project',
            \ 'P' : 'find on a git project',
            \ },
      \ 'o' : {
            \ 'name' : 'open {terminal}',
            \ 't' : 'open a temrinal',
            \ },
      \ 'm' : 'open mundotree' ,
      \ 'w' : 'save file',
      \ 'j' : 'open coc-explorer',
      \ 's' : 'open startify screen',
      \ 'p' : 'edit pluginsconfig {filename}',
      \ 'x' : 'coc cursors operate',
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
      \ }
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
