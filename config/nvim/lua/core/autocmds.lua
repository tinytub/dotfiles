-- add binaries installed by mason.nvim to path
local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
vim.env.PATH = vim.env.PATH .. (is_windows and ";" or ":") .. vim.fn.stdpath "data" .. "/mason/bin"

local acmd = {}

local autocmd = vim.api.nvim_create_autocmd

---- wrap the PackerSync command to warn people before using it in NvChadSnapshots
--autocmd("VimEnter", {
--  callback = function()
--    vim.api.nvim_create_user_command("PackerSync", function(opts)
--      require "plugins"
--      require("core.utils").packer_sync(opts.fargs)
--    end, {
--      bang = true,
--      nargs = "*",
--      complete = require("packer").plugin_complete,
--    })
--  end,
--})

autocmd("InsertLeave", {
  callback = function()
    if require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
        and not require("luasnip").session.jump_active
    then
      require("luasnip").unlink_current()
    end
  end,
})
---- open nvim with a dir while still lazy loading nvimtree
--autocmd("BufEnter", {
--   callback = function()
--      if vim.api.nvim_buf_get_option(0, "buftype") ~= "terminal" then
--         vim.cmd "lcd %:p:h"
--      end
--   end,
--})

--auto close file exploer when quiting incase a single buffer is left
autocmd("BufEnter", {
  pattern = "*",
  command = "if (winnr(\"$\") == 1 && &filetype == 'nvimtree') | q | endif",
})
autocmd("BufEnter", {
  pattern = "*",
  command = "if (winnr(\"$\") == 1 && &filetype == 'nvimtree') | q | endif",
})

-- dont list quickfix buffers
autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.opt_local.buflisted = false
  end,
})

-- do not autocommenting with o/O
autocmd("FileType", {
  command = "set formatoptions-=cro",
})

local function augroup(name)
  return vim.api.nvim_create_augroup("myvim" .. name, { clear = true })
end

-- go to last loc when opening a buffer
autocmd("BufReadPost", {
  group = augroup("last_loc"),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- close some filetypes with <q>
autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "query", -- :InspectTree
    "lspinfo",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "PlenaryTestPopup",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

function acmd.define_augroups(definitions) -- {{{1
  -- Create autocommand groups based on the passed definitions
  --
  -- The key will be the name of the group, and each definition
  -- within the group should have:
  --    1. Trigger
  --    2. Pattern
  --    3. Text
  -- just like how they would normally be defined from Vim itself
  for group_name, definition in pairs(definitions) do
    vim.cmd("augroup " .. group_name)
    vim.cmd("autocmd!")

    for _, def in pairs(definition) do
      local command = table.concat(vim.tbl_flatten({ "autocmd", def }), " ")
      vim.cmd(command)
    end

    vim.cmd("augroup END")
  end
end

--acmd.define_augroups({
--    goautofmt = {
--        -- Go generally requires Tabs instead of spaces.
--        { "FileType", "*.go", "setlocal tabstop=4" },
--        { "FileType", "*.go", "setlocal shiftwidth=4" },
--        { "FileType", "*.go", "setlocal softtabstop=4" },
--        { "FileType", "*.go", "setlocal noexpandtab" },
--        --{'BufWritePre', '*.go', 'lua vim.lsp.buf.formatting()'},
--        --{'FileType', '*.go', ':autocmd! autoformat'},
--        --{ "BufWritePre", "*.go", "lua require('lsp.format').OrgImports(1000)" },
--    },
--})

acmd.define_augroups({
  _general_settings = {
    {
      "TextYankPost",
      "*",
      "lua require('vim.highlight').on_yank({higroup = 'Search', timeout = 200})",
    },
    --{
    --    'BufWinEnter', '*',
    --    'setlocal formatoptions-=c formatoptions-=r formatoptions-=o'
    --},
    --{
    --    'BufRead', '*',
    --    'setlocal formatoptions-=c formatoptions-=r formatoptions-=o'
    --},
    --{
    --    'BufNewFile', '*',
    --    'setlocal formatoptions-=c formatoptions-=r formatoptions-=o'
    --},
    ----{'VimLeavePre', '*', 'set title set titleold='},
    --{'FileType', 'qf', 'set nobuflisted'}
  },
  _git = {
    { "FileType", "gitcommit", "setlocal wrap" },
    { "FileType", "gitcommit", "setlocal spell" },
  },
})

return acmd
