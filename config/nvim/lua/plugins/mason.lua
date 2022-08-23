local present, mason = pcall(require, "mason")

if not present then
  return
end

vim.api.nvim_create_augroup("_mason", { clear = true })
vim.api.nvim_create_autocmd("Filetype", {
  pattern = "mason",
  callback = function()
    require("base46").load_highlight "mason"
  end,
  group = "_mason",
})

--require("base46").load_highlight "mason"

local options = {
  ensure_installed = {
    "lua-language-server",
    "stylua",

    -- web dev
    "json-lsp",
    "yaml-language-server",

    "pyright",
    "gopls",
    "prettierd",

    -- shell
    --"shfmt",
    --"shellcheck",
  }, -- not an option from mason.nvim

  ui = {
    icons = {
      package_pending = " ",
      package_installed = " ",
      package_uninstalled = " ﮊ",
    },

    keymaps = {
      toggle_server_expand = "<CR>",
      install_server = "i",
      update_server = "u",
      check_server_version = "c",
      update_all_servers = "U",
      check_outdated_servers = "C",
      uninstall_server = "X",
      cancel_installation = "<C-c>",
    },
  },

  max_concurrent_installers = 10,
}

vim.api.nvim_create_user_command("MasonInstallAll", function()
  vim.cmd("MasonInstall " .. table.concat(options.ensure_installed, " "))
end, {})

mason.setup(options)