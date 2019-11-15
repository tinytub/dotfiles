" 颜色主题及最后配置
    " use 256 colors when possible
    if (has("termguicolors"))
        set termguicolors
    endif
    "let g:onedark_termcolors=16
    "let g:onedark_terminal_italics=1
    "colorscheme onedark
    colorscheme gruvbox9
    "colorscheme dracula
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    let g:gruvbox_filetype_hi_groups=1
    let g:gruvbox_plugin_hi_groups = 1

    " syntax highlight on and filetype reload
    syntax on
    filetype plugin indent on
