local plugins = {
  -- Optimiser
  -- Speed up deffered plugins
  --{ "lewis6991/impatient.nvim" },

  ---- Easily speed up your neovim startup time!
  "nathom/filetype.nvim",

  -- Lua functions
  "nvim-lua/plenary.nvim",

  -- Package Manager
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
    config = function()
      require "plugins.mason"
    end,
    enabled = true,
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = { "b0o/SchemaStore.nvim" }, -- Get extra JSON schemas -- 虽然不知道干嘛用,但是先留着吧, jsonls
    init = function()
      require("core.lazy_load").lazy_load("nvim-lspconfig")
    end,
    config = function()
      require("lsp.lspconfig")
    end,
  },

  -- lsp signature 展示
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    dependencies = "nvim-lspconfig",
    config = function()
      require("plugins.others").signature()
    end,
  },

  -- lsp_lines 可以分层显示 lsp 弹出的行内错误
  {
    enabled = true,
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    dependencies = { "nvim-lspconfig" },
    config = function()
      require("plugins.lsp-line").setup()
    end,
    event = { "BufAdd", "BufRead", "BufNewFile", "InsertEnter" },
  },


  -- lspserver 状态插件, 停用了 statuslines 中的状态。
  {
    "j-hui/fidget.nvim",
    dependencies = { "nvim-lspconfig" },
    enabled = true,
    config = function()
      require("plugins.fidget-nvim")
    end,
    event = { "BufAdd", "BufRead", "BufNewFile", "InsertEnter" },
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    --ft = { 'sh', 'lua', 'zsh', 'bash', 'c', 'cpp', 'cmake', 'html', 'markdown', 'vim', 'json', 'markdown', 'css',
    --  'javascript', 'javascriptreact', 'python' },
    dependencies = { "nvim-lspconfig" },
    config = function()
      require("lsp.null-ls")
    end,
    enabled = true,
  },

  -- use {"dstein64/vim-startuptime"}
  -- Icons
  {
    "kyazdani42/nvim-web-devicons",
    --name = "nvim-web-devicons",
    --after = "base46",
    config = function()
      require("plugins.icons")
    end,
    lazy = false,

  },

  -- Notification Enhancer
  {
    "rcarriga/nvim-notify",
    config = function()
      require("plugins.nvim-notify").config()
    end,
    enabled = true,
  },

  {
    "folke/noice.nvim",
    --event = "VimEnter",
    event = "VeryLazy",
    enabled = false,
    config = function()
      --require("plugins.nvim-notify").config()
      require("plugins.nvim-noice")
      --require("plugins.nvim-noice")
    end,
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    }
  },

  -- Neovim UI Enhancer
  {
    "stevearc/dressing.nvim",
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
      require("plugins.dressing").config()
    end,
  },

  -- Smarter Splits
  {
    "mrjones2014/smart-splits.nvim",
    module = "smart-splits",
    config = function()
      require("plugins.smart-splits")
    end
  },

  {
    -- this repo has break some base46 colors
    -- "CanKolay3499/base46",
    -- "jayden-chan/base46.nvim",
    "tinytub/base46",
    dependencies = "plenary.nvim",
    config = function()
      require("plugins.others").base46()
    end,
    enabled = false,
  },

  {
    "catppuccin/nvim",
    name    = "catppuccin",
    --dependencies = "bufferline.nvim",
    --    run = ":CatppuccinCompile",
    config  = function()
      require "colors".setup()
    end,
    enabled = true,
    lazy    = false,
    --event = "VeryLazy",
  },

  {
    "sainnhe/everforest",
    config = function()
      require("colors").init()
    end,
    enabled = false,
  },

  {
    "rebelot/kanagawa.nvim",
    config = function()
      require("colors").init()
    end,
    enabled = false,
  },

  {
    "sainnhe/gruvbox-material",
    config = function()
      --require "highlights"
      require("colors").init()
    end,
    enabled = false,
  },


  -- automatically highlighting other uses of the word under the cursor
  {
    "rrethy/vim-illuminate",
    event = "BufReadPost",
    opts = {
      delay = 200,
      providers = {
        "lsp",
        "treesitter",
      },
    },
    config = function(_, opts)
      require("illuminate").configure(opts)
    end,
    enabled = false,
  },


  -- Statusline
  -- try https://github.com/nvim-lualine/lualine.nvim ?
  --{
  --  "feline-nvim/feline.nvim",
  --  enabled = false,
  --  dependencies = { "nvim-web-devicons", "catppuccin" },
  --  config = function()
  --    --require("plugins.statusline")
  --    require("plugins.feline")
  --  end,
  --},

  {
    -- 会导致查询闪屏,看看是为什么
    "rebelot/heirline.nvim",
    enabled = true,
    dependencies = { "catppuccin", "nvim-web-devicons" },
    config = function()
      --require("plugins.heirline").setup()
      require("plugins.heirline")
    end,
    event = "VeryLazy",
  },


  {
    'nvim-lualine/lualine.nvim',
    dependencies = { "nvim-web-devicons" },
    config = function()
      require("plugins.lualine")
    end,
    enabled = false,
  },

  -- Simple statusline component that shows what scope you are working inside
  {
    "SmiteshP/nvim-navic",
    --event = "CursorMoved",
    config = function()
      require("plugins.navic")
    end,
    enabled = true,
  },

  {
    "akinsho/bufferline.nvim",
    dependencies = { "catppuccin", "nvim-web-devicons" },
    --tag = "v2.*",
    --init = function()
    --  require("core.lazy_load").lazy_load("bufferline.nvim")
    --end,
    event = "VeryLazy",
    config = function()
      require("plugins.bufferline")
    end,
  },

  -- Better buffer closing
  {
    "famiu/bufdelete.nvim",
    module = "bufdelete",
    cmd = { "Bdelete", "Bwipeout" },
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false,
    dependencies = {
      {
        "nvim-telescope/telescope-media-files.nvim",
        enabled = false,
      },
    },
    config = function()
      require("plugins.telescope")
    end,
  },

  -- Smooth escaping
  {
    "max397574/better-escape.nvim",
    event = "InsertCharPre",
    config = function()
      require("plugins.others").better_escape()
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      {
        -- snippet plugin
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        config = function()
          require("plugins.others").luasnip()
        end,
      },

      -- autopairing of (){}[] etc
      {
        "windwp/nvim-autopairs",
        config = function()
          require("plugins.autopairs")
        end,
      },

      -- cmp sources plugins
      {
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
      },
    },
    config = function()
      require "plugins.nvim-cmp"
    end,
  },



  --syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    name = "nvim-treesitter",
    event = "BufReadPost",
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSEnable", "TSDisable", "TSModuleInfo" },
    init = function()
      require("core.lazy_load").lazy_load("nvim-treesitter")
    end,
    config = function()
      require("plugins.treesitter")
    end,
    --run = ":TSUpdate",
    run = function() require("nvim-treesitter.install").update { with_sync = true } () end,
    --config = function ()
    --   require "plugins.treesitter"
    --end
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = "nvim-treesitter",
    config = function()
      require("treesitter-context").setup()
    end,
    enabled = false,
  },

  -- Custom semantic text objects
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = "nvim-treesitter",
    --config = function ()
    --  require("plugins.treesitter").treesitter_obj()
    --end,
    enabled = true,
  },
  -- Smart text objects
  {
    "RRethy/nvim-treesitter-textsubjects",
    dependencies = "nvim-treesitter",
    config = function()
      require("plugins.treesitter").textsubjects()
    end,
    enabled = true,
  },
  -- Text objects using hint labels
  {
    "mfussenegger/nvim-ts-hint-textobject",
    event = "BufRead",
    dependencies = "nvim-treesitter",
    enabled = true,
  },

  {
    "kyazdani42/nvim-tree.lua",
    --after = "nvim-web-devicons",
    ft = "alpha",
    event = "VimEnter",

    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    --cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    config = function()
      --require("plugins.nvimtree").config()
      require("plugins.nvimtree")
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    ft = "gitcommit",
    event = "BufReadPre",
    enabled = true,
    --cond = function()
    --   return vim.fn.isdirectory ".git" == 1
    --end,
    config = function()
      require("plugins.gitsigns").config()
    end,
    init = function()
      -- load gitsigns only when a git file is opened
      vim.api.nvim_create_autocmd({ "BufRead" }, {
        group = vim.api.nvim_create_augroup("GitSignslazy_load", { clear = true }),
        callback = function()
          vim.fn.system("git -C " .. vim.fn.expand "%:p:h" .. " rev-parse")
          if vim.v.shell_error == 0 then
            vim.api.nvim_del_augroup_by_name "GitSignslazy_load"
            vim.schedule(function()
              require("lazy").load { plugins = "gitsigns.nvim" }
            end)
          end
        end,
      })
    end,
  },

  -- whichkey
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    keys = { "<leader>", '"', "'", "`" },
    --module = "which-key",
    config = function()
      require("plugins.whichkey")
    end,
    cond = function()
      return not vim.g.vscode
    end,
  },

  ---- autopairs
  --{
  --  "windwp/nvim-autopairs",
  --  -- after = {"nvim-compe", "nvim-treesitter"},
  --  after = "nvim-cmp",
  --  config = function()
  --    require("plugins.others").autopairs()
  --  end,
  --  enabled = true,
  --},

  -- Dashboard
  {
    "goolord/alpha-nvim",
    enabled = true,
    event = "VimEnter",
    --after = "base46",
    config = function()
      require("plugins.dashboard").setup()
    end,
  },

  -- matchup 高亮显示光标所在位置对应的括号,函数等
  {
    "andymass/vim-matchup",
    event = "CursorMoved",
    --opt = true,
    config = function()
      require("plugins.matchup").config()
    end,
    enabled = true,
  },

  {
    --"norcalli/nvim-colorizer.lua",
    "NvChad/nvim-colorizer.lua",
    init = function()
      require("core.lazy_load").lazy_load("nvim-colorizer.lua")
    end,
    config = function()
      require("plugins.others").colorizer()
    end,
    enabled = true,
  },

  -- 直接跳到数字
  {
    "nacro90/numb.nvim",
    --event = "BufRead",
    config = function()
      require("numb").setup({
        show_numbers = true, -- Enable 'number' for the window while peeking
        show_cursorline = true, -- Enable 'cursorline' for the window while peeking
      })
    end,
    enabled = true,
  },
  -- Better quickfix
  {
    "kevinhwang91/nvim-bqf",
    event = "BufRead",
    config = function()
      require("plugins.nvim-bqf")
    end,
    enabled = true,
  },

  -- Terminal
  {
    "akinsho/toggleterm.nvim",
    --commit = commit.toggleterm,
    event = "BufWinEnter",
    config = function()
      require("plugins.toggleterm")
    end,
    --disable = not lvim.builtin.terminal.active,
  },

  -- Markdown preview
  {
    "iamcco/markdown-preview.nvim",
    run = function()
      vim.fn["mkdp#util#install"]()
    end,
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
    ft = { "go", "golang" },
    config = function()
      require("plugins.go-nvim")
    end,
  },

  -- smooth scroll
  {
    "psliwka/vim-smoothie",
    event = "VeryLazy",
  },
  {
    "karb94/neoscroll.nvim",
    --        event = "WinScrolled",
    config = function()
      require("neoscroll").setup()
    end,
    event = "VeryLazy",
  },

  -- F 键查询增强
  {
    "unblevable/quick-scope",
    config = function()
      require("plugins.others").quickscope()
    end,
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
      vim.cmd([[
              function! ToggleTermStrategy(cmd) abort
                call luaeval("require('toggleterm').exec(_A[1], _A[2])", [a:cmd, 0])
              endfunction

              let g:test#custom_strategies = {'toggleterm': function('ToggleTermStrategy')}
            ]])

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
    'nvim-neotest/neotest',
    enabled = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      --'nvim-treesitter/nvim-treesitter',
      --'antoinemadec/FixCursorHold.nvim',
      "rcarriga/neotest-plenary",

      'akinsho/neotest-go',
    },
    config = function()
      require("plugins.neotest")
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    config = function()
      require("plugins.others").blankline()
    end,
  },

  {
    "folke/trouble.nvim",
    cmd = { "Trouble", "TroubleToggle" },
    config = function()
      require("plugins.nvim-trouble")
    end,
    enabled = true,
  },

  -- todo highlights
  {
    "folke/todo-comments.nvim",
    event = "BufReadPost",
    --dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("plugins.todo-comments")
    end,
    -- event = 'BufWinEnter',
    enabled = true,
  },

  -- 注释工具
  {
    "numToStr/Comment.nvim",
    --keys = { "gc", "gb" },
    --config = override_req("nvim_comment", "(plugins.configs.others).comment()"),
    config = function()
      require("plugins.others").comment()
    end,
  },
}

-- load lazy.nvim options
local lazy_config = require "plugins.lazy_nvim"
--lazy_config = require("core.utils").load_override(lazy_config, "folke/lazy.nvim")

require("lazy").setup(plugins, lazy_config)