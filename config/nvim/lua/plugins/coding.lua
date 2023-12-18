return {
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    config = true,
  },
  -- comments
  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    opts = {
      options = {
        custom_commentstring = function()
          return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
        end,
      },
    },
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = true,
    opts = {
      enable_autocmd = false,
    },
  },

  {
    "hrsh7th/nvim-cmp",
    version = false,
    event = "InsertEnter",
    dependencies = {
      {
        -- snippet plugin
        "L3MON4D3/LuaSnip",
        build = (not jit.os:find("Windows"))
            and "echo -e 'NOTE: jsregexp is optional, so not a big deal if it fails to build\n'; make install_jsregexp"
          or nil,
        dependencies = { "rafamadriz/friendly-snippets", "onsails/lspkind.nvim" },
        config = function()
          local luasnip = require("luasnip")

          luasnip.config.set_config({
            history = true,
            delete_check_events = "TextChanged",
          })
          luasnip.snippets = {
            --           all = require("plugins.extras.luasnips.all"),
            go = require("plugins.extras.luasnips.golang"),
            lua = require("plugins.extras.luasnips.lua"),
            gitcommit = require("plugins.extras.luasnips.gitcommit"),
            markdown = require("plugins.extras.luasnips.markdown"),
          }

          require("luasnip.loaders.from_vscode").lazy_load()
          require("luasnip.loaders.from_vscode").lazy_load({ paths = vim.g.luasnippets_path or "" })
        end,
      },

      -- autopairing of (){}[] etc
      --{
      --  enabled = false,
      --  "windwp/nvim-autopairs",
      --  config = function()
      --    require("plugins.configs.autopairs")
      --  end,
      --},
      -- cmp sources plugins
      {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        --        "hrsh7th/cmp-path",
        "FelipeLema/cmp-async-path",
        "hrsh7th/cmp-cmdline",
        "saadparwaiz1/cmp_luasnip",

        --"saadparwaiz1/cmp_luasnip",
        --"hrsh7th/cmp-nvim-lua",
        --"hrsh7th/cmp-nvim-lsp",
        --"hrsh7th/cmp-buffer",
        --"hrsh7th/cmp-path",
      },
    },
    opts = function()
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
      local cmp = require("cmp")
      local defaults = require("cmp.config.default")()
      local function border(hl_name)
        return {
          { "╭", hl_name },
          { "─", hl_name },
          { "╮", hl_name },
          { "│", hl_name },
          { "╯", hl_name },
          { "─", hl_name },
          { "╰", hl_name },
          { "│", hl_name },
        }
      end

      --local has_words_before = function()
      --  if vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt' then
      --    return false
      --  end
      --  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      --  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line-1, line, true)[1]:sub(col, col):match('%s') == nil
      --end

      --local has_words_before = function()
      --  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      --  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      --end

      -- for copilot
      local has_words_before = function()
        if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
          return false
        end
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
      end

      local confirm = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      })
      local border_opts = {
        border = "rounded",
        winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
      }
      return {
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        preselect = cmp.PreselectMode.None, -- do not select the first item
        completion = {
          completeopt = "menu,menuone,noinsert,noselect",
        },
        formatting = {
          ---- 补全窗口的顺序
          --fields = { "kind", "abbr", "menu" },
          --format = function(_, vim_item)

          --  -- load lspkind icons
          --  -- vim_item.kind = string.format("%s %s", require("plugins.configs.lspkind_icons")[vim_item.kind], vim_item.kind)

          --  --vim_item.menu = ({
          --  --   nvim_lsp = "[LSP]",
          --  --   nvim_lua = "[Lua]",
          --  --   buffer = "[BUF]",
          --  --})[entry.source.name]

          --  return vim_item
          --end,

          --format = require 'lspkind'.cmp_format({
          --  mode = "symbol_text",
          --}),
          format = function(_, item)
            local icons = require("plugins.configs.lspkind_icons").kinds
            if icons[item.kind] then
              item.kind = icons[item.kind] .. item.kind
            end
            return item
          end,
        },
        experimental = {
          ghost_text = {
            hl_group = "CmpGhostText",
          },
        },
        sorting = defaults.sorting,

        -- 去重
        duplicates = {
          nvim_lsp = 1,
          luasnip = 1,
          cmp_tabnine = 1,
          buffer = 1,
          path = 1,
        },
        confirm_opts = {
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        },
        window = {
          completion = cmp.config.window.bordered(border_opts),
          documentation = cmp.config.window.bordered(border_opts),
        },

        mapping = {
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
          ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
          ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
          ["<C-y>"] = cmp.config.disable,
          ["<C-e>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
          }),

          ["<CR>"] = function(...)
            return confirm(...)
          end,
          ["<C-CR>"] = function(fallback)
            cmp.abort()
            fallback()
          end,
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() and has_words_before() then
              cmp.select_next_item()
            elseif require("luasnip").expand_or_jumpable() then
              --vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "") --  luasnip.expand_or_jump()
              require("luasnip").expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
              --elseif require("luasnip").jumpable(-1) then
              --   vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
              --elseif luasnip.jumpable(-1) then
              --   luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          --{ name = "path" },
          { name = "async_path" },
        }, {
          { name = "buffer" },
        }),
        --sources = {
        --  { name = "nvim_lsp", priority = 1000, group_index = 1 },
        --  { name = "luasnip",  priority = 750,  group_index = 1 },
        --  { name = "buffer",   priority = 500,  group_index = 2 },
        --  {
        --    name = "path",
        --    priority = 250,
        --    group_index = 2,
        --    --  max_item_count = 4
        --  },
        --  -- { name = "nvim_lua",               priority = 60 },
        --  -- { name = "calc" },
        --  -- { name = "nvim_lsp_signature_help" },

        --  --{
        --  --  name = "buffer",
        --  --  priority = 5,
        --  --  keyword_length = 3,
        --  --  max_item_count = 5,
        --  --  option = {
        --  --    get_bufnrs = function()
        --  --      return vim.api.nvim_list_bufs()
        --  --    end,
        --  --  },
        --  --},
        --  { name = "rg", keyword_length = 3, max_item_count = 10, priority = 1 },
        --},
      }
    end,
    config = function(_, opts)
      local cmp = require("cmp")

      for _, source in ipairs(opts.sources) do
        source.group_index = source.group_index or 1
      end
      cmp.setup(opts)
      -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "nvim_lsp" },
          { name = "buffer" },
        },
      })
      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
          { name = "cmdline" },
        }),
      })
    end,
  },

  -- auto pairs
  {
    enabled = true,
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "<leader>up",
        function()
          local Util = require("lazy.core.util")
          vim.g.minipairs_disable = not vim.g.minipairs_disable
          if vim.g.minipairs_disable then
            Util.warn("Disabled auto pairs", { title = "Option" })
          else
            Util.info("Enabled auto pairs", { title = "Option" })
          end
        end,
        desc = "Toggle auto pairs",
      },
    },
  },
}
