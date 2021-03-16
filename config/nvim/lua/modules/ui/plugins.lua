local ui = {}
local conf = require('modules.ui.config')

ui['glepnir/zephyr-nvim'] = {
  --config = [[vim.cmd('colorscheme zephyr')]]
}

ui['morhetz/gruvbox'] = {
  config = [[vim.cmd('colorscheme gruvbox')]]
}

ui['chriskempson/base16-vim'] = {
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

--ui['romgrk/barbar.nvim'] = {
--  config = conf.barbar,
--  requires = {'kyazdani42/nvim-web-devicons'}
--}

ui['akinsho/nvim-bufferline.lua'] = {
  config = conf.nvim_bufferline,
  requires = {'kyazdani42/nvim-web-devicons'}
}

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
