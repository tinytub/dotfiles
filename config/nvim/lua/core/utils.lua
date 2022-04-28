local M = {}
local cmd = vim.cmd
M.close_buffer = function(force)
   if force or not vim.bo.buflisted then
      cmd ":bd!"
   else
      cmd "bd"
   end
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

-- load plugin after entering vim ui
M.packer_lazy_load = function(plugin, timer)
   if plugin then
      timer = timer or 0
      vim.defer_fn(function()
         require("packer").loader(plugin)
      end, timer)
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
