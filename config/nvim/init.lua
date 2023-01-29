if vim.g.vscode then
  require("core.options")
  require("vscode")
else
  require("core.options")
  require("core.autocmds")
  require("core.global")
  --require("core.packerInit").bootstrap()
  local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    require("core.lazyInit").lazyLoad(lazypath)
  end

  require("core.lazyInit").lazyStart(lazypath)


  --require("plugins.pluginList")
  -- install binaries from mason.nvim & tsparsers
  --vim.api.nvim_create_autocmd("User", {
  --  pattern = "PackerComplete",
  --  callback = function()
  --    vim.cmd "bw | silent! MasonInstallAll" -- close packer window
  --    require("packer").loader "nvim-treesitter"
  --  end,
  --})

  -- set all the non plugin mappings
  require("core.keymappings").misc()
end
