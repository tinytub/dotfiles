local acmd = {}

function acmd.define_augroups(definitions) -- {{{1

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

-- uncomment this if you want to open nvim with a dir
-- vim.cmd [[ autocmd BufEnter * if &buftype != "terminal" | lcd %:p:h | endif ]]

-- Use relative & absolute line numbers in 'n' & 'i' modes respectively
-- vim.cmd[[ au InsertEnter * set norelativenumber ]]
-- vim.cmd[[ au InsertLeave * set relativenumber ]]

-- Don't show any numbers inside terminals
vim.cmd [[ au TermOpen term://* setlocal nonumber norelativenumber | setfiletype terminal ]]

---- Don't show status line on certain windows
--vim.cmd [[ autocmd BufEnter,BufWinEnter,FileType,WinEnter * lua require("core.utils").hide_statusline() ]]

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

acmd.define_augroups({
    autoformat = {
        {'BufWritePre', '*', ':silent lua vim.lsp.buf.formatting_sync()'},
    }
})

acmd.define_augroups({
    goautofmt = {
        -- Go generally requires Tabs instead of spaces.
        {'FileType', '*.go', 'setlocal tabstop=4'},
        {'FileType', '*.go', 'setlocal shiftwidth=4'},
        {'FileType', '*.go', 'setlocal softtabstop=4'},
        {'FileType', '*.go', 'setlocal noexpandtab'},

        --{'BufWritePre', '*.go', 'lua vim.lsp.buf.formatting()'},
        --{'FileType', '*.go', ':autocmd! autoformat'},
        {'BufWritePre', '*.go', 'lua require(\'lsp.format\').OrgImports(3000)'},
    }
})

-- Open a file from its last left off position
-- vim.cmd [[ au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif ]]
-- File extension specific tabbing
-- vim.cmd [[ autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4 ]]

acmd.define_augroups {
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
        },
        {
            'BufNewFile', '*',
            'setlocal formatoptions-=c formatoptions-=r formatoptions-=o'
        },
        --{'VimLeavePre', '*', 'set title set titleold='},
        {'FileType', 'qf', 'set nobuflisted'}
    },
    _git = {
      { "FileType", "gitcommit", "setlocal wrap" },
      { "FileType", "gitcommit", "setlocal spell" },
    },
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
    _packer_compile = {
    -- will cause split windows to be resized evenly if main window is resized
    { "BufWritePost", "plugins.lua", "PackerCompile" },
  },
    _general_lsp = {
    { "FileType", "lspinfo", "nnoremap <silent> <buffer> q :q<CR>" },
  },
}

return acmd
