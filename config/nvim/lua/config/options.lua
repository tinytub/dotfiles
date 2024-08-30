-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

opt.relativenumber = false
opt.wrap = true -- Enable line wrap

opt.spell = false
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
--vim.bo.expandtab   = true

-- for avante.nvim
opt.splitkeep = "screen"

--opt.title = true
--opt.titlelen = 0 -- do not shorten title
--opt.titlestring = 'nvim %{expand("%:p")}'
