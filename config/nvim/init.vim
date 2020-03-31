if has('nvim')
execute 'source' fnamemodify(expand('<sfile>'), ':h').'/core/vimrc'
else 
execute 'source' fnamemodify(resolve(expand('<sfile>:p')), ':h').'/core/vimrc'
"execute 'source' fnamemodify(expand('<sfile>'), ':h').'/core/vimrc'
endif

