return {
  -- lsp symbol navigation for lualine. This shows where
  -- in the code structure you are - within functions, classes,
  -- etc - in the statusline.
  {
    "SmiteshP/nvim-navic",
    lazy = true,
    init = function()
      vim.g.navic_silence = true
      require("utils").lsp.on_attach(function(client, buffer)
        if client.supports_method("textDocument/documentSymbol") then
          require("nvim-navic").attach(client, buffer)
        end
      end)
    end,
    opts = function()
      return {
        separator = " ",
        highlight = true,
        depth_limit = 5,
        icons = require("plugins.configs.lspkind_icons").kinds,
        lazy_update_context = true,
      }
    end,
  },

  -- lualine integration
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    opts = function(_, opts)
      --table.insert(opts.sections.lualine_c, {
      --  function()
      --    return require("nvim-navic").get_location()
      --  end,
      --  cond = function()
      --    return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
      --  end,
      --})

      table.insert(opts.winbar.lualine_b, {
        function()
          return require("nvim-navic").get_location()
        end,
        cond = function()
          return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
        end,
        separator = { left = "", right = "" },
      })
      table.insert(opts.winbar.lualine_y, {
        "filetype",
        icon_only = true,
        separator = { left = "", right = "" },
        cond = function()
          return vim.fn.winwidth(0) > 30 and require("nvim-navic").is_available()
        end,
        --separator = "",
        padding = { left = 1, right = 0 },
      })
      table.insert(opts.winbar.lualine_y, {
        "filename",
        path = 0,
        cond = function()
          return vim.fn.winwidth(0) > 30 and require("nvim-navic").is_available()
        end,
        color = { gui = "italic,bold" },
        symbols = { modified = "", readonly = "", unnamed = "" },
      })
      table.insert(opts.inactive_winbar.lualine_y, {
        "filetype",
        icon_only = true,
        separator = { left = "", right = "" },
        cond = function()
          return vim.fn.winwidth(0) > 30 and require("nvim-navic").is_available()
        end,
        --separator = "",
        padding = { left = 1, right = 0 },
      })
      table.insert(opts.inactive_winbar.lualine_y, {
        "filename",
        path = 0,
        cond = function()
          return vim.fn.winwidth(0) > 30 and require("nvim-navic").is_available()
        end,
        color = { gui = "italic,bold" },
        symbols = { modified = "", readonly = "", unnamed = "" },
      })
    end,
  },
}
