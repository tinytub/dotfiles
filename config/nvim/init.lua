if vim.g.vscode then
  require("core.options")
  require("vscode")
else
  vim.defer_fn(function()
    pcall(require, "impatient")
  end, 0)
  require("core.utils")
  require("core.options")
  require("core.autocmds")
  require("core.global")
  require("core.packerInit").bootstrap()
  require("core.packerInit").startup()
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
