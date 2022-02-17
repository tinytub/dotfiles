local M = {}

M.autopairs = function()
    local present1, autopairs = pcall(require, "nvim-autopairs")
    local present2, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")

    if not (present1 or present2) then
       return
    end

    -- autopairs.setup()

    local cmp = require "cmp"
    --cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({map_char = {tex = ''}}))

    autopairs.setup {
      fast_wrap = {},
      check_ts = true,
      ts_config = {
        lua = { "string" }, -- it will not add pair on that treesitter node
        javascript = { "template_string" },
        java = false, -- don't check treesitter on java
      },
      disable_filetype = { "TelescopePrompt" , "vim" },
      autopairs = {enable = true},
      enable_check_bracket_line = false,
      html_break_line_filetype = {'html', 'vue', 'typescriptreact', 'svelte', 'javascriptreact'},
    }

    local ts_conds = require "nvim-autopairs.ts-conds"
    local Rule = require "nvim-autopairs.rule"
    autopairs.add_rules {
      Rule("%", "%", "lua"):with_pair(ts_conds.is_ts_node { "string", "comment" }),
      Rule("$", "$", "lua"):with_pair(ts_conds.is_not_ts_node { "function" }),
      Rule(" ", " "):with_pair(function(opts)
        local pair = opts.line:sub(opts.col - 1, opts.col)
        return vim.tbl_contains({"()", "[]", "{}"}, pair)
      end),
      Rule("(", ")"):with_pair(function(opts)
        return opts.prev_char:match ".%)" ~= nil
      end):use_key ")",
      Rule("{", "}"):with_pair(function(opts)
        return opts.prev_char:match ".%}" ~= nil
        end):use_key "}",
      Rule("[", "]"):with_pair(function(opts)
        return opts.prev_char:match ".%]" ~= nil
        end):use_key "]",
    }
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

            -- Available modes: foreground, background
            mode = "background", -- Set the display mode.
         },
      }
      colorizer.setup(default["filetypes"], default["user_default_options"])
      vim.cmd "ColorizerReloadAllBuffers"
   end
end

M.blankline = function()
   require("indent_blankline").setup {
      indentLine_enabled = 1,
      char = "▏",
      filetype_exclude = {
         "help",
         "terminal",
         "dashboard",
         "packer",
         "lspinfo",
         "TelescopePrompt",
         "TelescopeResults",
         "lsp-installer",
         ""
      },
      buftype_exclude = { "terminal" },
      show_trailing_blankline_indent = false,
      show_first_indent_level = false,
   }
end

M.better_escape = function()
   require("better_escape").setup {
      mapping = { "jk" },
      timeout =  300,
   }
end

M.luasnip = function()
    -- configs from https://github.com/arsham/shark/blob/master/lua/settings/luasnip/init.lua
   local present, luasnip = pcall(require, "luasnip")
   local types = require("luasnip.util.types")
   if present then
       luasnip.config.set_config {
          history = true,
          updateevents = "TextChanged,TextChangedI",
          ext_opts = {
            [types.choiceNode] = {
              active = {
                virt_text = { { " ", "TSTextReference" } },
              },
            },
            [types.insertNode] = {
              active = {
                virt_text = { { " ", "TSEmphasis" } },
              },
            },
          },
        }
       luasnip.snippets = {
         all = require("plugins.luasnips.all"),
         go = require("plugins.luasnips.golang"),
         lua = require("plugins.luasnips.lua"),
         gitcommit = require("plugins.luasnips.gitcommit"),
         markdown = require("plugins.luasnips.markdown"),
       }


      -- require("luasnip/loaders/from_vscode").load()

       require("luasnip.loaders.from_vscode").lazy_load()
   end
end

M.signature = function()
    local present, lspsignature = pcall(require, "lsp_signature")
    if present then
        lspsignature.setup(
            {
                bind = true,
                doc_lines = 0,
                floating_window = true,
                fix_pos = true,
                hint_enable = true,
                hint_prefix = " ",
                hint_scheme = "String",
                hi_parameter = "Search",
                max_height = 22,
                max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
                handler_opts = {
                    border = "single" -- double, single, shadow, none
                },
                zindex = 200, -- by default it will be on top of all floating windows, set to 50 send it to bottom
                padding = "" -- character to pad on left and right of signature can be ' ', or '|'  etc
            }
        )
    end
end

M.comment = function()
   local present, nvim_comment = pcall(require, "Comment")
   if present then
      nvim_comment.setup()
   end
end

return M
