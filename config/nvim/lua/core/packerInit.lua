local M = {}

M.bootstrap = function()
   local fn = vim.fn
   local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

   vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1e222a" })

   if fn.empty(fn.glob(install_path)) > 0 then
      print "Cloning packer .."

      fn.system { "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path }

      print "Packer cloned successfully!"

      -- install plugins + compile their configs
      vim.cmd "packadd packer.nvim"
      --require "plugins"
      require "pluginList"
      vim.cmd "PackerSync"
   end


end

M.getPacker = function()
   local present, packer = pcall(require, "packer")

   if not present then
      return
   end

   packer.init(M.options)

   return packer.use, packer
end

M.options = {
   auto_clean = true,
   compile_on_sync = true,
   git = { clone_timeout = 6000 },
   display = {
      working_sym = "ﲊ",
      error_sym = "✗",
      done_sym = "﫟",
      removed_sym = "",
      moved_sym = "",
      open_fn = function()
         return require("packer.util").float { border = "single" }
      end,
   },
}

return M








--vim.cmd "packadd packer.nvim"
--
--local present, packer = pcall(require, "packer")
--
--if not present then
--   local packer_path = vim.fn.stdpath "data" .. "/site/pack/packer/opt/packer.nvim"
--
--   print "Cloning packer.."
--   -- remove the dir before cloning
--   vim.fn.delete(packer_path, "rf")
--   vim.fn.system {
--      "git",
--      "clone",
--      "https://github.com/wbthomason/packer.nvim",
--      "--depth",
--      "20",
--      packer_path,
--   }
--
--   vim.cmd "packadd packer.nvim"
--   present, packer = pcall(require, "packer")
--
--   if present then
--      print "Packer cloned successfully."
--   else
--      error("Couldn't clone packer !\nPacker path: " .. packer_path .. "\n" .. packer)
--   end
--end
--
--packer.init {
--   display = {
--      open_fn = function()
--         return require("packer.util").float { border = "single" }
--      end,
--   },
--   git = {
--      clone_timeout = 6000, -- Timeout, in seconds, for git clones
--   },
--   auto_clean = true,
--   compile_on_sync = true,
--   snapshot = nil,
--   --    auto_reload_compiled = true
--}
--
--return packer
