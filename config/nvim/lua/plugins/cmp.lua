local present, cmp = pcall(require, "cmp")

if not present then
   return
end

vim.opt.completeopt = "menuone,noselect"


--local has_words_before = function()
--  if vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt' then
--    return false
--  end
--  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line-1, line, true)[1]:sub(col, col):match('%s') == nil
--end


-- nvim-cmp setup
cmp.setup {
   snippet = {
      expand = function(args)
         require("luasnip").lsp_expand(args.body)
     end,
   },

   formatting = {
      format = function(entry, vim_item)
         -- load lspkind icons
         vim_item.kind = string.format(
            "%s %s",
            require("plugins.lspkind_icons").icons[vim_item.kind],
            vim_item.kind
         )

         vim_item.menu = ({
            nvim_lsp = "[LSP]",
            nvim_lua = "[Lua]",
            buffer = "[BUF]",
         })[entry.source.name]

         -- 去重
         vim_item.dup = ({
            buffer = 1,
            path = 1,
            nvim_lsp = 0,
         })[entry.source.name] or 0

         return vim_item
      end,
   },
   documentation = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
      winhighlight = 'NormalFloat:NormalFloat,FloatBorder:TelescopePreviewBorder',
   },
   mapping = {
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      ["<C-n>"] = cmp.mapping.select_next_item(),
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.close(),
      ["<CR>"] = cmp.mapping.confirm {
         behavior = cmp.ConfirmBehavior.Replace,
         select = true,
      },
      --["<Tab>"] = function(fallback)
      --   if cmp.visible() then
      --      cmp.select_next_item()
      --   elseif require("luasnip").expand_or_jumpable() then
      --      vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
      --   else
      --      fallback()
      --   end
      --end,
      --["<S-Tab>"] = function(fallback)
      --   if cmp.visible() then
      --      cmp.select_prev_item()
      --   elseif require("luasnip").jumpable(-1) then
      --      vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
      --   else
      --      fallback()
      --   end
      --end,

      ["<Tab>"] =  cmp.mapping(function(fallback)
            if cmp.visible() then
               cmp.select_next_item()
            elseif require("luasnip").expand_or_jumpable() then
               vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
            else
               fallback()
            end
         end, { "i", "s" }),

      ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
               cmp.select_prev_item()
            elseif require("luasnip").jumpable(-1) then
               vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
            else
               fallback()
            end
        end, { "i", "s" }),

   },
   sources = {
      { name = "nvim_lsp", priority = 80 },
      { name = "nvim_lua" , priority = 80},
      { name = "path", priority = 40, max_item_count = 4 },
      { name = "luasnip" , priority = 10},
      { name = "calc" },
      { name = "nvim_lsp_signature_help" },

      {
        name = "buffer",
        priority = 5,
        keyword_length = 3,
        max_item_count = 5,
        option = {
          get_bufnrs = function()
            return vim.api.nvim_list_bufs()
          end,
        },
      },
      { name = "rg", keyword_length = 3, max_item_count = 10, priority = 1 },

   },
}

