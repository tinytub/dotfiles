local plugins = {

  ---- Easily speed up your neovim startup time!
  "nathom/filetype.nvim",

  -- Lua functions
  "nvim-lua/plenary.nvim",

  -- Package Manager
  {
    "williamboman/mason.nvim",
    cmd = { "Mason" },
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    opts = {
      ensure_installed = {
        "stylua",
        "shfmt",
        "gopls",
        -- "flake8",
      },
    },
    --config = function(_,opts)
    --  require "plugins.configs.mason"
    --end,
    ---@param opts MasonSettings | {ensure_installed: string[]}
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require "mason-registry"
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then p:install() end
        end
      end

      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
    enabled = true,
  },

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "b0o/SchemaStore.nvim", -- Get extra JSON schemas -- 虽然不知道干嘛用,但是先留着吧, jsonls

      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      {
        "hrsh7th/cmp-nvim-lsp",
        cond = function() return require("utils").has "nvim-cmp" end,
      },
    },
    opts = {
      autoformat = true,
      format_notify = false,
      diagnostics = {
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
          -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
          -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
          -- prefix = "icons",
        },
        signs = true,
        severity_sort = true,
        underline = true,
        update_in_insert = false, -- update diagnostics insert mode
        float = {
          --  focused = false,
          --  style = "minimal",
          border = "rounded",
          --  source = "always",
          --  header = "",
          --  prefix = "",
        },
      },
      -- options for vim.lsp.buf.format
      -- `bufnr` and `filter` is handled by the formatter,
      -- but can be also overridden when specified
      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- example to setup with typescript.nvim
        -- tsserver = function(_, opts)
        --   require("typescript").setup({ server = opts })
        --   return true
        -- end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },

    config = function(_, opts) require("lsp.lspconfig").config(opts) end,
  },

  -- lsp signature 展示
  -- 或者试试 nvim_lsp_signature_help
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    dependencies = "nvim-lspconfig",
    config = function() require("plugins.configs.others").signature() end,
  },

  -- lsp_lines 可以分层显示 lsp 弹出的行内错误
  {
    enabled = false,
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    dependencies = { "nvim-lspconfig" },
    config = function() require("plugins.configs.lsp-line").setup() end,
    event = { "BufAdd", "BufRead", "BufNewFile", "InsertEnter" },
  },

  -- lspserver 状态插件, 停用了 statuslines 中的状态。
  {
    "j-hui/fidget.nvim",
    dependencies = { "nvim-lspconfig" },
    enabled = false,
    config = function() require "plugins.configs.fidget-nvim" end,
    event = { "BufAdd", "BufRead", "BufNewFile", "InsertEnter" },
    init = function()
      -- when noice is not enabled, install notify on VeryLazy
      local Util = require "utils"
      if not Util.has "noice.nvim" then
        print "noice not found, use fidget"

        Util.on_very_lazy(function() vim.notify = require "fidget" end)
      end
    end,
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    --ft = { 'sh', 'lua', 'zsh', 'bash', 'c', 'cpp', 'cmake', 'html', 'markdown', 'vim', 'json', 'markdown', 'css',
    --  'javascript', 'javascriptreact', 'python' },
    dependencies = { "nvim-lspconfig", "mason.nvim" },
    opts = function()
      local nls = require "null-ls"
      return {
        root_dir = require("null-ls.utils").root_pattern(
          ".null-ls-root",
          ".neoconf.json",
          "Makefile",
          ".git",
          "go.mod"
        ),
        sources = {
          nls.builtins.formatting.fish_indent,
          nls.builtins.diagnostics.fish,
          nls.builtins.diagnostics.zsh,
          --nls.builtins.formatting.stylua,
          nls.builtins.formatting.shfmt,
        },
      }
    end,
    --config = function()
    --  require("lsp.null-ls")
    --end,
    enabled = true,
  },

  -- use {"dstein64/vim-startuptime"}
  -- Icons
  {
    "nvim-tree/nvim-web-devicons",
    --name = "nvim-web-devicons",
    --after = "base46",
    config = function() require "plugins.configs.icons" end,
    lazy = true,
  },

  -- ui components
  {
    "MunifTanjim/nui.nvim",
    lazy = true
  },

  -- Notification Enhancer
  {
    "rcarriga/nvim-notify",
    config = function() require("plugins.configs.nvim-notify").config() end,
    --event = "VeryLazy",
    enabled = false,
    init = function()
      -- when noice is not enabled, install notify on VeryLazy
      local Util = require "utils"
      if not Util.has "noice.nvim" then
        print "noice not found, use notify"
        Util.on_very_lazy(function() vim.notify = require "notify" end)
      end
    end,
  },

  -- noicer ui
  -- 关闭了fidget和notify, 如果手动关闭noice，记得打开fidget和notify
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    enabled = true,
    config = function() require "plugins.configs.nvim-noice" end,
    keys = {
      {
        "<S-Enter>",
        function() require("noice").redirect(vim.fn.getcmdline()) end,
        mode = "c",
        desc = "Redirect Cmdline",
      },
      { "<leader>snl", function() require("noice").cmd "last" end,    desc = "Noice Last Message" },
      { "<leader>snh", function() require("noice").cmd "history" end, desc = "Noice History" },
      { "<leader>sna", function() require("noice").cmd "all" end,     desc = "Noice All" },
      --{ "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll forward", mode = { "i", "n", "s" } },
      --{ "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll backward", mode = { "i", "n", "s" } },
    },
  },

  -- Neovim UI Enhancer
  {
    "stevearc/dressing.nvim",
    lazy = true,
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load { plugins = { "dressing.nvim" } }
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load { plugins = { "dressing.nvim" } }
        return vim.ui.input(...)
      end
    end,
    config = function() require("plugins.configs.dressing").config() end,
  },

  -- Smarter Splits
  {
    "mrjones2014/smart-splits.nvim",
    module = "smart-splits",
    config = function() require "plugins.configs.smart-splits" end,
  },

  {
    -- this repo has break some base46 colors
    -- "CanKolay3499/base46",
    -- "jayden-chan/base46.nvim",
    "tinytub/base46",
    dependencies = "plenary.nvim",
    config = function() require("plugins.configs.others").base46() end,
    enabled = false,
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    --dependencies = "bufferline.nvim",
    --    run = ":CatppuccinCompile",
    config = function() require "colors.catppuccin" end,
    enabled = true,
    lazy = false,
    --event = "VeryLazy",
  },

  {
    "sainnhe/everforest",
    config = function() require("colors").init() end,
    enabled = false,
  },

  {
    "rebelot/kanagawa.nvim",
    config = function() require("colors").init() end,
    enabled = false,
  },

  --{
  --	"sainnhe/gruvbox-material",
  --	config = function()
  --		require("colors").init()
  --	end,
  --	enabled = false,
  --},

  -- automatically highlighting other uses of the word under the cursor
  {
    "rrethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      delay = 200,
      large_file_cutoff = 2000,
      large_file_overrides = {
        providers = {
          "lsp",
          --   "treesitter",
        },
      },
    },
    config = function(_, opts)
      require("illuminate").configure(opts)
      --vim.api.nvim_set_hl(0, "IlluminatedWordText", { ctermbg = "237", guibg = "#374145" })
      --vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "IlluminatedWordText" })
      --vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "IlluminatedWordText" })
      --local illuminate_bg = string.format("#%06x", vim.api.nvim_get_hl_by_name("Visual", true).background)
      --vim.api.nvim_set_hl(0, "IlluminatedWordText", { bg = illuminate_bg })
      --vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bg = illuminate_bg })
      --vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bg = illuminate_bg })
      --local ILLUMINATION = { bg = "#383D47" }
      --vim.api.nvim_set_hl(0, "IlluminatedWordText", ILLUMINATION)
      --vim.api.nvim_set_hl(0, "IlluminatedWordRead", ILLUMINATION)
      --vim.api.nvim_set_hl(0, "IlluminatedWordWrite", ILLUMINATION)
      --vim.api.nvim_set_hl(0, "@illuminate", ILLUMINATION)
      local function map(key, dir, buffer)
        vim.keymap.set(
          "n",
          key,
          function() require("illuminate")["goto_" .. dir .. "_reference"](false) end,
          { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer }
        )
      end

      map("]]", "next")
      map("[[", "prev")

      -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          local buffer = vim.api.nvim_get_current_buf()
          map("]]", "next", buffer)
          map("[[", "prev", buffer)
        end,
      })
    end,
    keys = {
      { "]]", desc = "Next Reference" },
      { "[[", desc = "Prev Reference" },
    },
    enabled = true,
  },

  {
    "rebelot/heirline.nvim",
    enabled = false,
    dependencies = { "catppuccin", "nvim-web-devicons" },
    config = function()
      --require("plugins.configs.heirline").setup()
      require "plugins.configs.heirline"
    end,
    event = "VeryLazy",
  },

  --{
  --  "nvim-lualine/lualine.nvim",
  --  event = "VeryLazy",
  --  config = function()
  --    require("plugins.configs.nvim-lualine")
  --  end,
  --},

  {
    "kdheepak/tabline.nvim",
    enabled = false,
    config = function()
      require("tabline").setup {
        -- Defaults configuration options
        enable = true,
        options = {
          -- If lualine is installed tabline will use separators configured in lualine by default.
          -- These options can be used to override those settings.
          component_separators = { "", "" },
          section_separators = { "", "" },
          max_bufferline_percent = 66, -- set to nil by default, and it uses vim.o.columns * 2/3
          show_tabs_always = true,     -- this shows tabs only when there are more than one tab or if the first tab is named
          show_devicons = true,        -- this shows devicons in buffer section
          colored = true,
          show_bufnr = false,          -- this appends [bufnr] to buffer section,
          tabline_show_last_separator = true,
          show_filename_only = true,   -- shows base filename only instead of relative path in filename
          modified_icon = "+ ",        -- change the default modified icon
          modified_italic = true,      -- set to true by default; this determines whether the filename turns italic if modified
          show_tabs_only = false,      -- this shows only tabs instead of tabs + buffers
        },
      }
      vim.cmd [[
      set guioptions-=e " Use showtabline in gui vim
      set sessionoptions+=tabpages,globals " store tabpages and globals in session
    ]]
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
        if client.server_capabilities.documentSymbolProvider then require("nvim-navic").attach(client, buffer) end
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
      }
    end,
  },

  {
    "akinsho/bufferline.nvim",
    lazy = false,
    dependencies = { "catppuccin", "nvim-web-devicons" },
    --event = "VeryLazy",
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
    end,
  },

  ---- Better buffer closing
  --{
  --  "famiu/bufdelete.nvim",
  --  module = "bufdelete",
  --  cmd = { "Bdelete", "Bwipeout" },
  --},

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    commit = vim.fn.has "nvim-0.9.0" == 0 and "057ee0f8783" or nil,
    cmd = "Telescope",
    version = false,
    dependencies = {
      {
        "nvim-telescope/telescope-media-files.nvim",
        enabled = false,
      },
    },
    config = function() require "plugins.configs.telescope" end,
  },

  -- Smooth escaping
  {
    "max397574/better-escape.nvim",
    event = "InsertCharPre",
    config = function() require("plugins.configs.others").better_escape() end,
  },

  -- auto pairs
  {
    enabled = true,
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    opts = {},
  },

  -- copilot
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    opts = {
      suggestion = { enabled = false },
      --suggestion = {
      --  enabled = true,
      --  auto_trigger = false,
      --  debounce = 75,
      --  keymap = {
      --    accept = "<M-l>",
      --    accept_word = false,
      --    accept_line = false,
      --    next = "<M-]>",
      --    prev = "<M-[>",
      --    dismiss = "<C-]>",
      --  },
      --},
      panel = { enabled = false },
    },
  },

  {
    "jackMort/ChatGPT.nvim",
    enabled = false,
    event = "VeryLazy",
    config = function() require("chatgpt").setup() end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },

  --syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    name = "nvim-treesitter",
    version = false,
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        init = function()
          -- PERF: no need to load the plugin, if we only need its queries for mini.ai
          local plugin = require("lazy.core.config").spec.plugins["nvim-treesitter"]
          local opts = require("lazy.core.plugin").values(plugin, "opts", false)
          local enabled = false
          if opts.textobjects then
            for _, mod in ipairs { "move", "select", "swap", "lsp_interop" } do
              if opts.textobjects[mod] and opts.textobjects[mod].enable then
                enabled = true
                break
              end
            end
          end
          if not enabled then require("lazy.core.loader").disable_rtp_plugin "nvim-treesitter-textobjects" end
        end,
      },
    },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSEnable", "TSDisable", "TSModuleInfo" },
    config = function() require "plugins.configs.treesitter" end,
    --run = ":TSUpdate",
    run = function() require("nvim-treesitter.install").update { with_sync = true } () end,
    --config = function ()
    --   require "plugins.configs.treesitter"
    --end
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = "nvim-treesitter",
    config = function() require("treesitter-context").setup() end,
    enabled = false,
  },

  -- Custom semantic text objects
  --{
  --  "nvim-treesitter/nvim-treesitter-textobjects",
  --  dependencies = "nvim-treesitter",
  --  --config = function ()
  --  --  require("plugins.configs.treesitter").treesitter_obj()
  --  --end,
  --  enabled = false,
  --},
  ---- Smart text objects
  --{
  --  "RRethy/nvim-treesitter-textsubjects",
  --  dependencies = "nvim-treesitter",
  --  config = function()
  --    require("plugins.configs.treesitter").textsubjects()
  --  end,
  --  enabled = false,
  --},
  ---- Text objects using hint labels
  --{
  --  "mfussenegger/nvim-ts-hint-textobject",
  --  event = "BufRead",
  --  dependencies = "nvim-treesitter",
  --  enabled = false,
  --},

  -- better text-objects
  {
    "echasnovski/mini.ai",
    enabled = true,
    event = "VeryLazy",
    dependencies = { "nvim-treesitter-textobjects" },
    opts = function()
      local ai = require "mini.ai"
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }, {}),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
        },
      }
    end,
    config = function(_, opts)
      local ai = require "mini.ai"
      ai.setup(opts)
    end,
  },

  -- buffer remove
  {
    "echasnovski/mini.bufremove",
    -- stylua: ignore
    keys = {
      { "<leader>bd", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
      { "<leader>bD", function() require("mini.bufremove").delete(0, true) end,  desc = "Delete Buffer (Force)" },
    },
  },

  {
    enabled = false,
    "echasnovski/mini.animate",
    event = "VeryLazy",
    opts = function()
      -- don't use animate when scrolling with the mouse
      local mouse_scrolled = false
      for _, scroll in ipairs { "Up", "Down" } do
        local key = "<ScrollWheel" .. scroll .. ">"
        vim.keymap.set({ "", "i" }, key, function()
          mouse_scrolled = true
          return key
        end, { expr = true })
      end

      local animate = require "mini.animate"
      return {
        resize = {
          timing = animate.gen_timing.linear { duration = 100, unit = "total" },
        },
        scroll = {
          timing = animate.gen_timing.linear { duration = 150, unit = "total" },
          subscroll = animate.gen_subscroll.equal {
            predicate = function(total_scroll)
              if mouse_scrolled then
                mouse_scrolled = false
                return false
              end
              return total_scroll > 1
            end,
          },
        },
      }
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    --after = "nvim-web-devicons",
    ft = "alpha",
    event = "VimEnter",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    --cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    config = function()
      --require("plugins.configs.nvimtree").config()
      require "plugins.configs.nvimtree"
    end,
    enabled = false,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = { "Neotree", "NeotreeLogs" },
    enabled = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      {
        --"s1n7ax/nvim-window-picker",
        "tinytub/nvim-window-picker",
        version = "v2.*",
        opts = {
          --hint = "floating-big-letter",
          statusline_winbar_picker = {
            use_winbar = "smart",
          },
          filter_rules = {
            autoselect_one = true,
            include_current_win = false,
            bo = {
              filetype = { "neo-tree", "neo-tree-popup", "notify", "quickfix" },
              buftype = { "terminal", "quickfix" },
            },
          },
          --         other_win_hl_color = "#e35e4f",
        },
        config = function(_, opts) require("window-picker").setup(opts) end,
      },
    },
    deactivate = function() vim.cmd [[Neotree close]] end,
    init = function()
      vim.g.neo_tree_remove_legacy_commands = 1
      if vim.fn.argc() == 1 then
        local stat = vim.loop.fs_stat(vim.fn.argv(0))
        if stat and stat.type == "directory" then require "neo-tree" end
      end
    end,
    opts = {
      sources = { "filesystem", "buffers", "git_status", "document_symbols" },
      open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "Outline" },
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = true,
        use_libuv_file_watcher = true,
      },
      window = {
        mappings = {
          ["<space>"] = "none",
        },
      },
      default_component_configs = {
        indent = {
          with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },
      },
    },
    config = function(_, opts)
      --require("neo-tree").setup(opts)
      require("plugins.configs.neotree").setup(opts)

      vim.api.nvim_create_autocmd("TermClose", {
        pattern = "*lazygit",
        callback = function()
          if package.loaded["neo-tree.sources.git_status"] then require("neo-tree.sources.git_status").refresh() end
        end,
      })
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    enabled = true,
    --cond = function()
    --   return vim.fn.isdirectory ".git" == 1
    --end,
    config = function() require("plugins.configs.gitsigns").config() end,
    init = function()
      -- load gitsigns only when a git file is opened
      vim.api.nvim_create_autocmd({ "BufRead" }, {
        group = vim.api.nvim_create_augroup("GitSignslazy_load", { clear = true }),
        callback = function()
          vim.fn.system("git -C " .. '"' .. vim.fn.expand "%:p:h" .. '"' .. " rev-parse")
          if vim.v.shell_error == 0 then
            vim.api.nvim_del_augroup_by_name "GitSignslazy_load"
            vim.schedule(function() require("lazy").load { plugins = "gitsigns.nvim" } end)
          end
        end,
      })
    end,
  },

  -- whichkey
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    keys = { "<leader>", '"', "'", "`", "c", "v" },
    --module = "which-key",
    config = function() require "plugins.configs.whichkey" end,
    cond = function() return not vim.g.vscode end,
  },

  -- Dashboard
  {
    "goolord/alpha-nvim",
    enabled = true,
    optional = true,
    event = "VimEnter",
    --after = "base46",
    config = function() require("plugins.configs.dashboard").setup() end,
  },
  {
    "echasnovski/mini.starter",
    --optional = false,
    opts = function(_, opts)
      local items = {
        {
          name = "Projects",
          action = "Telescope projects",
          section = string.rep(" ", 22) .. "Telescope",
        },
      }
      vim.list_extend(opts.items, items)
    end,
  },

  -- matchup 高亮显示光标所在位置对应的括号,函数等
  --{
  --  "andymass/vim-matchup",
  --  event = "CursorMoved",
  --  --opt = true,
  --  config = function()
  --    require("plugins.configs.matchup").config()
  --  end,
  --  enabled = true,
  --},

  -- surround
  {
    "echasnovski/mini.surround",
    keys = function(_, keys)
      -- Populate the keys based on the user's options
      local plugin = require("lazy.core.config").spec.plugins["mini.surround"]
      local opts = require("lazy.core.plugin").values(plugin, "opts", false)
      local mappings = {
        { opts.mappings.add,            desc = "Add surrounding",                     mode = { "n", "v" } },
        { opts.mappings.delete,         desc = "Delete surrounding" },
        { opts.mappings.find,           desc = "Find right surrounding" },
        { opts.mappings.find_left,      desc = "Find left surrounding" },
        { opts.mappings.highlight,      desc = "Highlight surrounding" },
        { opts.mappings.replace,        desc = "Replace surrounding" },
        { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
      }
      mappings = vim.tbl_filter(function(m) return m[1] and #m[1] > 0 end, mappings)
      return vim.list_extend(mappings, keys)
    end,
    opts = {
      mappings = {
        add = "gza",            -- Add surrounding in Normal and Visual modes
        delete = "gzd",         -- Delete surrounding
        find = "gzf",           -- Find surrounding (to the right)
        find_left = "gzF",      -- Find surrounding (to the left)
        highlight = "gzh",      -- Highlight surrounding
        replace = "gzr",        -- Replace surrounding
        update_n_lines = "gzn", -- Update `n_lines`
      },
    },
  },

  -- 直接跳到数字
  {
    "nacro90/numb.nvim",
    --event = "BufRead",
    config = function()
      require("numb").setup {
        show_numbers = true,    -- Enable 'number' for the window while peeking
        show_cursorline = true, -- Enable 'cursorline' for the window while peeking
      }
    end,
    enabled = true,
  },
  -- Better quickfix
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    cmd = "BqfAutoToggle",
    event = "QuickFixCmdPost",
    config = function() require "plugins.configs.nvim-bqf" end,
    enabled = true,
  },

  -- Terminal
  {
    "akinsho/toggleterm.nvim",
    --commit = commit.toggleterm,

    optional = false,
    event = "BufWinEnter",
    config = function() require "plugins.configs.toggleterm" end,
    --disable = not lvim.builtin.terminal.active,
  },

  -- Markdown preview
  {
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
    ft = "markdown",
    event = "BufRead",
  },

  -- LSP Colors
  {
    "folke/lsp-colors.nvim",
    event = "BufRead",
    enabled = true,
  },
  -- Lazygit
  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
    enabled = false,
  },
  -- Language
  -- may be i can try https://github.com/olexsmir/gopher.nvim or https://github.com/crispgm/nvim-go
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      --   "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    config = function() require "plugins.configs.go-nvim" end,
  },

  {
    "jose-elias-alvarez/typescript.nvim",
  },

  -- smooth scroll
  {
    "psliwka/vim-smoothie",
    event = "VeryLazy",
    enabled = false,
  },
  {
    "karb94/neoscroll.nvim",
    enabled = true,
    --        event = "WinScrolled",
    config = function() require("neoscroll").setup() end,
    event = "VeryLazy",
  },

  -- F 键查询增强
  {
    "ggandor/flit.nvim",
    keys = function()
      ---@type LazyKeys[]
      local ret = {}
      for _, key in ipairs { "f", "F", "t", "T" } do
        ret[#ret + 1] = { key, mode = { "n", "x", "o" }, desc = key }
      end
      return ret
    end,
    opts = { labeled_modes = "nx" },
  },
  {
    -- flit dependence
    "ggandor/leap.nvim",
    keys = {
      { "s",  mode = { "n", "x", "o" }, desc = "Leap forward to" },
      { "S",  mode = { "n", "x", "o" }, desc = "Leap backward to" },
      { "gs", mode = { "n", "x", "o" }, desc = "Leap from windows" },
    },
    config = function(_, opts)
      local leap = require "leap"
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
      leap.add_default_mappings(true)
      vim.keymap.del({ "x", "o" }, "x")
      vim.keymap.del({ "x", "o" }, "X")
    end,
  },

  {
    enabled = false,
    "unblevable/quick-scope",
    config = function() require("plugins.configs.others").quickscope() end,
  },

  -- Git
  {
    "tpope/vim-fugitive",
    event = "BufRead",
    cmd = {
      "Git",
      "Gdiff",
      "Gdiffsplit",
      "Gvdiffsplit",
      "Gwrite",
      "Gw",
    },
  },

  {
    "vim-test/vim-test",
    event = "BufRead",
    config = function()
      vim.cmd [[
              function! ToggleTermStrategy(cmd) abort
                call luaeval("require('toggleterm').exec(_A[1], _A[2])", [a:cmd, 0])
              endfunction

              let g:test#custom_strategies = {'toggleterm': function('ToggleTermStrategy')}
            ]]

      vim.g["test#strategy"] = "toggleterm"
      --vim.g["test#strategy"] = "neovim"
      --vim.g["test#strategy"] = {
      --  nearest = "neovim",
      --  file = "neovim",
      --  suite = "neovim"
      --}
      vim.g["test#neovim#term_position"] = "vert"
      vim.g["test#preserve_screen"] = 1
      vim.g["test#go#runner"] = "gotest"
      vim.g["test#go#gotest#options"] = "-v --count=1"
      vim.g["test#echo_command"] = 1
    end,
    enabled = true,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function() require("plugins.configs.others").blankline() end,
  },

  -- active indent guide and indent text objects
  {
    "echasnovski/mini.indentscope",
    version = false, -- wait till new 0.7.0 release to put it back on semver
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      -- symbol = "▏",
      symbol = "│",
      options = { try_as_border = true },
      draw = {
        delay = 50,
        animation = function() return 10 end,
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason", "notify" },
        callback = function() vim.b.miniindentscope_disable = true end,
      })
    end,
  },

  {
    "folke/trouble.nvim",
    cmd = { "Trouble", "TroubleToggle" },
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>",  desc = "Document Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
      { "<leader>xL", "<cmd>TroubleToggle loclist<cr>",               desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>",              desc = "Quickfix List (Trouble)" },
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").previous { skip_groups = true, jump = true }
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then vim.notify(err, vim.log.levels.ERROR) end
          end
        end,
        desc = "Previous trouble/quickfix item",
      },
      {
        "]q",
        function()
          if require("trouble").is_open() then
            require("trouble").next { skip_groups = true, jump = true }
          else
            local ok, err = pcall(vim.cmd.cnext)
            if not ok then vim.notify(err, vim.log.levels.ERROR) end
          end
        end,
        desc = "Next trouble/quickfix item",
      },
    },
    config = function() require "plugins.configs.nvim-trouble" end,
    enabled = true,
  },

  -- todo highlights
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    --dependencies = "nvim-lua/plenary.nvim",
    config = function() require "plugins.configs.todo-comments" end,
    -- event = 'BufWinEnter',
    enabled = true,
  },

  -- 注释工具
  {
    "numToStr/Comment.nvim",
    --keys = { "gc", "gb" },
    --config = override_req("nvim_comment", "(plugins.configs.configs.others).comment()"),
    config = function() require("plugins.configs.others").comment() end,
    enabled = false,
  },
  -- comments
  { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
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
}

return plugins
