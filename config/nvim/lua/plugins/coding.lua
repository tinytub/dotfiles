return {
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    config = function(_, opts)
      require("go").setup(opts)
    end,
    opts = {
      -- we only need go command with this plugin
      disable_defaults = true,
      -- go binary need to set
      go = "go",
      -- preludes need set like below, otherwise will cause error
      preludes = {
        default = function()
          return {}
        end, -- one for all commands
        GoRun = function() -- the commands to run before GoRun, this override default
          return {} -- e.g. return {'watchexe', '--restart', '-v', '-e', 'go'}
          -- so you will run `watchexe --restart -v -e go go run `
        end,
      },
    },

    --    config = function() require "plugins.configs.go-nvim" end,
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
    },
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local cmp = require("cmp")

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

      local border_opts = {
        border = "rounded",
        winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
      }
      -- 去重
      opts.duplicates = {
        nvim_lsp = 1,
        cmp_tabnine = 1,
        buffer = 1,
        path = 1,
      }
      opts.window = {
        completion = cmp.config.window.bordered(border_opts),
        documentation = cmp.config.window.bordered(border_opts),
      }

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif vim.snippet.active({ direction = 1 }) then
            vim.schedule(function()
              vim.snippet.jump(1)
            end)
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif vim.snippet.active({ direction = -1 }) then
            vim.schedule(function()
              vim.snippet.jump(-1)
            end)
          else
            fallback()
          end
        end, { "i", "s" }),
      })
    end,
    --config = function(_, opts)
    --  for _, source in ipairs(opts.sources) do
    --    source.group_index = source.group_index or 1
    --  end

    --  local parse = require("cmp.utils.snippet").parse
    --  require("cmp.utils.snippet").parse = function(input)
    --    local ok, ret = pcall(parse, input)
    --    if ok then
    --      return ret
    --    end
    --    return LazyVim.cmp.snippet_preview(input)
    --  end

    --  local cmp = require("cmp")
    --  cmp.setup(opts)
    --  cmp.event:on("confirm_done", function(event)
    --    if vim.tbl_contains(opts.auto_brackets or {}, vim.bo.filetype) then
    --      LazyVim.cmp.auto_brackets(event.entry)
    --    end
    --  end)
    --  cmp.event:on("menu_opened", function(event)
    --    LazyVim.cmp.add_missing_snippet_docs(event.window)
    --  end)
    --  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
    --  cmp.setup.cmdline("/", {
    --    mapping = cmp.mapping.preset.cmdline(),
    --    sources = {
    --      { name = "nvim_lsp" },
    --      { name = "buffer" },
    --    },
    --  })
    --  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    --  cmp.setup.cmdline(":", {
    --    mapping = cmp.mapping.preset.cmdline(),
    --    sources = cmp.config.sources({
    --      { name = "path" },
    --      { name = "cmdline" },
    --    }),
    --  })
    --end,
  },
}
