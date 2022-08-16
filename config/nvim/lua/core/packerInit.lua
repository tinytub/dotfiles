local M = {}

-- compile path config from https://github.com/ibhagwan/nvim-lua/blob/main/lua/plugins/init.lua
-- we don't want the compilation file in '~/.config/nvim'
-- place it under '~/.local/shared/nvim/plugin' instead
-- vscode will not read
local compile_suffix = "/plugin/packer_compiled.lua"
local compile_path = vim.fn.stdpath("data") .. compile_suffix
local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
--local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/opt/packer.nvim"

M.bootstrap = function()
  local fn = vim.fn

  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1e222a" })

  if fn.empty(fn.glob(install_path)) > 0 then
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1e222a" })
    print "Cloning packer .."

    fn.delete(install_path, "rf")
    fn.delete(compile_path, "rf")

    fn.system { "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path }

    -- install plugins + compile their configs
    vim.cmd "packadd packer.nvim"
    --require "plugins"
    require "plugins.pluginList"
    vim.cmd "PackerSync"
  end


end
M.startup = function()
  require("plugins.pluginList")
  if vim.loop.fs_stat(compile_path) then
    -- since we customized the compilation path for packer
    -- we need to manually load 'packer_compiled.lua'
    vim.cmd("luafile " .. compile_path)
  else
    -- no 'packer_compiled.lua', we assume this is the
    -- first time install, 'sync()' will clone|update
    -- our plugins and generate 'packer_compiled.lua'
    --packer.sync()
    vim.cmd "PackerSync"
  end
end

M.getPacker = function()
  local present, packer = pcall(require, "packer")

  if not present then
    return
  end

  if packer.config.compile_path ~= compile_path and
      vim.loop.fs_stat(packer.config.compile_path) then
    vim.fn.delete(packer.config.compile_path, "rf")
    vim.fn.delete(vim.fn.fnamemodify(packer.config.compile_path, ":p:h"), "d")
  end


  local config = M.options

  --packer.init(M.options)
  packer.init(config)

  -- We shouldn't technically do this but for some reason packer uses a local
  -- table variable for config which doesn't get get updated properly after init
  packer.config.compile_path = config.compile_path
  -- hook to avoid the 'packer.compile: Complete' notify
  packer.on_compile_done = function() end

  return packer.use, packer
end

M.options = {
  compile_path = compile_path,
  auto_clean = true,
  compile_on_sync = true,
  git = { clone_timeout = 6000 },
  max_jobs = 10,
  display = {
    working_sym = "ﲊ",
    error_sym = "✗ ",
    done_sym = " ",
    removed_sym = " ",
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
