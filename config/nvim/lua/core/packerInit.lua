local M = {}

M.lazy = function(install_path)
  print "Bootstrapping lazy.nvim .."

  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    install_path,
  }

  vim.opt.rtp:prepend(install_path)

  -- install plugins + compile their configs
  require("plugins")

  require("lazy").load { plugins = "nvim-treesitter" }

  -- install binaries from mason.nvim & tsparsers on LazySync
  vim.schedule(function()
    vim.cmd "bw | silent! MasonInstallAll" -- close lazy window
  end, 0)
end

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
