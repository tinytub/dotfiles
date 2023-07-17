local plugins = {

  ---- Easily speed up your neovim startup time!
  "nathom/filetype.nvim",

  -- Lua functions
  "nvim-lua/plenary.nvim",

  -- lsp signature 展示
  -- 或者试试 nvim_lsp_signature_help
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    enabled = true,
    dependencies = "nvim-lspconfig",
    opts = {
      bind = true,
      doc_lines = 0,
      floating_window = true,
      fix_pos = true,
      hint_enable = false,
      hint_prefix = " ",
      hint_scheme = "String",
      hi_parameter = "Search",
      max_height = 22,
      max_width = 10,      -- max_width of signature floating_window, line will be wrapped if exceed max_width
      handler_opts = {
        border = "single", -- double, single, shadow, none
      },
      zindex = 200,        -- by default it will be on top of all floating windows, set to 50 send it to bottom
      padding = "",        -- character to pad on left and right of signature can be ' ', or '|'  etc
    },
  },

  -- Smarter Splits
  {
    "mrjones2014/smart-splits.nvim",
    module = "smart-splits",
    opts = {
      {
        ignored_filetypes = {
          "nofile",
          "quickfix",
          "qf",
          "prompt",
        },
        ignored_buftypes = { "nofile" },
      }
    }
    --    config = function() require "plugins.configs.smart-splits" end,
  },

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

  --{
  --  "rebelot/heirline.nvim",
  --  enabled = false,
  --  dependencies = { "catppuccin", "nvim-web-devicons" },
  --  config = function()
  --    --require("plugins.configs.heirline").setup()
  --    require "plugins.configs.heirline"
  --  end,
  --  event = "VeryLazy",
  --},

  --{
  --  "nvim-lualine/lualine.nvim",
  --  event = "VeryLazy",
  --  config = function()
  --    require("plugins.configs.nvim-lualine")
  --  end,
  --},


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
    enabled = false,
    event = "InsertCharPre",
    opts = {
      mapping = { "jk" },
      timeout = 300,
      clear_empty_lines = false, -- clear line after escaping if there is only whitespace
      keys = "<Esc>",
    },
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
    cmd = { "TSUpdateSync" },
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        init = function()
          -- disable rtp plugin, as we only need its queries for mini.ai
          -- In case other textobject modules are enabled, we will load them
          -- once nvim-treesitter is loaded
          require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
          load_textobjects = true
        end,
      },
    },
    keys = {
      { "<c-space>", desc = "Increment selection" },
      { "<bs>",      desc = "Decrement selection", mode = "x" },
    },
    ---@type TSConfig
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {
        "bash",
        "c",
        "css",
        "cpp",
        "html",
        "javascript",
        "typescript",
        "json",
        "jsonc",
        "jsdoc",
        "java",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
        "toml",
        "rust",
        "vue",
        "bash",
        "go",
        "gomod",
        "gowork",
        "gosum",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    },
    ---@param opts TSConfig
    config = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        ---@type table<string, boolean>
        local added = {}
        opts.ensure_installed = vim.tbl_filter(function(lang)
          if added[lang] then
            return false
          end
          added[lang] = true
          return true
        end, opts.ensure_installed)
      end
      require("nvim-treesitter.configs").setup(opts)

      if load_textobjects then
        -- PERF: no need to load the plugin, if we only need its queries for mini.ai
        if opts.textobjects then
          for _, mod in ipairs({ "move", "select", "swap", "lsp_interop" }) do
            if opts.textobjects[mod] and opts.textobjects[mod].enable then
              local Loader = require("lazy.core.loader")
              Loader.disabled_rtp_plugins["nvim-treesitter-textobjects"] = nil
              local plugin = require("lazy.core.config").plugins["nvim-treesitter-textobjects"]
              require("lazy.core.loader").source_runtime(plugin.dir, "plugin")
              break
            end
          end
        end
      end
    end,
    ----    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSEnable", "TSDisable", "TSModuleInfo" },
    --config = function() require "plugins.configs.treesitter" end,
    ----run = ":TSUpdate",
    --run = function() require("nvim-treesitter.install").update { with_sync = true } () end,
    ----config = function ()
    ----   require "plugins.configs.treesitter"
    ----end
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
      require("mini.ai").setup(opts)
      -- register all text objects with which-key
      require("utils").on_load("which-key.nvim", function()
        ---@type table<string, string|table>
        local i = {
          [" "] = "Whitespace",
          ['"'] = 'Balanced "',
          ["'"] = "Balanced '",
          ["`"] = "Balanced `",
          ["("] = "Balanced (",
          [")"] = "Balanced ) including white-space",
          [">"] = "Balanced > including white-space",
          ["<lt>"] = "Balanced <",
          ["]"] = "Balanced ] including white-space",
          ["["] = "Balanced [",
          ["}"] = "Balanced } including white-space",
          ["{"] = "Balanced {",
          ["?"] = "User Prompt",
          _ = "Underscore",
          a = "Argument",
          b = "Balanced ), ], }",
          c = "Class",
          f = "Function",
          o = "Block, conditional, loop",
          q = "Quote `, \", '",
          t = "Tag",
        }
        local a = vim.deepcopy(i)
        for k, v in pairs(a) do
          a[k] = v:gsub(" including.*", "")
        end
        local ic = vim.deepcopy(i)
        local ac = vim.deepcopy(a)
        for key, name in pairs({ n = "Next", l = "Last" }) do
          i[key] = vim.tbl_extend("force", { name = "Inside " .. name .. " textobject" }, ic)
          a[key] = vim.tbl_extend("force", { name = "Around " .. name .. " textobject" }, ac)
        end
        require("which-key").register({
          mode = { "o", "x" },
          i = i,
          a = a,
        })
      end)
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
        "s1n7ax/nvim-window-picker",
        --"tinytub/nvim-window-picker",
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
              filetype = { "neo-tree", "neo-tree-popup", "notify", "quickfix", "edgy" },
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
      if vim.fn.argc() == 1 then
        local stat = vim.loop.fs_stat(vim.fn.argv(0))
        if stat and stat.type == "directory" then require "neo-tree" end
      end
    end,
    opts = {
      sources = { "filesystem", "buffers", "git_status", "document_symbols" },
      --source_selector = {
      --  winbar = true,
      --  content_layout = "center",
      --},
      open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "Outline" },
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
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
  -- disable old installations of leap and flit. Optional so it doesn't appear under disabled plugins
  {
    "ggandor/leap.nvim",
    enabled = function()
      vim.schedule(function()
        local Config = require("lazy.core.config")
        if Config.spec.disabled["leap.nvim"] or Config.spec.disabled["flit.nvim"] then
          require("lazy.core.util").warn(
            [[`flash.nvim` is now the default **LazyVim** jump plugin.
**leap.nvim** and **flit.nvim** have been disabled.
Please remove the plugins from your config.
If you rather use leap/flit instead, you can add the leap extra:
`lazyvim.plugins.extras.editor.leap`
]],
            { title = "LazyVim" }
          )
        end
      end)
      return false
    end,
    optional = true,
  },
  { "ggandor/flit.nvim",                           enabled = false, optional = true },

  -- Add Flash
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    vscode = true,
    ---@type Flash.Config
    opts = {
      search = {
        -- search/jump in all windows
        multi_window = false,
        -- search direction
        forward = true,
        warp = false,
      },
      modes = {
        -- treesitter = {
        --   label = {
        --     rainbow = { enabled = true },
        --   },
        -- },
        char = {
          jump_labels = false
        },
        treesitter_search = {
          label = {
            rainbow = { enabled = true },
          }
        }
      }
    },
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash" },
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o",               function() require("flash").remote() end,     desc = "Remote Flash" },
      {
        "R",
        mode = { "o", "x" },
        function() require("flash").treesitter_search() end,
        desc =
        "Treesitter Search"
      },
      {
        "<c-s>",
        mode = { "c" },
        function() require("flash").toggle() end,
        desc =
        "Toggle Flash Search"
      },
    },
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


  -- 注释工具
  {
    "numToStr/Comment.nvim",
    --keys = { "gc", "gb" },
    --config = override_req("nvim_comment", "(plugins.configs.configs.others).comment()"),
    opts = {
      padding = true, -- Add a space b/w comment and the line
      sticky = true,  -- Whether the cursor should stay at its position

      -- We define all mappings manually to support neovim < 0.7
      mappings = {
        basic = false,    -- Includes `gcc`, `gbc`, `gc[count]{motion}` and `gb[count]{motion}`
        extra = false,    -- Includes `gco`, `gcO`, `gcA`
        extended = false, -- Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
      },

    },
    --config = function()
    --  require("plugins.configs.others").comment()
    --end,
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
