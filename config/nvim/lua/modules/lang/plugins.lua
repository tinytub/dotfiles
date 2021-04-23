local lang = {}
local conf = require('modules.lang.config')

lang['nvim-treesitter/nvim-treesitter'] = {
  event = 'BufRead',
  after = 'telescope.nvim',
  config = conf.nvim_treesitter,
}

lang['nvim-treesitter/nvim-treesitter-textobjects'] = {
  after = 'nvim-treesitter'
}

lang['fatih/vim-go'] = {
  opt = true,
  ft = {'go','golang'},
  config = conf.vim_go,
}

return lang
