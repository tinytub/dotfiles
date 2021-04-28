local ui = {}
local conf = require('modules.ui.config')

--ui['kyazdani42/nvim-web-devicons'] = {
--  config = conf.web_devicons,
--}

ui['glepnir/zephyr-nvim'] = {
    disable = true
  --config = [[vim.cmd('colorscheme zephyr')]]
}
ui['cocopon/iceberg.vim'] = {
    opt=true,
  --disable = true,
  --config = [[vim.cmd('colorscheme iceberg')]]
}

--ui['morhetz/gruvbox'] = {
ui['lifepillar/vim-gruvbox8'] = {
  --disable = true,
  config = function ()
    vim.cmd('colorscheme gruvbox8')
    vim.cmd('set background=dark')
    vim.cmd('let g:gruvbox_plugin_hi_groups = 1')
  end
}

ui['norcalli/nvim-base16.lua'] = {
    opt=true,
  --config = [[vim.cmd('colorscheme base16-onedark')]]
}

ui['mhartington/oceanic-next'] = {
    opt=true,

}

ui['sainnhe/everforest'] = {
    opt=true,
    config = function ()
--        vim.cmd('colorscheme everforest')
    end
}

ui['ayu-theme/ayu-vim'] = {
    opt=true,
  config = function ()
    --vim.cmd('colorscheme ayu')
    vim.cmd('let ayucolor="dark"')
  end

}

--ui['onsails/lspkind-nvim'] = {
--  config = conf.lspkind_nvim,
--  requires = 'kyazdani42/nvim-web-devicons'
--}


ui['romgrk/barbar.nvim'] = {
  config = conf.barbar,
  requires = 'kyazdani42/nvim-web-devicons'
}

--ui['akinsho/nvim-bufferline.lua'] = {
--  config = conf.nvim_bufferline,
--  requires = {'kyazdani42/nvim-web-devicons'}
--}

ui['kyazdani42/nvim-tree.lua'] = {
  --cmd = {'NvimTreeToggle','NvimTreeOpen','NvimTreeFindFile'},
  config = conf.nvim_tree,
  requires = 'kyazdani42/nvim-web-devicons'
}

ui['lewis6991/gitsigns.nvim'] = {
  --event = {'BufRead','BufNewFile'},
  config = conf.gitsigns,
  requires = {'nvim-lua/plenary.nvim',opt=true}
}

ui['glepnir/dashboard-nvim'] = {
  config = conf.dashboard
}

ui['glepnir/galaxyline.nvim'] = {
  branch = 'main',
  config = conf.galaxyline,
  requires = 'kyazdani42/nvim-web-devicons'
}

ui['glepnir/indent-guides.nvim'] = {
  event = 'BufRead',
}

ui['tpope/vim-fugitive']  = {
    --disable = true,
}

return ui
