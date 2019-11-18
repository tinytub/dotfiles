" ----------------------------------------------------------------------------
"  外部基础依赖
" ----------------------------------------------------------------------------
" vim-plug 自动更新

if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

function! s:main()
	if has('vim_starting')
        " 配置缓存地址
        let $VARPATH = expand(($XDG_CACHE_HOME ? $XDG_CACHE_HOME : '~/.cache').'/vim')
        " 配置 neovim 使用的基础环境地址
        if isdirectory($VARPATH.'/venv/neovim3')
            let g:python3_host_prog = $VARPATH.'/venv/neovim3/bin/python'
            " 忽略 nvim 模块检查
            let g:python3_host_skip_check = 1
        endif
        if isdirectory($VARPATH.'/venv/neovim2')
            let g:python_host_prog = $VARPATH.'/venv/neovim2/bin/python'
        endif
        if ! has('nvim') && has('pythonx')
			if has('python3')
				set pyxversion=3
			elseif has('python')
				set pyxversion=2
			endif
		endif
	endif
endfunction

" Disable vim distribution plugins
let g:loaded_getscript = 1
let g:loaded_getscriptPlugin = 1
let g:loaded_gzip = 1
let g:loaded_logiPat = 1
let g:loaded_matchit = 1
let g:loaded_matchparen = 1
let g:netrw_nogx = 1 " disable netrw's gx mapping.
let g:loaded_rrhelper = 1  " ?
let g:loaded_shada_plugin = 1  " ?
let g:loaded_tar = 1
let g:loaded_tarPlugin = 1
let g:loaded_tutor_mode_plugin = 1
let g:loaded_2html_plugin = 1
let g:loaded_vimball = 1
let g:loaded_vimballPlugin = 1
let g:loaded_zip = 1
let g:loaded_zipPlugin = 1

call s:main()


" ----------------------------------------------------------------------------
" 杂七杂八
" ----------------------------------------------------------------------------

"" AutoGroups -------------------
    " 虽然不知道做什么用的,但是觉得挺厉害的...
    " file type specific settings
    augroup configgroup
        autocmd!

        " automatically resize panes on resize
        autocmd VimResized * exe 'normal! \<c-w>='
        autocmd BufWritePost .vimrc,.vimrc.local,init.vim source %
        autocmd BufWritePost .vimrc.local source %
        " save all files on focus lost, ignoring warnings about untitled buffers
        autocmd FocusLost * silent! wa

        " make quickfix windows take all the lower section of the screen
        " when there are multiple windows open
        autocmd FileType qf wincmd J
        autocmd FileType qf nmap <buffer> q :q<cr>
    augroup END
""

augroup CloseLoclistWindowGroup
    autocmd!
    autocmd QuitPre * if empty(&buftype) | lclose | endif
augroup END

" Reloads vimrc after saving but keep cursor position
"if !exists('*ReloadVimrc')
"   fun! ReloadVimrc()
"       let save_cursor = getcurpos()
"       source $MYVIMRC
"       call setpos('.', save_cursor)
"   endfun
"endif
"autocmd! BufWritePost $MYVIMRC call ReloadVimrc()

" 自动刷新文件
if ! exists("g:CheckUpdateStarted")
    let g:CheckUpdateStarted=1
    call timer_start(1,'CheckUpdate')
endif
function! CheckUpdate(timer)
    silent! checktime
    call timer_start(1000,'CheckUpdate')
endfunction

" Enter automatically into the files directory
autocmd BufEnter * silent! lcd %:p:h
