local M = {}
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  --vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
  print "Bootstrapping lazy.nvim .."
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

-- vim.opt.rtp:prepend(lazypath)
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

-- use to start up lazy
local opts = {
  spec = {
    { import = "plugins" },
    --{ import = "plugins.configs.nvim-lualine" },
    --{ import = "plugins.configs.nvim-cmp" },

    { import = "plugins.extras.test" },
    { import = "plugins.extras.ui.edgy" },
    -- { import = "plugins.extras.coding.copilot" },
    ---    { import = "plugins.extras.coding.codeium" },
    { import = "plugins.extras.coding.yanky" },
    --{ import = "plugins.extras.dap" },
    --{ import = "plugins.extras.lsp" },
    --{ import = "plugins.extras.formatting" },
    --{ import = "plugins.extras.editor.symbols-outline" },
    { import = "plugins.extras.lang.json" },
    { import = "plugins.extras.lang.lua" },
    { import = "plugins.extras.lang.yaml" },
    --{ import = "plugins.extras.lang.lua" },
    { import = "plugins.extras.lang.go" },
    { import = "plugins.extras.lang.typescripts" },
    --{ import = "plugins.extras.lang.python" },
    { import = "plugins.extras.editor.mini-files" },
    { import = "plugins.extras.editor.navic" },
    { import = "plugins.extras.editor.aerial" },
    --{ import = "plugins.extras.database" },
    --{ import = "plugins.extras.editor.leap" },
    --    { import = "plugins.extras.ui.mini-animate" },
    { import = "plugins.extras.vscode" },
    --    { import = "plugins.extras.util.mini-hipatterns" }, twinlandcss

    -- add LazyVim and import its plugins
    -- { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- import any extras modules here
    -- { import = "lazyvim.plugins.configs.extras.lang.typescript" },
    -- { import = "lazyvim.plugins.configs.extras.lang.json" },
    -- { import = "lazyvim.plugins.configs.extras.ui.mini-animate" },
    -- import/override with your plugins
  },
  colorscheme = function()
    vim.api.nvim_command([[syntax on]])
    if vim.fn.has("termguicolors") == 1 then
      vim.cmd.set("termguicolors")
    end
    --local colors = require("catppuccin.palettes").get_palette()
    --require("colors.catppuccin")
    vim.cmd.colorscheme("catppuccin")
  end,

  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = true,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  ui = {
    border = "rounded",
    --icons = {
    --  ft = "",
    --  lazy = "鈴 ",
    --  loaded = "",
    --  not_loaded = "",
    --},
  },

  install = { colorscheme = { "catppuccin", "tokyonight", "habamax" } },
  checker = { enabled = false }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
}

local function neovide_config()
  vim.cmd([[set guifont=JetBrainsMonoNL\ Nerd\ Font:h14]])
  --vim.cmd [[set guifont=Input\ Nerd\ Font:h14]]
  --opt.guifont = "JetBrainsMono Nerd Font Mono"
  vim.g.neovide_refresh_rate = 60
  vim.g.neovide_cursor_vfx_mode = "railgun"
  --vim.g.neovide_cursor_vfx_mode = "ripple"
  --vim.g.neovide_no_idle = true
  vim.g.neovide_cursor_animation_length = 0.03
  vim.g.neovide_remember_window_size = true
  vim.g.neovide_cursor_trail_length = 0.05
  vim.g.neovide_cursor_antialiasing = true
  vim.g.neovide_cursor_vfx_opacity = 200.0
  vim.g.neovide_cursor_vfx_particle_lifetime = 1.2
  vim.g.neovide_cursor_vfx_particle_speed = 20.0
  vim.g.neovide_cursor_vfx_particle_density = 5.0
end

if vim.g.neovide then
  neovide_config()
end

function M.global_setup()
  require("core.config").init()
  require("lazy").setup(opts)
  require("core.config").setup(opts)
end

return M
