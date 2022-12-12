--local present, packer = pcall(require, "packerInit")
local use, packer = require("core.packerInit").getPacker()
if not packer or not use then
  return
end
--local use = packer.use

return packer.startup(function()

  -- Plugin manager
  use({ "wbthomason/packer.nvim",
    --cmd = require("core.lazy_load").packer_cmds,
  })

  -- Optimiser
  -- Speed up deffered plugins
  use({ "lewis6991/impatient.nvim" })

  -- Easily speed up your neovim startup time!
  use("nathom/filetype.nvim")

  -- Lua functions
  use("nvim-lua/plenary.nvim")

  -- Package Manager
  use({
    "williamboman/mason.nvim",
    --    opt = true,
    --cmd = require("core.lazy_load").mason_cmds,
    config = function()
      require "plugins.mason"
    end,
    disable = false,
  })

  use({
    opt = true,
    "neovim/nvim-lspconfig",
    setup = function()
      require("core.lazy_load").on_file_open "nvim-lspconfig"
    end,
    config = function()
      require("lsp.lspconfig")
    end,
  })

  -- lsp signature 展示
  --use({
  --  "ray-x/lsp_signature.nvim",
  --  after = "nvim-lspconfig",
  --  disable = true,
  --  config = function()
  --    require("plugins.others").signature()
  --  end,
  --})

  -- lsp_lines 可以分层显示 lsp 弹出的行内错误
  use({
    disable = true,
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    after = { "nvim-lspconfig" },
    config = function()
      require("plugins.lsp-line").setup()
    end,
  })


  -- lspserver 状态插件, 停用了 statuslines 中的状态。
  use({
    "j-hui/fidget.nvim",
    after = { "nvim-lspconfig" },
    config = function()
      require("plugins.fidget-nvim")
    end,
    event = { "BufAdd", "BufRead", "BufNewFile", "InsertEnter" },
  })

  use({
    "jose-elias-alvarez/null-ls.nvim",
    --ft = { 'sh', 'lua', 'zsh', 'bash', 'c', 'cpp', 'cmake', 'html', 'markdown', 'vim', 'json', 'markdown', 'css',
    --  'javascript', 'javascriptreact', 'python' },
    after = { "nvim-lspconfig" },
    config = function()
      require("lsp.null-ls")
    end,
    disable = false,
  })

  -- use {"dstein64/vim-startuptime"}
  -- Icons
  use({
    "kyazdani42/nvim-web-devicons",
    --module = "nvim-web-devicons",
    --after = "base46",
    config = function()
      require("plugins.icons")
    end,
  })

  -- Notification Enhancer
  use({
    "rcarriga/nvim-notify",
    config = function()
      require("plugins.nvim-notify").config()
    end,
    disable = false,
  })

  --use({
  --  "folke/noice.nvim",
  --  event = "VimEnter",
  --  config = function()
  --    require("plugins.nvim-notify").config()
  --    require("plugins.nvim-noice").config()
  --    --require("plugins.nvim-noice")
  --  end,
  --  requires = {
  --    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
  --    "MunifTanjim/nui.nvim",
  --    "rcarriga/nvim-notify",
  --  }
  --})

  -- Neovim UI Enhancer
  use({
    "stevearc/dressing.nvim",
    event = "BufWinEnter",
    config = function()
      require("plugins.dressing").config()
    end,
  })

  -- Smarter Splits
  use({
    "mrjones2014/smart-splits.nvim",
    module = "smart-splits",
    config = function()
      require("plugins.smart-splits")
    end
  })

  use({
    -- this repo has break some base46 colors
    -- "CanKolay3499/base46",
    -- "jayden-chan/base46.nvim",
    "tinytub/base46",
    after = "plenary.nvim",
    config = function()
      require("plugins.others").base46()
    end,
    disable = true,
  })

  use {
    "catppuccin/nvim",
    as = "catppuccin",
    after = "bufferline.nvim",
    --    run = ":CatppuccinCompile",
    config = function()
      require "colors".setup()
    end,
    disable = false,
  }

  use({
    "sainnhe/everforest",
    config = function()
      require("colors").init()
    end,
    disable = true,
  })

  use({
    "rebelot/kanagawa.nvim",
    config = function()
      require("colors").init()
    end,
    disable = true,
  })

  use({
    "sainnhe/gruvbox-material",
    config = function()
      --require "highlights"
      require("colors").init()
    end,
    disable = true,
  })

  --    use {
  --        "ellisonleao/gruvbox.nvim",
  --        requires = {"rktjmp/lush.nvim"},
  --        config = function ()
  --            vim.o.background = "dark" -- or "light" for light mode
  --            vim.cmd([[colorscheme gruvbox]])
  --            require("colors").init()
  --        end
  --    }
  --
  --    use({
  --        'rose-pine/neovim',
  --        as = 'rose-pine',
  --        config = function()
  --            -- Options (see available options below)
  --            vim.g.rose_pine_variant = 'base'
  --            -- Load colorscheme after options
  --            vim.cmd('colorscheme rose-pine')
  --        end
  --    })
  --
  --    use {
  --        'folke/tokyonight.nvim',
  --        config = function ()
  --            vim.g.tokyonight_style = "storm"
  --            vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }
  --
  --            vim.cmd([[
  --                colorscheme tokyonight
  --            ]])
  --        end
  --    }
  --
  --    use {
  --        "NvChad/nvim-base16.lua",
  --        disable = true,
  --        config = function ()
  --           require("colors").init("tomorrow-night")
  --        end
  --    }

  -- automatically highlighting other uses of the word under the cursor
  use({
    "rrethy/vim-illuminate",
    disable = true,
  })


  -- Statusline
  -- try https://github.com/nvim-lualine/lualine.nvim ?
  use({
    "feline-nvim/feline.nvim",
    disable = true,
    after = { "nvim-web-devicons", "catppuccin" },
    config = function()
      --require("plugins.statusline")
      require("plugins.feline")
    end,
  })

  use({
    -- 会导致查询闪屏,看看是为什么
    "rebelot/heirline.nvim",
    disable = false,
    after = { "nvim-web-devicons", "catppuccin" },
    config = function()
      --require("plugins.heirline").setup()
      require("plugins.heirline")
    end
  })


  use({
    'nvim-lualine/lualine.nvim',
    after = { "nvim-web-devicons" },
    config = function()
      require("plugins.lualine")
    end,
    disable = true,
  })

  -- Simple statusline component that shows what scope you are working inside
  use {
    "SmiteshP/nvim-navic",
    --event = "CursorMoved",
    config = function()
      require("plugins.navic")
    end,
    disable = false,
  }

  use({
    "akinsho/bufferline.nvim",
    tag = "v2.*",
    setup = function()
      require("core.lazy_load").bufferline()
    end,
    config = function()
      require("plugins.bufferline")
    end,
    disable = false,
  })

  -- Better buffer closing
  use({
    "famiu/bufdelete.nvim",
    module = "bufdelete",
    cmd = { "Bdelete", "Bwipeout" },
  })

  -- Telescope
  use({
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    requires = {
      {
        "nvim-telescope/telescope-media-files.nvim",
        disable = true,
      },
    },
    config = function()
      require("plugins.telescope")
    end,
  })

  -- Smooth escaping
  use({
    "max397574/better-escape.nvim",
    event = "InsertCharPre",
    config = function()
      require("plugins.others").better_escape()
    end,
  })

  -- Get extra JSON schemas -- 虽然不知道干嘛用,但是先留着吧, jsonls
  use({
    "b0o/SchemaStore.nvim",
    module = "schemastore",
  })

  use({
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    --       commit = "30ed4e43a6fcb65b5816c578c78e3df3d87e6b1f",
    after = "friendly-snippets",
    config = function()
      require("plugins.cmp")
    end,
  })

  -- Snippet engine
  use({
    "L3MON4D3/LuaSnip",
    wants = "friendly-snippets",
    after = { "nvim-cmp", "nvim-treesitter" },
    config = function()
      require("plugins.others").luasnip()
      --require "plugins.luasnips"
    end,
  })
  -- load luasnips + cmp related in insert mode only
  use({
    "rafamadriz/friendly-snippets",
    module = { "cmp", "cmp_nvim_lsp" },
    event = "InsertEnter",
  })



  use({ "saadparwaiz1/cmp_luasnip", after = "LuaSnip" })

  use({ "hrsh7th/cmp-nvim-lua", after = "cmp_luasnip" })

  use({ "hrsh7th/cmp-nvim-lsp", after = "cmp-nvim-lua" })

  use({ "hrsh7th/cmp-buffer", after = "cmp-nvim-lsp" })

  use({ "hrsh7th/cmp-path", after = "cmp-buffer" })

  -- Syntax highlighting
  use({
    "nvim-treesitter/nvim-treesitter",
    module = "nvim-treesitter",
    cmd = { "TSInstall", "TSUninstall" },
    setup = function()
      require("core.lazy_load").treesitter()
    end,
    config = function()
      require("plugins.treesitter").treesitter()
    end,
    --run = ":TSUpdate",
    run = function() require("nvim-treesitter.install").update { with_sync = true } () end,
    --config = function ()
    --   require "plugins.treesitter"
    --end
  })
  use({
    "nvim-treesitter/nvim-treesitter-context",
    after = "nvim-treesitter",
    config = function()
      require("treesitter-context").setup()
    end,
    disable = true,
  })

  -- Treesitter playground
  use({
    "nvim-treesitter/playground",
    event = "BufRead",
    after = "nvim-treesitter",
    disable = false,
  })

  -- Custom semantic text objects
  use({
    "nvim-treesitter/nvim-treesitter-textobjects",
    after = "nvim-treesitter",
    --config = function ()
    --  require("plugins.treesitter").treesitter_obj()
    --end,
    disable = false,
  })
  -- Smart text objects
  use({
    "RRethy/nvim-treesitter-textsubjects",
    after = "nvim-treesitter",
    config = function()
      require("plugins.treesitter").textsubjects()
    end,
    disable = false,
  })
  -- Text objects using hint labels
  use({
    "mfussenegger/nvim-ts-hint-textobject",
    event = "BufRead",
    after = "nvim-treesitter",
    disable = false,
  })

  use({
    "kyazdani42/nvim-tree.lua",
    --after = "nvim-web-devicons",
    ft = "alpha",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    --cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    config = function()
      --require("plugins.nvimtree").config()
      require("plugins.nvimtree")
    end,
  })

  use({
    "lewis6991/gitsigns.nvim",
    ft = "gitcommit",
    disable = false,
    --cond = function()
    --   return vim.fn.isdirectory ".git" == 1
    --end,
    config = function()
      require("plugins.gitsigns").config()
    end,
    setup = function()
      require("core.lazy_load").gitsigns()
    end,
  })

  -- whichkey
  use({
    "folke/which-key.nvim",
    keys = { "<leader>", '"', "'", "`" },
    --module = "which-key",
    config = function()
      require("plugins.whichkey")
    end,
    cond = function()
      return not vim.g.vscode
    end,
  })

  ---- autopairs
  use({
    "windwp/nvim-autopairs",
    -- after = {"nvim-compe", "nvim-treesitter"},
    after = "nvim-cmp",
    config = function()
      require("plugins.others").autopairs()
    end,
    disable = false,
  })

  -- Dashboard
  use({
    "goolord/alpha-nvim",
    disable = false,
    --after = "base46",
    config = function()
      require("plugins.dashboard").setup()
    end,
  })

  -- matchup 高亮显示光标所在位置对应的括号,函数等
  use({
    "andymass/vim-matchup",
    event = "CursorMoved",
    --opt = true,
    config = function()
      require("plugins.matchup").config()
    end,
    disable = false,
  })

  use({
    --"norcalli/nvim-colorizer.lua",
    "NvChad/nvim-colorizer.lua",
    opt = true,
    setup = function()
      require("core.lazy_load").on_file_open("nvim-colorizer.lua")
    end,
    config = function()
      require("plugins.others").colorizer()
    end,
    disable = false,
  })

  -- 直接跳到数字
  use({
    "nacro90/numb.nvim",
    event = "BufRead",
    config = function()
      require("numb").setup({
        show_numbers = true, -- Enable 'number' for the window while peeking
        show_cursorline = true, -- Enable 'cursorline' for the window while peeking
      })
    end,
    disable = false,
  })

  -- Debugging
  -- DAP
  --use({
  --  { 'mfussenegger/nvim-dap',
  --    event = "BufRead",
  --    config = function()
  --      require('plugins.dap')
  --    end,
  --    keys = { '<F5>', '<F8>', '<F9>' }
  --  },
  --  { 'rcarriga/nvim-dap-ui',
  --    config = function()
  --      require('plugins.dap.ui')
  --    end,
  --    after = { 'nvim-dap' }
  --  },
  --  { 'jbyuki/one-small-step-for-vimkind',
  --    after = { 'nvim-dap' }
  --  }
  --})

  -- dap 很遗憾,不会用
  -- use({
  --   "mfussenegger/nvim-dap",
  --   config = function()
  --     -- require "dap"
  --     require("plugins.dap")

  --     require("dap-go").setup()
  --   end,
  --   requires = {
  --     "leoluz/nvim-dap-go",
  --   },

  --   disable = false,
  -- })

  -- use({
  --   after = "nvim-dap",
  --   "rcarriga/nvim-dap-ui",
  --   config = function()
  --     require('plugins.dap.ui')
  --     --require("dapui").setup()
  --     --require('dap.ext.vscode').load_launchjs()
  --   end,
  --   disable = false,
  -- })

  -- Better quickfix
  use {
    "kevinhwang91/nvim-bqf",
    event = "BufRead",
    config = function()
      require("plugins.nvim-bqf")
    end,
    disable = false,
  }

  -- Terminal
  use({
    "akinsho/toggleterm.nvim",
    --commit = commit.toggleterm,
    event = "BufWinEnter",
    config = function()
      require("plugins.toggleterm").config()
    end,
    --disable = not lvim.builtin.terminal.active,
  })

  -- Markdown preview
  use({
    "iamcco/markdown-preview.nvim",
    run = function()
      vim.fn["mkdp#util#install"]()
    end,
    ft = "markdown",
    event = "BufRead",
  })

  -- LSP Colors
  use({
    "folke/lsp-colors.nvim",
    event = "BufRead",
    disable = false,
  })
  -- Lazygit
  use({
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
    disable = true,
  })
  -- Language
  -- may be i can try https://github.com/olexsmir/gopher.nvim or https://github.com/crispgm/nvim-go
  use({
    disable = false,
    "ray-x/go.nvim",
    ft = { "go", "golang" },
    config = function()
      require("plugins.go-nvim")
    end,
  })

  -- smooth scroll
  use({ "psliwka/vim-smoothie" })
  use({
    "karb94/neoscroll.nvim",
    opt = true,
    --        event = "WinScrolled",
    config = function()
      require("neoscroll").setup()
    end,
  })

  -- F 键查询增强
  use({
    "unblevable/quick-scope",
    config = function()
      require("plugins.others").quickscope()
    end,
  })

  -- Git
  use({
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
  })

  use({
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
    disable = false,
  })

  use {
    'nvim-neotest/neotest',
    disable = true,
    requires = {
      'nvim-lua/plenary.nvim',
      --'nvim-treesitter/nvim-treesitter',
      --'antoinemadec/FixCursorHold.nvim',
      "rcarriga/neotest-plenary",

      'akinsho/neotest-go',
    },
    config = function()
      require("plugins.neotest")
    end,
  }

  use({
    "lukas-reineke/indent-blankline.nvim",
    opt = false,
    disable = false,
    config = function()
      require("plugins.others").blankline()
    end,
  })

  use({
    "folke/trouble.nvim",
    cmd = { "Trouble", "TroubleToggle" },
    config = function()
      require("trouble").setup({
        use_diagnostic_signs = true,
        --position = 'right',
        height = 7,
        group = true,
        padding = true,
        auto_close = true,

        auto_preview = true,
      })
    end,
    disable = false,
  })

  -- todo highlights
  use({
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("plugins.todo-comments")
    end,
    --event = 'BufWinEnter',
    disable = false,
  })

  -- 注释工具
  use({
    "numToStr/Comment.nvim",
    module = "Comment",
    keys = { "gc", "gb" },
    --config = override_req("nvim_comment", "(plugins.configs.others).comment()"),
    config = function()
      require("plugins.others").comment()
    end,
  })

end)
