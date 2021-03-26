local ui = {}
local conf = require('modules.ui.config')

--ui['kyazdani42/nvim-web-devicons'] = {
--  config = conf.web_devicons,
--}

ui['glepnir/zephyr-nvim'] = {
  --config = [[vim.cmd('colorscheme zephyr')]]
}
ui['cocopon/iceberg.vim'] = {
  disable = true,
  config = [[vim.cmd('colorscheme iceberg')]]
}

--ui['morhetz/gruvbox'] = {
ui['lifepillar/vim-gruvbox8'] = {
  --disable = true,
  config = [[vim.cmd('colorscheme gruvbox8')]]
}

ui['chriskempson/base16-vim'] = {
    disable = true
  --config = [[vim.cmd('colorscheme base16-onedark')]]
}



ui['glepnir/dashboard-nvim'] = {
  config = conf.dashboard
}

ui['glepnir/galaxyline.nvim'] = {
  branch = 'main',
  config = conf.galaxyline,
  requires = {'kyazdani42/nvim-web-devicons'}
}

ui['glepnir/indent-guides.nvim'] = {
  event = 'BufRead',
}

ui['onsails/lspkind-nvim'] = {
  config = conf.lspkind_nvim,
  requires = {'kyazdani42/nvim-web-devicons'}
}

ui['itchyny/vim-parenmatch'] = {}

ui['romgrk/barbar.nvim'] = {
  config = conf.barbar,
  requires = {'kyazdani42/nvim-web-devicons'}
}

--ui['akinsho/nvim-bufferline.lua'] = {
--  config = conf.nvim_bufferline,
--  requires = {'kyazdani42/nvim-web-devicons'}
--}

ui['kyazdani42/nvim-tree.lua'] = {
  cmd = {'NvimTreeToggle','NvimTreeOpen','NvimTreeFindFile'},
  config = conf.nvim_tree,
  requires = {'kyazdani42/nvim-web-devicons'}
}

ui['lewis6991/gitsigns.nvim'] = {
  event = {'BufRead','BufNewFile'},
  config = conf._gitsigns,
  requires = {'nvim-lua/plenary.nvim',opt=true}
}

return ui
