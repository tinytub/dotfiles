let g:qf_bufname_or_text = 1
let g:qf_auto_open_quickfix = 0
let g:qf_auto_open_loclist = 0
let g:qf_auto_resize = 0
autocmd User preview_open_pre
  \ let g:vim_markdown_folding_disabled = 1
  \| let g:vim_markdown_override_foldtext = 0
  \| let g:vim_markdown_no_default_key_mappings = 1
  \| let g:vim_markdown_emphasis_multiline = 0
autocmd User preview_open_post
  \ unlet g:vim_markdown_folding_disabled
  \| let g:vim_markdown_override_foldtext = 1
  \| unlet g:vim_markdown_no_default_key_mappings
  \| unlet g:vim_markdown_emphasis_multiline
