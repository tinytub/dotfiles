return {
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
          require("plugins.configs.others").luasnip()
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
        "hrsh7th/cmp-path",
        'hrsh7th/cmp-cmdline',
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
      local cmp = require 'cmp'
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
        if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
      end

      local confirm = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      })

      return {
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        completion = {
          completeopt = "menu,menuone,noinsert",
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
          behavior = cmp.ConfirmBehavior.Insert,
          select = false,
        },
        window = {
          completion = {
            border = border("CmpBorder"),
            side_padding = 1,
            winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
            --scrollbar = false,
            zindex = 1001,
          },
          documentation = {
            side_padding = 1,
            border = border("CmpDocBorder"),
            winhighlight = "Normal:CmpDoc",
            zindex = 1001,
          },
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
          -- old
          --["<CR>"] = cmp.mapping.confirm({
          --  behavior = cmp.ConfirmBehavior.Replace,
          --  select = false,
          --}),
          -- copilot
          ["<CR>"] = function(...)
            return confirm(...)
          end,

          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
              --elseif require("luasnip").expand_or_jumpable() then
              --   vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
              --elseif luasnip.expand_or_jumpable() then
              --  luasnip.expand_or_jump()
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
        sources = {
          { name = "nvim_lsp", },
          { name = "luasnip", },
          { name = "buffer", },
          {
            name = "path",
            max_item_count = 4
          },
          -- { name = "nvim_lua",               priority = 60 },
          -- { name = "calc" },
          -- { name = "nvim_lsp_signature_help" },

          --{
          --  name = "buffer",
          --  priority = 5,
          --  keyword_length = 3,
          --  max_item_count = 5,
          --  option = {
          --    get_bufnrs = function()
          --      return vim.api.nvim_list_bufs()
          --    end,
          --  },
          --},
          { name = "rg", keyword_length = 3, max_item_count = 10, priority = 1 },
        },
      }
    end,
    config = function(_, opts)
      local cmp = require 'cmp'
      cmp.setup(opts)
      -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'nvim_lsp' },
          { name = 'buffer' }
        }
      })
      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' },
          { name = 'cmdline' }
        })
      })
    end
  },
}
