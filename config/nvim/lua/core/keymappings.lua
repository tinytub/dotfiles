local cmd = vim.cmd
local utils = require "core.utils"
local map = utils.map
local user_cmd = vim.api.nvim_create_user_command

local M = {}
local opt = {}


M.misc = function()
    local function non_config_mappings()
        -- navigation between windows
        map('n', '<C-h>', '<C-w>h')
        map('n', '<C-j>', '<C-w>j')
        map('n', '<C-k>', '<C-w>k')
        map('n', '<C-l>', '<C-w>l')

        -- move cursor within insert mode
        map("i", "<C-h>", "<Left>")
        map("i", "<C-l>", "<Right>")
        map("i", "<C-j>", "<Down>")
        map("i", "<C-k>", "<Up>")
        map("i", "<C-a>", "<ESC>^i")
        map("i", "<C-e>", "<End>")

        -- command line Mode 移动光标
        map('c', '<C-h>', '<Left>', opt)
        map('c', '<C-l>', '<Right>', opt)
        map('c', '<C-j>', '<Down>', opt)
        map('c', '<C-k>', '<Up>', opt)
        map('c', '<C-t>', '[[<C-R>=expand("%:p:h") . "/" <CR>]]', opt)

        -- Move selected line / block of text in visual mode
        map('x', 'K', ':move \'<-2<CR>gv-gv', {noremap = true, silent = true})
        map('x', 'J', ':move \'>+1<CR>gv-gv', {noremap = true, silent = true})

        vim.cmd('vnoremap p "0p')
        vim.cmd('vnoremap P "0P')

        -- map('n', '<C-x>', ':lua require(\'core.utils\').close_buffer() <CR>', {noremap = true, silent = true})

    end

    local function required_mappings()
        -- snapshot stuff
        local packer_cmd = function(callback)
           return function()
              require "plugins.pluginList"
              require("packer")[callback]()
           end
        end
        user_cmd("PackerSnapshot", function(info)
           require "plugins.pluginList"
           require("packer").snapshot(info.args)
        end, { nargs = "+" })

        user_cmd("PackerSnapshotDelete", function(info)
           require "plugins.pluginList"
           require("packer.snapshot").delete(info.args)
        end, { nargs = "+" })

        user_cmd("PackerSnapshotRollback", function(info)
           require "plugins.pluginList"
           require("packer").rollback(info.args)
        end, { nargs = "+" })

        user_cmd("PackerClean", packer_cmd "clean", {})
        user_cmd("PackerCompile", packer_cmd "compile", {})
        user_cmd("PackerInstall", packer_cmd "install", {})
        user_cmd("PackerStatus", packer_cmd "status", {})
        user_cmd("PackerSync", packer_cmd "sync", {})
        user_cmd("PackerUpdate", packer_cmd "update", {})
    end

    non_config_mappings()
    required_mappings()
end

--M.misc()
--M.terms()
return M
