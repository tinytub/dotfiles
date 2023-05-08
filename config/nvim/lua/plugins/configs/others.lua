local M = {}

M.colorizer = function()
  local options = {}
  require("colorizer").setup(options)
  vim.defer_fn(function()
    require("colorizer").attach_to_buffer(0)
  end, 0)
  --vim.cmd "ColorizerAttachToBuffer"
end

M.blankline = function()
  --    require("base46").load_highlight "blankline"
  require("indent_blankline").setup({
    indentLine_enabled = 1,
    char = "▏",

    filetype_exclude = {
      "help",
      "terminal",
      "alpha",
      "lazy",
      "lspinfo",
      "dashboard",
      "TelescopePrompt",
      "TelescopeResults",
      "mason",
      "neo-tree",
      "Trouble",
      "lazy",
      "noice",
      "nui",
      "mason",
    },

    buftype_exclude = { "terminal" },
    show_trailing_blankline_indent = false,
    show_first_indent_level = false,
    show_current_context = false,
    --show_current_context_start = true,
  })
end

M.better_escape = function()
  require("better_escape").setup({
    mapping = { "jk" },
    timeout = 300,
    clear_empty_lines = false, -- clear line after escaping if there is only whitespace
    keys = "<Esc>",
  })
end

M.luasnip = function()
  -- configs from https://github.com/arsham/shark/blob/master/lua/settings/luasnip/init.lua
  local luasnip = require("luasnip")

  luasnip.config.set_config({
    history = true,
    delete_check_events = "TextChanged",
  })
  luasnip.snippets = {
    all = require("plugins.luasnips.all"),
    go = require("plugins.luasnips.golang"),
    lua = require("plugins.luasnips.lua"),
    gitcommit = require("plugins.luasnips.gitcommit"),
    markdown = require("plugins.luasnips.markdown"),
  }

  require("luasnip.loaders.from_vscode").lazy_load()
  require("luasnip.loaders.from_vscode").lazy_load { paths = vim.g.luasnippets_path or "" }
end

M.signature = function()
  local options = M.signature_opt()
  require("lsp_signature").setup()
end

M.signature_opt = function()
  return {
    bind = true,
    doc_lines = 0,
    floating_window = true,
    fix_pos = true,
    hint_enable = false,
    hint_prefix = " ",
    hint_scheme = "String",
    hi_parameter = "Search",
    max_height = 22,
    max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
    handler_opts = {
      border = "single", -- double, single, shadow, none
    },
    zindex = 200, -- by default it will be on top of all floating windows, set to 50 send it to bottom
    padding = "", -- character to pad on left and right of signature can be ' ', or '|'  etc
  }
end

M.comment = function()
  require("Comment").setup({
    padding = true, -- Add a space b/w comment and the line
    sticky = true, -- Whether the cursor should stay at its position

    -- We define all mappings manually to support neovim < 0.7
    mappings = {
      basic = false, -- Includes `gcc`, `gbc`, `gc[count]{motion}` and `gb[count]{motion}`
      extra = false, -- Includes `gco`, `gcO`, `gcA`
      extended = false, -- Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
    },
  })
end

M.base46 = function()
  local base46 = require("base46")
  --base46.setup({ theme = "everforest", custom_highlights = "colors.themes.everforest" })
  base46.setup({ theme = "everforest" })
  --base46.setup({ theme = "onedark" })
  --base46.setup({ theme = "gruvbox" })

  -- then load the highlights
  --package.loaded["colors.highlights" or false] = nil
  --require("colors.highlights")
end

M.quickscope = function()
  vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }
  vim.g.qs_max_chars = 150
  -- colors config in colors.highlights

  --local quickscopercolor = vim.api.nvim_create_augroup("quickscopercolor", { clear = true })
  --vim.api.nvim_create_autocmd("ColorScheme", {
  --	group = quickscopercolor,
  --	pattern = "*",
  --	--command = "highlight QuickScopePrimary guifg='#b1fa87' gui=underline ctermfg=155 cterm=underline",
  --	command = "highlight link QuickScopePrimary IncSearch",
  --})

  --vim.api.nvim_create_autocmd("ColorScheme", {
  --	group = quickscopercolor,
  --	pattern = "*",
  --	--command = "highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline",
  --	command = "highlight link QuickScopeSecondary Search",
  --})
  --vim.api.nvim_command("augroup quickscopecolor")
  --vim.api.nvim_command("autocmd!")
  --vim.api.nvim_command(
  --    "autocmd ColorScheme * highlight QuickScopePrimary guifg='#b1fa87' gui=underline ctermfg=155 cterm=underline"
  --)
  --vim.api.nvim_command(
  --    "autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline"
  --)
  --vim.api.nvim_command("augroup END")
end

return M
