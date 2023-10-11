return {

  -- lsp_lines 可以分层显示 lsp 弹出的行内错误
  {
    enabled = false,
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    dependencies = { "nvim-lspconfig" },
    config = function()
      require("plugins.configs.lsp-line").setup()
    end,
    event = { "BufAdd", "BufRead", "BufNewFile", "InsertEnter" },
  },

  -- lspserver 状态插件, 停用了 statuslines 中的状态。
  {
    "j-hui/fidget.nvim",
    dependencies = { "nvim-lspconfig" },
    enabled = false,
    config = function()
      require("plugins.configs.fidget-nvim")
    end,
    event = { "BufAdd", "BufRead", "BufNewFile", "InsertEnter" },
    init = function()
      -- when noice is not enabled, install notify on VeryLazy
      local Util = require("utils")
      if not Util.has("noice.nvim") then
        print("noice not found, use fidget")

        Util.on_very_lazy(function()
          vim.notify = require("fidget")
        end)
      end
    end,
  },

  -- use {"dstein64/vim-startuptime"}
  -- Icons
  {
    "nvim-tree/nvim-web-devicons",
    --name = "nvim-web-devicons",
    --after = "base46",
    config = function()
      require("plugins.configs.icons")
    end,
    lazy = true,
  },

  -- ui components
  {
    "MunifTanjim/nui.nvim",
    lazy = true,
  },

  -- Notification Enhancer
  -- Better `vim.notify()`
  {
    "rcarriga/nvim-notify",
    enabled = true,
    keys = {
      {
        "<leader>un",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
        desc = "Dismiss all Notifications",
      },
    },
    opts = {
      timeout = 3000,
      fps = 30, -- defualt 30, but in alacritty it's too fast with flick
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      background_colour = "#000000",
    },
    init = function()
      -- when noice is not enabled, install notify on VeryLazy
      local Util = require("utils")
      if not Util.has("noice.nvim") then
        Util.on_very_lazy(function()
          vim.notify = require("notify")
        end)
      end
    end,
  },

  -- 关闭了fidget和notify, 如果手动关闭noice，记得打开fidget和notify
  -- Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu.
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    enabled = true,
    keys = {
      {
        "<S-Enter>",
        function()
          require("noice").redirect(vim.fn.getcmdline())
        end,
        mode = "c",
        desc = "Redirect Cmdline",
      },
      {
        "<leader>snl",
        function()
          require("noice").cmd("last")
        end,
        desc = "Noice Last Message",
      },
      {
        "<leader>snh",
        function()
          require("noice").cmd("history")
        end,
        desc = "Noice History",
      },
      {
        "<leader>sna",
        function()
          require("noice").cmd("all")
        end,
        desc = "Noice All",
      },
      --{ "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll forward", mode = { "i", "n", "s" } },
      --{ "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll backward", mode = { "i", "n", "s" } },
    },
    opts = {
      notify = {
        enabled = true,
        view = "mini",
      },
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        signature = { enabled = false },
      },
      messages = {
        view_search = false,
        view = "mini",
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
            },
          },
          view = "mini",
        },
        {
          filter = { event = "msg_show", find = "Hunk %d+ of %d+" },
          view = "mini",
        },
        {
          filter = { event = "msg_show", find = "%d+ more lines" },
          opts = { skip = true },
        },
        {
          filter = { event = "msg_show", find = "%d+ lines yanked" },
          opts = { skip = true },
        },
        {
          filter = { event = "msg_show", kind = "quickfix" },
          view = "mini",
        },
        {
          filter = { event = "msg_show", kind = "search_count" },
          view = "mini",
        },
        {
          filter = { event = "msg_show", kind = "wmsg" },
          view = "mini",
        },
        {
          --- hide written messages
          filter = {
            event = "msg_show",
            kind = "",
            find = "written",
          },
          opts = { skip = true },
        },
        {
          --- hide edits
          filter = {
            event = "msg_show",
            kind = "",
            find = "newer than edits",
          },
          opts = { skip = true },
        },
        {
          --- hide more line
          filter = {
            event = "msg_show",
            kind = "",
            find = " more line",
          },
          opts = { skip = true },
        },
        {
          filter = {
            event = "notify",
            find = "No information available",
          },
          opts = { skip = true },
        },
        {
          filter = {
            cond = function()
              return not focused
            end,
          },
          view = "notify_send",
          opts = { stop = false },
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        lsp_doc_border = true,
        inc_rename = require("utils").has("inc-rename.nvim"),
      },
      commands = {
        all = {
          view = "split",
          opts = { enter = true, format = "details" },
          filter = {},
        },
      },
      ---@type NoiceConfigViews
      views = {
        mini = {
          zindex = 100,
          win_options = { winblend = 0 },
        },
      },
    },
    init = function()
      focused = true
      vim.api.nvim_create_autocmd("FocusGained", {
        callback = function()
          focused = true
        end,
      })
      vim.api.nvim_create_autocmd("FocusLost", {
        callback = function()
          focused = false
        end,
      })
    end,
    config = function(_, opts)
      require("noice").setup(opts)
    end,
  },

  -- Neovim UI Enhancer
  {
    "stevearc/dressing.nvim",
    lazy = true,
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
    config = function()
      require("plugins.configs.dressing").config()
    end,
  },

  {
    "akinsho/bufferline.nvim",
    lazy = false,
    dependencies = { "catppuccin", "nvim-web-devicons" },
    event = "VeryLazy",
    opts = {
      options = {
        diagnostics = "nvim_lsp",
        show_buffer_close_icons = false,
        diagnostics_indicator = function(_, _, diag)
          --      local icons = require("lazyvim.config").icons.diagnostics
          local icons = require("plugins.configs.lspkind_icons").diagnostics
          local ret = (diag.error and icons.Error .. diag.error .. " " or "")
            .. (diag.warning and icons.Warn .. diag.warning or "")
          return vim.trim(ret)
        end,
        offsets = {
          {
            filetype = "neo-tree",
            text = "Neo-tree",
            highlight = "Directory",
            text_align = "left",
          },
        },
      },
    },
    config = function(_, opts)
      opts.highlights = require("catppuccin.groups.integrations.bufferline").get()
      require("bufferline").setup(opts)
      -- Fix bufferline when restoring a session
      vim.api.nvim_create_autocmd("BufAdd", {
        callback = function()
          vim.schedule(function()
            pcall(nvim_bufferline)
          end)
        end,
      })
    end,
  },

  {
    "kdheepak/tabline.nvim",
    enabled = false,
    config = function()
      require("tabline").setup({
        -- Defaults configuration options
        enable = true,
        options = {
          -- If lualine is installed tabline will use separators configured in lualine by default.
          -- These options can be used to override those settings.
          component_separators = { "", "" },
          section_separators = { "", "" },
          max_bufferline_percent = 66, -- set to nil by default, and it uses vim.o.columns * 2/3
          show_tabs_always = true, -- this shows tabs only when there are more than one tab or if the first tab is named
          show_devicons = true, -- this shows devicons in buffer section
          colored = true,
          show_bufnr = false, -- this appends [bufnr] to buffer section,
          tabline_show_last_separator = true,
          show_filename_only = true, -- shows base filename only instead of relative path in filename
          modified_icon = "+ ", -- change the default modified icon
          modified_italic = true, -- set to true by default; this determines whether the filename turns italic if modified
          show_tabs_only = false, -- this shows only tabs instead of tabs + buffers
        },
      })
      vim.cmd([[
      set guioptions-=e " Use showtabline in gui vim
      set sessionoptions+=tabpages,globals " store tabpages and globals in session
    ]])
    end,
    --dependencies = { 'hoob3rt/lualine.nvim', 'kyazdani42/nvim-web-devicons' }
    dependencies = { "lualine.nvim", "nvim-web-devicons" },
  },

  -- Simple statusline component that shows what scope you are working inside
  {
    "SmiteshP/nvim-navic",
    --event = "CursorMoved",
    --config = function()
    --  require("plugins.configs.navic")
    --end,
    enabled = true,
    lazy = true,
    init = function()
      vim.g.navic_silence = true
      require("utils").on_attach(function(client, buffer)
        if client.server_capabilities.documentSymbolProvider then
          require("nvim-navic").attach(client, buffer)
        end
      end)
    end,
    opts = function()
      return {
        separator = "  ",
        -- limit for amount of context shown
        -- 0 means no limit
        depth_limit = 5,
        highlight = true,
        -- indicator used when context hits depth limit
        depth_limit_indicator = "..",
        icons = require("plugins.configs.lspkind_icons").kinds,
        lazy_update_context = true,
      }
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      vim.o.laststatus = 0
    end,
    opts = function()
      local navic = require("nvim-navic")

      local icons = require("plugins.configs.lspkind_icons")
      local Utils = require("utils")

      vim.o.laststatus = vim.g.lualine_laststatus
      -- https://github.com/Strazil001/Nvim/blob/main/after/plugin/lualine.lua
      -- https://github.com/LazyVim/LazyVim

      local colors = {
        red = "#cdd6f4",
        grey = "#181825",
        black = "#1e1e2e",
        white = "#313244",
        base = "#24273A", -- https://github.com/catppuccin/nvim/blob/main/lua/catppuccin/palettes/macchiato.lua
        light_green = "#6c7086",
        orange = "#fab387",
        green = "#a6e3a1",
        blue = "#80A7EA",
      }
      -- is e0bc, nf-ple-upper_left_triangle
      -- is e0ba, nf-ple-lower_right_triangle

      local vim_icons = {
        function()
          --return " "
          return " "
        end,
        separator = { left = "", right = "" },
        color = { bg = "#313244", fg = "#80A7EA" },
        padding = { left = 1, right = 0 },
      }

      local space = {
        function()
          return " "
        end,
        color = { bg = colors.base, fg = "#80A7EA" },
        padding = { left = 0, right = 0 },
      }

      local dir = {
        function()
          local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")

          return dir_name
          --if vim.b.vaffle ~= nil then
          --  local short_path = M.shorten(vim.b.vaffle["dir"])
          --  return short_path
          --end

          --if vim.b.short_path == nil then
          --  vim.b.short_path = M.shorten(vim.fn.expand("%:p:h"))
          --end
          --print("dir")

          --return vim.b.short_path
        end,
        separator = { left = "", right = "" },
        icon = "",
      }

      --local function dir()
      --  local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
      --
      --  return dir_name
      --end

      local filename = {
        "filename",
        color = { bg = "#80A7EA", fg = "#242735" },
        path = 1,
        separator = { left = "", right = "" },
      }

      local filetype = {
        "filetype",
        icon_only = true,
        colored = true,
        color = { bg = "#313244" },
        separator = { left = "", right = "" },
      }

      --local filetype_tab = {
      --  "filetype",
      --  icon_only = true,
      --  colored = true,
      --  color = { bg = "#313244" },
      --}

      --local buffer = {
      --  require 'tabline'.tabline_buffers,
      --  separator = { left = "", right = "" },
      --}
      --
      --local tabs = {
      --  require 'tabline'.tabline_tabs,
      --  separator = { left = "", right = "" },
      --}

      local fileformat = {
        "fileformat",
        color = { bg = "#b4befe", fg = "#313244" },
        separator = { left = "", right = "" },
      }

      local encoding = {
        "encoding",
        color = { bg = "#313244", fg = "#80A7EA" },
        separator = { left = "", right = "" },
      }

      local branch = {
        "branch",
        color = { bg = "#a6e3a1", fg = "#313244" },
        separator = { left = "", right = "" },
      }

      local function buffer_git_diff()
        local diff = vim.b.gitsigns_status_dict

        if diff then
          return { added = diff.added, modified = diff.changed, removed = diff.removed }
        else
          return {}
        end
      end

      local function buffer_not_empty()
        return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
      end

      local diff = {
        "diff",
        color = { bg = "#313244", fg = "#313244" },
        cond = buffer_not_empty,
        separator = { left = "", right = "" },
        symbols = {
          added = icons.git.added,
          modified = icons.git.modified,
          removed = icons.git.removed,
        },

        -- condition buffer_not_empty
        source = buffer_git_diff,
      }

      local modes = {
        "mode",
        fmt = function(str)
          return str:sub(1, 1)
        end,
        --color = { bg = "#fab387		", fg = "#1e1e2e" },
        separator = { left = "", right = "" },
      }

      local function getLspName()
        local msg = "No Active Lsp"
        local buf_ft = vim.api.nvim_get_option_value(0, "filetype")
        local clients = require("utils").get_clients()
        if next(clients) == nil then
          return msg
        end
        for _, client in ipairs(clients) do
          local filetypes = client.config.filetypes
          if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            --return "  " .. client.name
            return " " .. client.name
          end
        end
        return "  " .. msg
      end

      local dia = {
        "diagnostics",
        cond = buffer_not_empty,
        color = { bg = "#313244", fg = "#80A7EA" },
        separator = { left = "", right = "" },
        symbols = {
          error = icons.diagnostics.Error,
          warn = icons.diagnostics.Warn,
          info = icons.diagnostics.Info,
          hint = icons.diagnostics.Hint,
        },
      }

      local lsp = {
        function()
          return getLspName()
        end,

        cond = buffer_not_empty,
        separator = { left = "", right = "" },
        color = { bg = "#f38ba8", fg = "#1e1e2e" },
      }

      return {
        options = {
          icons_enabled = true,
          theme = "auto",
          globalstatus = true,
          ---- stylua: ignore
          --close_command = function(n) require("mini.bufremove").delete(n, false) end,
          ---- stylua: ignore
          --right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
          disabled_filetypes = {
            statusline = { "alpha", "dashboard", "alpha", "neo-tree", "terminal" },
            winbar = { "neo-tree", "edgy" },
          },
          --component_separators = { left = "", right = "" },
          --section_separators = { left = "", right = "" },
          --component_separators = { left = '', right = '' },
          --section_separators = { left = '', right = '' },
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },

          ignore_focus = {},
          --always_divide_middle = true,
          --refresh = {
          --  statusline = 1000,
          --  --tabline = 1000,
          --  winbar = 1000,
          --},
        },
        sections = {
          lualine_a = {
            { "mode", separator = { left = "", right = "" } },
            --"mode",
            --modes,
            vim_icons,
          },
          lualine_b = {
            --"branch"
            space,
            dir,
            space,
          },
          lualine_c = {
            filename,
            filetype,
            space,
            branch,
            diff,
          },
          lualine_x = {
            -- space,
            -- stylua: ignore
            {
              function() return require("noice").api.status.command.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
              color = Utils.fg("Statement"),
            },
            -- stylua: ignore
            {
              function() return require("noice").api.status.mode.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
              color = Utils.fg("Constant"),
            },
            -- stylua: ignore
            {
              function() return "  " .. require("dap").status() end,
              cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
              color = Utils.fg("Debug"),
            },
            { require("lazy.status").updates, cond = require("lazy.status").has_updates, color = Utils.fg("Special") },
            --{
            --  "diff",
            --  symbols = {
            --    added = icons.git.added,
            --    modified = icons.git.modified,
            --    removed = icons.git.removed,
            --  },
            --},
          },
          lualine_y = {
            encoding,
            fileformat,
            space,
            --{ "filetype", icon_only = false, },

            -- {
            --   "progress",
            --   fmt = function()
            --     local msg = "No Active Lsp"
            --     local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
            --     local clients = vim.lsp.get_active_clients()
            --     if next(clients) == nil then
            --       return msg
            --     end
            --     for _, client in ipairs(clients) do
            --       local filetypes = client.config.filetypes
            --       if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            --         return client.name
            --       end
            --     end
            --     return msg
            --   end,
            --   icon = " ",
            -- }
          },
          lualine_z = {
            dia,
            { require("lazy.status").updates, cond = require("lazy.status").has_updates, color = Utils.fg("Special") },
            lsp,
            ---- { "progress", separator = "", padding = { left = 1, right = 0 } },
            --{ "location", padding = { left = 1, right = 1 } },
            --function()
            --  -- encoding
            --  local enc = (vim.bo.fenc ~= '' and vim.bo.fenc) or vim.o.enc
            --  --return " " .. enc:upper() .. " "
            --  return enc:upper()
            --end,
            --function()
            --  -- file format
            --  local fmt = vim.bo.fileformat
            --  return fmt:upper()
            --end,
          },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
        --tabline = {
        --  lualine_a = {
        --    buffer,
        --  },
        --  lualine_b = {
        --  },
        --  lualine_c = {},
        --  lualine_x = {
        --    tabs,
        --  },
        --  lualine_y = {
        --    space,
        --  },
        --  lualine_z = {
        --  },
        --},
        extensions = { "neo-tree", "lazy" },
        winbar = {
          lualine_a = {},
          lualine_b = {
            --{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            --{
            --  'filename',
            --  path = 0,
            --  cond = navic.is_available,
            --  color = { gui = 'italic,bold' },
            --  symbols = { modified = "", readonly = "", unnamed = "" },

            --},
            {
              function()
                return navic.get_location()
              end,
              cond = function()
                return vim.fn.winwidth(0) > 30 and navic.is_available()
              end,
              separator = { left = "", right = "" },
            },
          },
          lualine_c = {},
          lualine_x = {},
          lualine_y = {
            --{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            {
              "filetype",
              icon_only = true,
              separator = { left = "", right = "" },
              cond = function()
                return vim.fn.winwidth(0) > 30 and navic.is_available()
              end,
              --separator = "",
              padding = { left = 1, right = 0 },
            },
            {
              "filename",
              path = 0,
              cond = function()
                return vim.fn.winwidth(0) > 30 and navic.is_available()
              end,
              color = { gui = "italic,bold" },
              symbols = { modified = "", readonly = "", unnamed = "" },
            },
          },
          lualine_z = {},
        },
        inactive_winbar = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {
            {
              "filetype",
              icon_only = true,
              cond = function()
                return vim.fn.winwidth(0) > 30 and navic.is_available()
              end,
              separator = { left = "", right = "" },
              --separator = "",
              padding = { left = 1, right = 0 },
            },
            --{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            {
              "filename",
              path = 0,
              cond = function()
                return vim.fn.winwidth(0) > 30 and navic.is_available()
              end,
              symbols = { modified = "", readonly = "", unnamed = "" },
            },
          },
          lualine_z = {},
        },
      }
    end,
  },
  -- indent guides for Neovim
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "LazyFile",
    opts = {
      indent = {
        char = "│",
        tab_char = "│",
      },
      scope = { enabled = false },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
      },
    },
    main = "ibl",
  },
  -- active indent guide and indent text objects
  {
    "echasnovski/mini.indentscope",
    version = false, -- wait till new 0.7.0 release to put it back on semver
    event = "LazyFile",
    opts = {
      -- symbol = "▏",
      symbol = "│",
      options = { try_as_border = true },
      draw = {
        delay = 50,
        animation = function()
          return 10
        end,
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason", "notify" },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },
  -- todo highlights
  {
    "folke/todo-comments.nvim",
    event = "LazyFile",
    --dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("plugins.configs.todo-comments")
    end,
    -- event = 'BufWinEnter',
    enabled = true,
  },

  -- Dashboard
  {
    "goolord/alpha-nvim",
    enabled = true,
    optional = false,
    event = "VimEnter",
    --after = "base46",
    config = function()
      require("plugins.configs.dashboard")
    end,
  },

  --A Neovim plugin helping you establish good command workflow and habit
  {
    "m4xshen/hardtime.nvim",
    enabled = false,
    event = "VeryLazy",
    opts = {
      hiny = true,
      restricted_keys = {
        ["h"] = {},
        ["j"] = {},
        ["k"] = {},
        ["l"] = {},
      },
    },
  },
}
