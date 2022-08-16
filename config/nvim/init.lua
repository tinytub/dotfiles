if vim.g.vscode then
  require("core.options")
  require("vscode")
else
  vim.defer_fn(function()
    pcall(require, "impatient")
  end, 0)
  require("core.options")
  require("core.autocmds")
  require("core.global")
  require("core.packerInit").bootstrap()
  require("core.packerInit").startup()
  --require("plugins.pluginList")

  -- set all the non plugin mappings
  require("core.keymappings").misc()
end
