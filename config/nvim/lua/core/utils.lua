local M = {}
local api = vim.api
local fn = vim.fn
local cmd = vim.cmd

M.close_buffer = function(force)
    if vim.bo.buftype == "terminal" then
        api.nvim_win_hide(0)
        return
    end

    local fileExists = fn.filereadable(fn.expand "%p")
    local modified = api.nvim_buf_get_option(fn.bufnr(), "modified")

    -- if file doesnt exist & its modified
    if fileExists == 0 and modified then
        print "no file name? add it now!"
        return
    end

    force = force or not vim.bo.buflisted or vim.bo.buftype == "nofile"

    -- if not force, change to prev buf and then close current
    local close_cmd = force and ":bd!" or ":bp | bd" .. fn.bufnr()
    vim.cmd(close_cmd)
end
-- hide statusline
-- tables fetched from load_config function
M.hide_statusline = function()
    local hidden = {
        "help",
        --         "dashboard",
        "alpha",
        --       "NvimTree",
        "terminal",
    }
    local shown = {}
    local api = vim.api
    local buftype = api.nvim_buf_get_option("0", "ft")

    -- shown table from config has the highest priority
    if vim.tbl_contains(shown, buftype) then
        api.nvim_set_option("laststatus", 2)
        return
    end

    if vim.tbl_contains(hidden, buftype) then
        api.nvim_set_option("laststatus", 0)
        return
    else
        api.nvim_set_option("laststatus", 2)
    end
end

M.map = function(mode, keys, command, opt)
    local options = { noremap = true, silent = true }
    if opt then
        options = vim.tbl_extend("force", options, opt)
    end
    if type(keys) == "table" then
        for _, keymap in ipairs(keys) do
            M.map(mode, keymap, command, opt)
        end
        return
    end
    vim.keymap.set(mode, keys, command, opt)
end

return M
