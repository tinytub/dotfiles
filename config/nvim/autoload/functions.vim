" load vim-plug if it does not exist in the dotfiles
"let s:plugpath = expand('<sfile>:p:h') . '/plug.vim' " this is relative to this file, which is in autoload
"echom s:plugpath
"function! functions#PlugLoad()
"    if !filereadable(s:plugpath)
"        if executable('curl')
"            echom "Installing vim-plug at " . s:plugpath
"            let plugurl = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
"            call system('curl -fLo ' . shellescape(s:plugpath) . ' --create-dirs ' . plugurl)
"            if v:shell_error
"                echom "Error downloading vim-plug. Please install it manually.\n"
"                exit
"            endif
"        else
"            echom "vim-plug not installed. Please install it manually or install curl.\n"
"            exit
"        endif
"    endif
"endfunction
"
""vim-plug 自动更新plugin
"function! OnVimEnter() abort
"  " Run PlugUpdate every week automatically when entering Vim.
"  if exists('g:plug_home')
"    let l:filename = printf('%s/.vim_plug_update', g:plug_home)
"    if filereadable(l:filename) == 0
"      call writefile([], l:filename)
"    endif
"
"    "let l:this_week = strftime('%Y_%V')
"    let l:this_day = strftime('%Y_%m_%d')
"    let l:contents = readfile(l:filename)
"    if index(l:contents, l:this_day) < 0
"      call execute('PlugUpdate')
"      call writefile([l:this_day], l:filename, 'a')
"    endif
"  endif
"endfunction
"
"autocmd VimEnter * call OnVimEnter()
