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

tools["plasticboy/vim-markdown"] = {
  ft = "markdown",
  requires = {"godlygeek/tabular"},
  cmd = {"Toc"},
  config = conf.markdown,
  opt = true,
}

tools['iamcco/markdown-preview.nvim'] = {
  opt = true,
  ft = {"markdown", 'pandoc.markdown', 'rmd'},
  cmd = {"MarkdownPreview"},
  run = 'cd app && npm install',
  config = conf.mkdp,
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

tools['vim-test/vim-test'] = {
    config = function ()
      vim.g["test#strategy"] = "floaterm"
      --vim.g["test#strategy"] = "neovim"
      --vim.g["test#strategy"] = {
      --  nearest = "neovim",
      --  file = "neovim",
      --  suite = "neovim"
      --}
      vim.g["test#neovim#term_position"] = "vert"
      vim.g['test#preserve_screen'] = 1
      vim.g["test#go#runner"] = "gotest"
      vim.g["test#go#gotest#options"] = "-v --count=1"

    end
}

-- some day migrate to this
tools['folke/which-key.nvim'] = {
--    disable = true,
--    opt =true,
    config = conf.whichkey,
}

return tools
