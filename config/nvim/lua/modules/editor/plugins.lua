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

editor['hrsh7th/vim-eft'] = {
  opt = true,
  config = function()
    vim.g.eft_ignorecase = true
  end
}

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
