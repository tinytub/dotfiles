local n_utils = {}

function n_utils.define_augroups(definitions) -- {{{1

    -- Create autocommand groups based on the passed definitions
    --
    -- The key will be the name of the group, and each definition
    -- within the group should have:
    --    1. Trigger
    --    2. Pattern
    --    3. Text
    -- just like how they would normally be defined from Vim itself
    for group_name, definition in pairs(definitions) do
        vim.cmd('augroup ' .. group_name)
        vim.cmd('autocmd!')

        for _, def in pairs(definition) do
            local command = table.concat(vim.tbl_flatten {'autocmd', def}, ' ')
            vim.cmd(command)
        end

        vim.cmd('augroup END')
    end
end

n_utils.define_augroups {
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
    },
  _auto_resize = {
    -- will cause split windows to be resized evenly if main window is resized
    {'VimResized ', '*', 'wincmd ='},
  },
}

vim.cmd([[
  function! QuickFixToggle()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
      copen
    else
      cclose
    endif
endfunction
]]
)

return n_utils

