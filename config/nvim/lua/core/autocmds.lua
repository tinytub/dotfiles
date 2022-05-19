local acmd = {}

local autocmd = vim.api.nvim_create_autocmd

-- Disable statusline in dashboard
autocmd("FileType", {
   pattern = "alpha",
   callback = function()
      vim.opt.laststatus = 0
   end,
})

autocmd("BufUnload", {
   buffer = 0,
   callback = function()
      vim.opt.laststatus = 3
   end,
})
---- open nvim with a dir while still lazy loading nvimtree
--autocmd("BufEnter", {
--   callback = function()
--      if vim.api.nvim_buf_get_option(0, "buftype") ~= "terminal" then
--         vim.cmd "lcd %:p:h"
--      end
--   end,
--})

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




--auto close file exploer when quiting incase a single buffer is left
vim.cmd([[ autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'nvimtree') | q | endif ]])
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
        {'BufWritePre', '*', ':silent lua vim.lsp.buf.formatting_seq_sync()'},
    --    {'BufWritePre', '*', ':silent lua vim.lsp.buf.formatting_sync()'},
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
        {'BufWritePre', '*.go', 'lua require(\'lsp.format\').OrgImports(1000)'},
    }
})

acmd.define_augroups {
    _general_settings = {
        {
            'TextYankPost', '*',
            'lua require(\'vim.highlight\').on_yank({higroup = \'Search\', timeout = 200})'
        },
        --{
        --    'BufWinEnter', '*',
        --    'setlocal formatoptions-=c formatoptions-=r formatoptions-=o'
        --},
        --{
        --    'BufRead', '*',
        --    'setlocal formatoptions-=c formatoptions-=r formatoptions-=o'
        --},
        --{
        --    'BufNewFile', '*',
        --    'setlocal formatoptions-=c formatoptions-=r formatoptions-=o'
        --},
        ----{'VimLeavePre', '*', 'set title set titleold='},
        --{'FileType', 'qf', 'set nobuflisted'}
    },
    _git = {
      { "FileType", "gitcommit", "setlocal wrap" },
      { "FileType", "gitcommit", "setlocal spell" },
    },
}

return acmd
