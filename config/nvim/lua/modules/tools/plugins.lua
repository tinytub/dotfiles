local tools = {}
local conf = require('modules.tools.config')

tools['kristijanhusak/vim-dadbod-ui'] = {
  cmd = {'DBUIToggle','DBUIAddConnection','DBUI','DBUIFindBuffer','DBUIRenameBuffer'},
  config = conf.vim_dadbod_ui,
  requires = {{'tpope/vim-dadbod',opt = true}}
}

tools['editorconfig/editorconfig-vim'] = {
  ft = { 'go','typescript','javascript','vim','rust','zig','c','cpp' }
}

tools['glepnir/prodoc.nvim'] = {
  event = 'BufReadPre'
}

tools['liuchengxu/vista.vim'] = {
  cmd = 'Vista',
  config = conf.vim_vista
}

-- find and replace
tools['brooth/far.vim'] = {
  cmd = {'Far','Farp'},
  config = function ()
    vim.g['far#source'] = 'rg'
  end
}

tools['iamcco/markdown-preview.nvim'] = {
  ft = 'markdown',
  config = function ()
    vim.g.mkdp_auto_start = 0
  end
}

tools['voldikss/vim-floaterm'] = {
  cmd = {'FloatermNew','FloatermPrev','FloatermNext','FloatermFirst','FloatermLast','FloatermUpdate','FloatermToggle','FloatermShow','FloatermHide','FloatermKill','FloatermSend'},
  config = function ()
    vim.g.floaterm_gitcommit='floaterm'
    vim.g.floaterm_autoinsert=1
    vim.g.floaterm_width=0.8
    vim.g.floaterm_height=0.8
    vim.g.floaterm_wintitle=0
    vim.g.floaterm_autoclose=1
  end
}

return tools
