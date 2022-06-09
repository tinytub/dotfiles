--local present, packer = pcall(require, "packerInit")
local use, packer = require("core.packerInit").getPacker()
--local use = packer.use

return packer.startup(function()
    use({ "wbthomason/packer.nvim" })
    use("lewis6991/impatient.nvim")
    use("nathom/filetype.nvim")
    use("nvim-lua/plenary.nvim")

    -- TODO refactor all of this (for now it works, but yes I know it could be wrapped in a simpler function)
    use({
        "williamboman/nvim-lsp-installer",
        opt = true,
        setup = function()
            require("core.utils").packer_lazy_load "nvim-lsp-installer"
            -- reload the current file so lsp actually starts for it
            vim.defer_fn(function()
                vim.cmd 'if &ft == "packer" | echo "" | else | silent! e %'
            end, 0)
        end,
        disable = false,
    })

    use({
        "neovim/nvim-lspconfig",
        after = "nvim-lsp-installer",
        config = function()
            -- lsp-installer should setup first
            require("lsp.lsp-installer")
            require("lsp.lspconfig")
        end,
    })

    use({
        "ray-x/lsp_signature.nvim",
        after = "nvim-lspconfig",
        config = function()
            require("plugins.others").signature()
        end,
    })

    use({
        -- lspserver 状态插件, 停用了 statuslines 中的状态。
        "j-hui/fidget.nvim",
        after = { "nvim-lspconfig" },
        config = function()
            require("plugins.fidget-nvim")
        end,
        event = { "BufRead", "BufNewFile", "InsertEnter" },
    })

    use({
        "jose-elias-alvarez/null-ls.nvim",
        --            ft = { 'sh', 'lua', 'zsh', 'bash', 'c', 'cpp', 'cmake', 'html', 'markdown', 'vim', 'json', 'markdown', 'css', 'javascript', 'javascriptreact', 'python' },
        after = "nvim-lsp-installer",
        config = function()
            require("lsp.null-ls")
        end,
        disable = false,
    })

    -- use {"dstein64/vim-startuptime"}
    -- Icons
    use({
        "kyazdani42/nvim-web-devicons",
        after = "base46",
        config = function()
            require("plugins.icons")
        end,
    })

    use({
        "rcarriga/nvim-notify",
        config = function()
            require("plugins.nvim-notify").config()
        end,
        disable = false,
    })

    use({
        "stevearc/dressing.nvim",
        event = "BufWinEnter",
        config = function()
            require("plugins.dressing").config()
        end,
    })

    use({
        -- this repo has break some base46 colors
        --		"CanKolay3499/base46",
        "tinytub/base46",
        after = "plenary.nvim",
        config = function()
            require("plugins.others").base46()
        end,
        disable = false,
    })
    use({
        --		"zahimeen/nvim-base46.lua",
        "jayden-chan/base46.nvim",
        after = "plenary.nvim",
        config = function()
            local theme_opts = {
                base = "base46",
                theme = "everforest",
                transparency = false,
            }
            local base46 = require("base46")
            base46.load_theme(theme_opts)

            package.loaded["colors.highlights" or false] = nil
            require("colors.highlights")
        end,
        disable = true,
    })

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

    -- try https://github.com/nvim-lualine/lualine.nvim ?
    use({
        "feline-nvim/feline.nvim",
        disable = false,
        --requires = "SmiteshP/nvim-gps",
        after = { "nvim-web-devicons" },
        config = function()
            require("plugins.statusline")
        end,
    })
    -- Simple statusline component that shows what scope you are working inside
    use({
        "SmiteshP/nvim-gps",
        event = "CursorMoved",
        config = function()
            require("plugins.gps")
        end,
    })

    use({
        "akinsho/nvim-bufferline.lua",
        tag = "v2.*",
        after = "nvim-web-devicons",
        config = function()
            require("plugins.bufferline")
        end,
        disable = false,
    })

    use({
        "romgrk/barbar.nvim",
        config = function() end,
        disable = true,
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

    use({
        "max397574/better-escape.nvim",
        event = "InsertCharPre",
        config = function()
            require("plugins.others").better_escape()
        end,
    })
    -- load luasnips + cmp related in insert mode only
    use({
        "rafamadriz/friendly-snippets",
        module = "cmp_nvim_lsp",
        event = "InsertEnter",
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

    use({
        "L3MON4D3/LuaSnip",
        wants = "friendly-snippets",
        after = { "nvim-cmp", "nvim-treesitter" },
        config = function()
            require("plugins.others").luasnip()
            --require "plugins.luasnips"
        end,
    })

    use({
        "saadparwaiz1/cmp_luasnip",
        after = "LuaSnip",
    })

    use({
        "hrsh7th/cmp-nvim-lua",
        after = "cmp_luasnip",
    })

    use({
        "hrsh7th/cmp-nvim-lsp",
        after = "cmp-nvim-lua",
    })

    use({
        "hrsh7th/cmp-buffer",
        after = "cmp-nvim-lsp",
    })

    use({
        "hrsh7th/cmp-path",
        after = "cmp-buffer",
    })

    -- Treesitter
    use({
        "nvim-treesitter/nvim-treesitter",
        event = { "BufRead", "BufNewFile" },
        config = function()
            require("plugins.treesitter").treesitter()
        end,
        run = ":TSUpdate",
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
        -- cmd = "NvimTreeToggle",
        after = "nvim-web-devicons",
        --cmd = { "NvimTreeToggle", "NvimTreeFocus" },
        config = function()
            --require("plugins.nvimtree").config()
            require("plugins.nvimtree")
        end,
    })

    use({
        "lewis6991/gitsigns.nvim",
        opt = true,
        --cond = function()
        --   return vim.fn.isdirectory ".git" == 1
        --end,
        config = function()
            require("plugins.gitsigns").config()
        end,
        setup = function()
            require("core.utils").packer_lazy_load("gitsigns.nvim")
        end,
    })

    -- whichkey
    use({
        "folke/which-key.nvim",
        setup = function()
            require("core.utils").packer_lazy_load("which-key.nvim")
        end,
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
        config = function()
            require("plugins.dashboard").setup()
        end,
    })

    -- matchup 高亮显示光标所在位置的光标,函数等
    use({
        "andymass/vim-matchup",
        --event = "CursorMoved",
        opt = true,
        config = function()
            require("plugins.matchup").config()
        end,
        setup = function()
            require("core.utils").packer_lazy_load("vim-matchup")
        end,
        disable = false,
    })

    use({
        "norcalli/nvim-colorizer.lua",
        event = "BufWinEnter",
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
    use({
        "mfussenegger/nvim-dap",
        config = function()
            -- require "dap"
            require("plugins.dap_init")

            require("dap-go").setup()
        end,
        requires = {
            "leoluz/nvim-dap-go",
        },

        disable = false,
    })

    use({
        after = "nvim-dap",
        "rcarriga/nvim-dap-ui",
        config = function()
            require("dapui").setup()
            --require('dap.ext.vscode').load_launchjs()
        end,
    })

    --    -- Better quickfix
    --    use {
    --        "kevinhwang91/nvim-bqf",
    --        event = "BufRead",
    --        disable = false
    --    }
    --

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
    use({
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
        setup = function()
            require("core.utils").packer_lazy_load("neoscroll.nvim")
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
    })

    use({
        "lukas-reineke/indent-blankline.nvim",
        disable = false,
        event = "BufRead",
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
            })
        end,
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
