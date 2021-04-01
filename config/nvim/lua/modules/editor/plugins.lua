local editor = {}
local conf = require('modules.editor.config')

editor['Raimondi/delimitMate'] = {
  disable = true,
  event = 'InsertEnter',
  config = conf.delimimate,
}

editor['itchyny/vim-parenmatch'] = {}
editor['windwp/nvim-autopairs'] = {
    config = conf.autopairs,
}

-- 加速 jk 移动的速度
editor['rhysd/accelerated-jk'] = {
  opt = true
}

editor['norcalli/nvim-colorizer.lua'] = {
  ft = { 'html','css','sass','vim','lua','typescript','typescriptreact'},
  config = conf.nvim_colorizer
}

editor['itchyny/vim-cursorword'] = {
  event = {'BufReadPre','BufNewFile'},
  config = conf.vim_cursorwod
}

editor['unblevable/quick-scope'] = {
  config = function ()
    -- Trigger a highlight in the appropriate direction when pressing these keys:
    -- vim.cmd('let g:qs_highlight_on_keys = [\'f\', \'F\', \'t\', \'T\']')
    vim.g.qs_highlight_on_keys = {'f', 'F', 't', 'T'}
    vim.g.qs_max_chars=150
    vim.api.nvim_command('augroup quickscopecolor')
    vim.api.nvim_command('autocmd!')
    vim.api.nvim_command("autocmd ColorScheme * highlight QuickScopePrimary guifg='#b1fa87' gui=underline ctermfg=155 cterm=underline")
    vim.api.nvim_command("autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline")
    vim.api.nvim_command('augroup END')
  end
}

--editor['hrsh7th/vim-eft'] = {
--  opt = true,
--  config = function()
--    vim.g.eft_ignorecase = true
--  end
--}

editor['kana/vim-operator-replace'] = {
  keys = {{'x','p'}},
  config = function()
    vim.api.nvim_set_keymap("x", "p", "<Plug>(operator-replace)",{silent =true})
  end,
  requires = 'kana/vim-operator-user'
}


editor['psliwka/vim-smoothie'] = {
  config = function()
        vim.g.smoothie_no_default_mappings = true
  end,
}


editor['rhysd/vim-operator-surround'] = {
  event = 'BufRead',
  requires = 'kana/vim-operator-user'
}

editor['kana/vim-niceblock']  = {
  opt = true
}
editor['liuchengxu/vim-which-key'] = {
}

return editor
