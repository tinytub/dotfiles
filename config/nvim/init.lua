require('globals')
vim.cmd('luafile ' .. CONFIG_PATH .. '/settings.lua')
require('options')
require('plugins')

require('utils')
require('n-autocommands')
require('keymappings')
require('n-galaxyline')
require('n-telescope')
require('n-treesitter')
require('folke-which-key')
require('n-autopairs')

-- LSP
require('lsp')
require('lsp.bash-ls')
require('lsp.go-ls')
require('lsp.json-ls')
require('lsp.lua-ls')
require('lsp.python-ls')
require('lsp.vim-ls')
require('lsp.yaml-ls')
