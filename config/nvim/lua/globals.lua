CONFIG_PATH = vim.fn.stdpath('config')
DATA_PATH = vim.fn.stdpath('data')
CACHE_PATH = vim.fn.stdpath('cache')

require('n-utils').define_augroups({
    _general_settings = {
        {
            'TextYankPost', '*',
            'lua require(\'vim.highlight\').on_yank({higroup = \'Search\', timeout = 200})'
        }, {
            'BufWinEnter', '*',
            'setlocal formatoptions-=c formatoptions-=r formatoptions-=o'
        },
        {
            'BufRead', '*',
            'setlocal formatoptions-=c formatoptions-=r formatoptions-=o'
        }, {
            'BufNewFile', '*',
            'setlocal formatoptions-=c formatoptions-=r formatoptions-=o'
        }, {'VimLeavePre', '*', 'set title set titleold='},
        {'FileType', 'qf', 'set nobuflisted'}
    },
    -- _solidity = {
    --     {'BufWinEnter', '.sol', 'setlocal filetype=solidity'}, {'BufRead', '*.sol', 'setlocal filetype=solidity'},
    --     {'BufNewFile', '*.sol', 'setlocal filetype=solidity'}
    -- },
    -- _gemini = {
    --     {'BufWinEnter', '.gmi', 'setlocal filetype=markdown'}, {'BufRead', '*.gmi', 'setlocal filetype=markdown'},
    --     {'BufNewFile', '*.gmi', 'setlocal filetype=markdown'}
    -- },
    _markdown = {
        {'FileType', 'markdown', 'setlocal wrap'},
        {'FileType', 'markdown', 'setlocal spell'}
    },
    _buffer_bindings = {
        {'FileType', 'floaterm', 'nnoremap <silent> <buffer> q :q<CR>'}
    }
})
