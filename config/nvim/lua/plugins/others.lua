local M = {}

M.autopairs = function()
  local present1, autopairs = pcall(require, "nvim-autopairs")
  local present2, cmp = pcall(require, "cmp")

  if not (present1 or present2) then
    return
  end

  -- autopairs.setup()

  autopairs.setup({
    fast_wrap = {},
    disable_filetype = { "TelescopePrompt", "vim" },
    --autopairs = {enable = true},
    --enable_check_bracket_line = false,
    --html_break_line_filetype = {'html', 'vue', 'typescriptreact', 'svelte', 'javascriptreact'},
  })
  local cmp_autopairs = require("nvim-autopairs.completion.cmp")

  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

  --local ts_conds = require "nvim-autopairs.ts-conds"
  --local Rule = require "nvim-autopairs.rule"
  --autopairs.add_rules {
  --  Rule("%", "%", "lua"):with_pair(ts_conds.is_ts_node { "string", "comment" }),
  --  Rule("$", "$", "lua"):with_pair(ts_conds.is_not_ts_node { "function" }),
  --  Rule(" ", " "):with_pair(function(opts)
  --    local pair = opts.line:sub(opts.col - 1, opts.col)
  --    return vim.tbl_contains({"()", "[]", "{}"}, pair)
  --  end),
  --  Rule("(", ")"):with_pair(function(opts)
  --    return opts.prev_char:match ".%)" ~= nil
  --  end):use_key ")",
  --  Rule("{", "}"):with_pair(function(opts)
  --    return opts.prev_char:match ".%}" ~= nil
  --    end):use_key "}",
  --  Rule("[", "]"):with_pair(function(opts)
  --    return opts.prev_char:match ".%]" ~= nil
  --    end):use_key "]",
  --}
end

M.colorizer = function()
  local present, colorizer = pcall(require, "colorizer")
  if present then
    local default = {
      filetypes = {
        "*",
      },
      user_default_options = {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        names = false, -- "Name" codes like Blue
        RRGGBBAA = false, -- #RRGGBBAA hex codes
        rgb_fn = false, -- CSS rgb() and rgba() functions
        hsl_fn = false, -- CSS hsl() and hsla() functions
        css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn

        mode = "background", -- Set the display mode.
      },
    }
    colorizer.setup(default["filetypes"], default["user_default_options"])
    vim.cmd "ColorizerAttachToBuffer"
  end
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
      "packer",
      "lspinfo",
      "TelescopePrompt",
      "TelescopeResults",
      "mason",
      "",
    },
    buftype_exclude = { "terminal" },
    show_trailing_blankline_indent = false,
    show_first_indent_level = false,
    show_current_context = true,
    show_current_context_start = true,
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
  local present, luasnip = pcall(require, "luasnip")
  --  local types = require("luasnip.util.types")
  if not present then
    return
  end
  luasnip.config.set_config({
    history = true,
    updateevents = "TextChanged,TextChangedI",
  })
  luasnip.snippets = {
    all = require("plugins.luasnips.all"),
    go = require("plugins.luasnips.golang"),
    lua = require("plugins.luasnips.lua"),
    gitcommit = require("plugins.luasnips.gitcommit"),
    markdown = require("plugins.luasnips.markdown"),
  }

  require("luasnip.loaders.from_vscode").lazy_load()
end

M.signature = function()
  local present, lsp_signature = pcall(require, "lsp_signature")

  if not present then
    return
  end

  local options = {
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

  lsp_signature.setup(options)
end

M.comment = function()
  local present, nvim_comment = pcall(require, "Comment")
  if present then
    nvim_comment.setup({

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
end

M.base46 = function()
  local base46 = require("base46")
  --base46.setup({ theme = "everforest", custom_highlights = "colors.themes.everforest" })
  base46.setup({ theme = "everforest" })
  --base46.setup({ theme = "onedark" })
  --base46.setup({ theme = "gruvbox" })
  -- then load the highlights
  package.loaded["colors.highlights" or false] = nil
  require("colors.highlights")
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
