local completion = {}
local conf = require('modules.completion.config')

completion['neovim/nvim-lspconfig'] = {
  event = 'BufReadPre',
  config = conf.nvim_lsp,
}
completion['kabouzeid/nvim-lspinstall'] = {
}

completion['glepnir/lspsaga.nvim'] = {
  --disable = true,
  cmd = 'Lspsaga',
  config = conf.lspsaga,
}

completion['hrsh7th/nvim-compe'] = {
  event = 'InsertEnter',
  config = conf.nvim_compe,
}

completion['hrsh7th/vim-vsnip'] = {
  event = 'InsertCharPre',
  config = conf.vim_vsnip,
--  requires = 'hrsh7th/vim-vsnip-integ'
  requires = {{'rafamadriz/friendly-snippets'}}
}

--completion['rafamadriz/friendly-snippets'] = {
--  event = 'InsertCharPre',
--}

completion['nvim-telescope/telescope.nvim'] = {
  cmd = 'Telescope',
  config = conf.telescope,
  requires = {
    {'nvim-lua/popup.nvim'},
    {'nvim-lua/plenary.nvim'},
    {'nvim-telescope/telescope-fzy-native.nvim'},
  }
}

--completion['glepnir/smartinput.nvim'] = {
--  ft = 'go',
--  config = conf.smart_input
--}

completion['mattn/vim-sonictemplate'] = {
  cmd = 'Template',
  ft = {'go','typescript','lua','javascript','vim','rust','markdown'},
  config = conf.vim_sonictemplate,
}

completion['mattn/emmet-vim'] = {
  event = 'InsertEnter',
  ft = {'html','css','javascript','javascriptreact','vue','typescript','typescriptreact'},
  config = conf.emmet,
}

completion['ray-x/lsp_signature.nvim'] = {
    disable = true,
}

return completion
