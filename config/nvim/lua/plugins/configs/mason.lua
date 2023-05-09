local mason = require("mason")

--vim.api.nvim_create_augroup("_mason", { clear = true })
--vim.api.nvim_create_autocmd("Filetype", {
--  pattern = "mason",
--  --callback = function()
--  --  require("base46").load_highlight "mason"
--  --end,
--  group = "_mason",
--})

--require("base46").load_highlight "mason"

local options = {
  ensure_installed = {
    "lua-language-server",
    "bash-language-server",
    "stylua",
    "shfmt",

    -- web dev
    "json-lsp",
    --"yaml-language-server",
    --"tsserver",
    "cssls",
    "tailwindcss",
    "html",

    "pyright",
    "gopls",
    "prettierd",

    -- shell
    --"shfmt",
    --"shellcheck",
  }, -- not an option from mason.nvim
  automatic_installation = true,

  PATH = "skip",
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

mason.setup(options)
local mr = require("mason-registry")
local function ensure_installed()
  for _, tool in ipairs(opts.ensure_installed) do
    local p = mr.get_package(tool)
    if not p:is_installed() then
      p:install()
    end
  end
end

if mr.refresh then
  mr.refresh(ensure_installed)
else
  ensure_installed()
end
