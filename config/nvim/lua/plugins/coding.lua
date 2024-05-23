-- for copilot
local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
    return false
  end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end

return {
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    config = true,
  },
  -- comments
  {
    "folke/ts-comments.nvim",
    event = "VeryLazy",
    opts = {},
    enabled = vim.fn.has("nvim-0.10") == 1,
  },
  {
    import = "plugins.extras.coding.mini-comment",
    enabled = vim.fn.has("nvim-0.10") == 0,
  },
  -- Better text-objects
  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    opts = function()
      LazyUtil.on_load("which-key.nvim", function()
        vim.schedule(LazyUtil.mini.ai_whichkey)
      end)
      local ai = require("mini.ai")
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({ -- code block
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- class
          t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
          d = { "%f[%d]%d+" }, -- digits
          e = { -- Word with case
            { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
            "^().*()$",
          },
          i = LazyUtil.mini.ai_indent, -- indent
          g = LazyUtil.mini.ai_buffer, -- buffer
          u = ai.gen_spec.function_call(), -- u for "Usage"
          U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
        },
      }
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    version = false,
    event = "InsertEnter",
    dependencies = {
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

        --"saadparwaiz1/cmp_luasnip",
        --"hrsh7th/cmp-nvim-lua",
        --"hrsh7th/cmp-nvim-lsp",
        --"hrsh7th/cmp-buffer",
        --"hrsh7th/cmp-path",
      },
    },
    -- Not all LSP servers add brackets when completing a function.
    -- To better deal with this, LazyVim adds a custom option to cmp,
    -- that you can configure. For example:
    --
    -- ```lua
    -- opts = {
    --   auto_brackets = { "python" }
    -- }
    -- ```
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
        preselect = cmp.PreselectMode.None, -- do not select the first item
        auto_brackets = {}, -- configure any filetype to auto add brackets
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

          --["<CR>"] = function(...)
          --  return confirm(...)
          --end,

          ["<CR>"] = LazyUtil.cmp.confirm(),
          ["<S-CR>"] = LazyUtil.cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<C-CR>"] = function(fallback)
            cmp.abort()
            fallback()
          end,
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() and has_words_before() then
              cmp.select_next_item()
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
    ---@param opts cmp.ConfigSchema | {auto_brackets?: string[]}
    config = function(_, opts)
      for _, source in ipairs(opts.sources) do
        source.group_index = source.group_index or 1
      end

      local parse = require("cmp.utils.snippet").parse
      require("cmp.utils.snippet").parse = function(input)
        local ok, ret = pcall(parse, input)
        if ok then
          return ret
        end
        return LazyUtil.cmp.snippet_preview(input)
      end

      local cmp = require("cmp")
      cmp.setup(opts)
      cmp.event:on("confirm_done", function(event)
        if vim.tbl_contains(opts.auto_brackets or {}, vim.bo.filetype) then
          LazyUtil.cmp.auto_brackets(event.entry)
        end
      end)
      cmp.event:on("menu_opened", function(event)
        LazyUtil.cmp.add_missing_snippet_docs(event.window)
      end)
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
    opts = {
      mappings = {
        ["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^\\`].", register = { cr = false } },
      },
    },
    keys = {
      {
        "<leader>up",
        function()
          vim.g.minipairs_disable = not vim.g.minipairs_disable
          if vim.g.minipairs_disable then
            LazyUtil.warn("Disabled auto pairs", { title = "Option" })
          else
            LazyUtil.info("Enabled auto pairs", { title = "Option" })
          end
        end,
        desc = "Toggle auto pairs",
      },
    },
  },
  -- snippets
  vim.fn.has("nvim-0.10") == 1
      and {
        "nvim-cmp",
        dependencies = {
          {
            "garymjr/nvim-snippets",

            opts = {
              friendly_snippets = true,
              global_snippets = { "all", "global" },
            },
            dependencies = { "rafamadriz/friendly-snippets" },
          },
        },
        opts = function(_, opts)
          opts.snippet = {
            expand = function(item)
              return LazyUtil.cmp.expand(item.body)
            end,
          }
          table.insert(opts.sources, { name = "snippets" })
        end,
        keys = {
          {
            "<Tab>",
            function()
              return vim.snippet.active({ direction = 1 }) and "<cmd>lua vim.snippet.jump(1)<cr>" or "<Tab>"
            end,
            expr = true,
            silent = true,
            mode = { "i", "s" },
          },
          {
            "<Tab>",
            function()
              vim.schedule(function()
                vim.snippet.jump(1)
              end)
            end,
            silent = true,
            mode = "s",
          },
          {
            "<S-Tab>",
            function()
              return vim.snippet.active({ direction = -1 }) and "<cmd>lua vim.snippet.jump(-1)<cr>" or "<Tab>"
            end,
            expr = true,
            silent = true,
            mode = { "i", "s" },
          },
        },
      }
    or { import = "plugins.extras.coding.luasnip", enabled = vim.fn.has("nvim-0.10") == 0 },
}
