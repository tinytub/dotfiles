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

  -- set all the non plugin mappings
  require("core.keymappings").misc()
end
