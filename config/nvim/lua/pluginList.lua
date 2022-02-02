local present, packer = pcall(require, "packerInit")

if not present then
   return false
end

local use = packer.use

return packer.startup(
    function()
    use {"wbthomason/packer.nvim", event = "VimEnter"}
    use "lewis6991/impatient.nvim"
    use "nathom/filetype.nvim"
    use "nvim-lua/plenary.nvim"


    use {
        "ray-x/lsp_signature.nvim",
        after = "nvim-lspconfig",
        config = function ()
            require("plugins.others").signature()
        end
    }
    use {
        "neovim/nvim-lspconfig",
        module = "lspconfig",
    }

    -- TODO refactor all of this (for now it works, but yes I know it could be wrapped in a simpler function)
    use {
        'williamboman/nvim-lsp-installer',

        config = function ()
            require('lsp')
            --require('lsp.lspservers').setup_lsp()
        end
    }
    use {
        "jose-elias-alvarez/null-ls.nvim",
        after = "nvim-lspconfig",
        config = function()
           require("plugins.null-ls").setup()
        end,
        disable = true
    }

    -- use {"dstein64/vim-startuptime"}
    -- Icons
    use {
       "kyazdani42/nvim-web-devicons",
        after = "packer.nvim",
        config = function()
          require "plugins.icons"
        end,
    }

    --use {
    --    'sainnhe/everforest',
    --    config = function ()
    --        vim.cmd([[
    --            let g:everforest_background = 'hard'
    --            colorscheme everforest
    --        ]])
    --    end
    --}

    use {
        "sainnhe/gruvbox-material",
        config = function ()
            vim.cmd([[
                let g:gruvbox_material_statusline_style = 'original'
                colorscheme gruvbox-material
            ]])
            --require "highlights"

           require("colors").init()
        end
    }


    --use {
    --    "ellisonleao/gruvbox.nvim",
    --    requires = {"rktjmp/lush.nvim"},
    --    config = function ()
    --        vim.o.background = "dark" -- or "light" for light mode
    --        vim.cmd([[colorscheme gruvbox]])
    --        require("colors").init()
    --    end
    --}

    --use({
    --    'rose-pine/neovim',
    --    as = 'rose-pine',
    --    config = function()
    --        -- Options (see available options below)
    --        vim.g.rose_pine_variant = 'base'
    --
    --        -- Load colorscheme after options
    --        vim.cmd('colorscheme rose-pine')
    --    end
    --})

    --use {
    --    'folke/tokyonight.nvim',
    --    config = function ()
    --        vim.g.tokyonight_style = "night"
    --        vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }

    --        vim.cmd([[
    --            colorscheme tokyonight
    --        ]])
    --    end
    --}

    --use {
    --    "NvChad/nvim-base16.lua",
    --    disable = true,
    --    config = function ()
    --       require("colors").init("tomorrow-night")
    --    end
    --}

    use {
       "feline-nvim/feline.nvim",
       disable = false,
       after = "nvim-web-devicons",
       config = function()
          require "plugins.statusline"
       end,
    }

    use {
      "akinsho/nvim-bufferline.lua",
      after = "nvim-web-devicons",
      config = function()
        require("plugins.bufferline")
      end,
    }

    -- Telescope
    use {
        "nvim-telescope/telescope.nvim",
        module = "telescope",
        cmd = "Telescope",
        requires = {
            {
                "nvim-telescope/telescope-media-files.nvim",
                disable = true
            }
        },
        config = function ()
          require('plugins.telescope')
        end
    }

   use {
      "max397574/better-escape.nvim",
      event = "InsertEnter",
      config = function()
         require("plugins.others").better_escape()
      end,
   }
   -- load luasnips + cmp related in insert mode only
   use {
      "rafamadriz/friendly-snippets",
      module = "cmp_nvim_lsp",
      event = "InsertEnter",
   }

   use {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
--      commit = "30ed4e43a6fcb65b5816c578c78e3df3d87e6b1f",
      after = "friendly-snippets",
      config = function()
         require "plugins.cmp"
         vim.cmd [[highlight! link CmpItemAbbrMatchFuzzy Aqua]]
         vim.cmd [[highlight! link CmpItemKindText Fg]]
         vim.cmd [[highlight! link CmpItemKindMethod Purple]]
         vim.cmd [[highlight! link CmpItemKindFunction Purple]]
         vim.cmd [[highlight! link CmpItemKindConstructor Green]]
         vim.cmd [[highlight! link CmpItemKindField Aqua]]
         vim.cmd [[highlight! link CmpItemKindVariable Blue]]
         vim.cmd [[highlight! link CmpItemKindClass Green]]
         vim.cmd [[highlight! link CmpItemKindInterface Green]]
         vim.cmd [[highlight! link CmpItemKindValue Orange]]
         vim.cmd [[highlight! link CmpItemKindKeyword Keyword]]
         vim.cmd [[highlight! link CmpItemKindSnippet Red]]
         vim.cmd [[highlight! link CmpItemKindFile Orange]]
         vim.cmd [[highlight! link CmpItemKindFolder Orange]]
      end,
   }

   use {
      "L3MON4D3/LuaSnip",
      wants = "friendly-snippets",
      after = "nvim-cmp",
      config = function()
         require "plugins.others".luasnip()
      end,
   }

   use {
      "saadparwaiz1/cmp_luasnip",
      after = "LuaSnip",
   }

   use {
      "hrsh7th/cmp-nvim-lua",
      after = "cmp_luasnip",
   }

   use {
      "hrsh7th/cmp-nvim-lsp",
      after = "cmp-nvim-lua",
   }

   use {
      "hrsh7th/cmp-buffer",
      after = "cmp-nvim-lsp",
   }

   use {
      "hrsh7th/cmp-path",
      after = "cmp-buffer",
   }


   -- Treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        event = "BufRead",
        config = function ()
          require("plugins.treesitter").treesitter()
        end
        --config = function ()
        --   require "plugins.treesitter"
        --end
    }

    -- Treesitter playground
    use {
        'nvim-treesitter/playground',
        event = "BufRead",
        after = "nvim-treesitter",
        disable = false,
    }
    -- Custom semantic text objects
    use {
        "nvim-treesitter/nvim-treesitter-textobjects",
        after = "nvim-treesitter",
        --config = function ()
        --  require("plugins.treesitter").treesitter_obj()
        --end,
        disable = false
    }
    --use {
    --    "nvim-treesitter/nvim-treesitter-refactor",
    --    after = "nvim-treesitter-textobjects",
    --    config = function ()
    --      require("plugins.treesitter").treesitter_ref()
    --    end,
    --    disable = false
    --}
    -- Smart text objects
    use {
        "RRethy/nvim-treesitter-textsubjects",
        after = "nvim-treesitter",
        config = function ()
          require("plugins.treesitter").textsubjects()
        end,
        disable = false
    }
    -- Text objects using hint labels
    use {
        "mfussenegger/nvim-ts-hint-textobject",
        event = "BufRead",
        after = "nvim-treesitter",
        disable = false
    }

    use {"kyazdani42/nvim-tree.lua",
        -- cmd = "NvimTreeToggle",
        config = function()
            --require("plugins.nvimtree").config()
            require("plugins.nvimtree")
        end
    }

    use {"lewis6991/gitsigns.nvim",
        opt = true,
        cond = function()
           return vim.fn.isdirectory ".git" == 1
        end,
        config = function()
            require("plugins.gitsigns").config()
        end,
        setup = function()
           require("core.utils").packer_lazy_load "gitsigns.nvim"
        end,
    }

    -- whichkey
    use {
        "folke/which-key.nvim",
        config = function()
            require "plugins.whichkey"
        end,
    }

    ---- autopairs
    use {
      "windwp/nvim-autopairs",
     -- after = {"nvim-compe", "nvim-treesitter"},
      after = "nvim-cmp",
      config = function()
        require "plugins.others".autopairs()
      end,
    }

    -- Color
    --use {"christianchiarulli/nvcode-color-schemes.vim", opt = true}


    --use {
    --    "romgrk/barbar.nvim",
    --    config = function()
    --    end,
    --}

    --use {
    --    'phaazon/hop.nvim',
    --    event = 'BufRead',
    --    config = function()
    --        require('n-hop').config()
    --    end,
    --    disable = false,
    --    opt = true
    --}

    -- Dashboard
    use {
        "glepnir/dashboard-nvim",
        cmd = {
            "Dashboard",
            "DashboardNewFile",
            "DashboardJumpMarks",
            "SessionLoad",
            "SessionSave"
        },
        setup = function()
            require("plugins.dashboard").config()
        end
    }

    -- matchup
    use {
        'andymass/vim-matchup',
        --event = "CursorMoved",
        opt = true,
        config = function()
            require('plugins.matchup').config()
        end,
        setup = function()
           require("core.utils").packer_lazy_load "vim-matchup"
        end,
        disable = false
    }

--    use {
--        "norcalli/nvim-colorizer.lua",
--        event = "BufWinEnter",
--        config = function()
--            require("plugins.others").colorizer()
--        end,
--        disable = false,
--    }


    use {
        "nacro90/numb.nvim",
        event = "BufRead",
        config = function()
            require('numb').setup {
                show_numbers = true, -- Enable 'number' for the window while peeking
                show_cursorline = true -- Enable 'cursorline' for the window while peeking
            }
        end,
        disable = false,
    }

    -- Debugging
    use {
      "mfussenegger/nvim-dap",
      config = function()
        -- require "dap"
         require("plugins.dap_init")
         require("core.keymappings").dap()

         require('dap-go').setup()
      end,

      requires = {
        "leoluz/nvim-dap-go",
      },

      disable = false,
    }

    use {
        after = "nvim-dap",
        "rcarriga/nvim-dap-ui",
        config = function ()
            require('dapui').setup()
            --require('dap.ext.vscode').load_launchjs()
        end,
    }

--    -- Better quickfix
--    use {
--        "kevinhwang91/nvim-bqf",
--        event = "BufRead",
--        disable = false
--    }
--

-- use toggleterm ?
    --use {"voldikss/vim-floaterm",
    --    cmd = {'FloatermNew','FloatermPrev','FloatermNext','FloatermFirst','FloatermLast','FloatermUpdate','FloatermToggle','FloatermShow','FloatermHide','FloatermKill','FloatermSend'},
    --    config = function()
    --        vim.g.floaterm_gitcommit='floaterm'
    --        vim.g.floaterm_autoinsert=1
    --        vim.g.floaterm_width=0.8
    --        vim.g.floaterm_height=0.8
    --        vim.g.floaterm_wintitle=0
    --        vim.g.floaterm_autoclose=1
    --    end,
    --    event = "BufRead",
    --}

  -- Terminal
    use {
      "akinsho/toggleterm.nvim",
      --commit = commit.toggleterm,
      event = "BufWinEnter",
      config = function()
        require('plugins.toggleterm').config()
      end
      --disable = not lvim.builtin.terminal.active,
    }
    -- lsp root with this nvim-tree will follow you
    --use {
    --    "ahmedkhalf/lsp-rooter.nvim",
    --    config = function()
    --        require("lsp-rooter").setup()
    --    end,
    --    disable = false,
    --}

    -- Markdown preview
    use {
        'iamcco/markdown-preview.nvim',
        run = 'cd app && npm install',
        ft = 'markdown',
        event = "BufRead",
    }

    ---- Interactive scratchpad
    --use {
    --    'metakirby5/codi.vim',
    --    cmd = 'Codi',
    --    ft = 'python',
    --    event = "BufRead",
    --}

    ---- HTML preview
    --use {
    --    'turbio/bracey.vim',
    --    event = "BufRead",
    --    run = 'npm install --prefix server',
    --    disable = true
    --}
    -- LSP Colors
    use {
      "folke/lsp-colors.nvim",
      event = "BufRead",
      disable = false,
    }
    -- Lazygit
    use {
      "kdheepak/lazygit.nvim",
      cmd = "LazyGit",
      disable = false,
    }
    -- Octo
    --use {
    --  "pwntester/octo.nvim",
    --  event = "BufRead",
    --  disable = false,
    --}

    -- Language
    use {
        'ray-x/go.nvim',
        ft = {'go','golang'},
        config = function()
            require('go').setup()
        end
    }
    --use {'fatih/vim-go',
    --    opt = true,
    --    ft = {'go','golang'},
    --    config = function()
    --        require('n-vim-go').config()
    --    end
    --}


    -- smooth scroll
    use {"psliwka/vim-smoothie"}
    use {
        "karb94/neoscroll.nvim",
        opt = true,
--        event = "WinScrolled",
        config = function()
            require("neoscroll").setup()
        end,
        setup = function()
           require("core.utils").packer_lazy_load "neoscroll.nvim"
        end,
    }

    use {
        "unblevable/quick-scope",
        config = function ()
            vim.g.qs_highlight_on_keys = {'f', 'F', 't', 'T'}
            vim.g.qs_max_chars=150
            vim.api.nvim_command('augroup quickscopecolor')
            vim.api.nvim_command('autocmd!')
            vim.api.nvim_command("autocmd ColorScheme * highlight QuickScopePrimary guifg='#b1fa87' gui=underline ctermfg=155 cterm=underline")
            vim.api.nvim_command("autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline")
            vim.api.nvim_command('augroup END')
        end
    }
    --use {
    --    "liuchengxu/vista.vim",
    --    event = "BufRead",
    --    config = function ()
    --       require('plugins.vista').config()
    --    end
    --}

    -- Git
    use {
        'tpope/vim-fugitive',
        event = "BufRead",
        cmd = {
            "Git",
            "Gdiff",
            "Gdiffsplit",
            "Gvdiffsplit",
            "Gwrite",
            "Gw",
        }
    }

    use {
        'vim-test/vim-test',
        event = "BufRead",
        config = function ()

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
            vim.g['test#preserve_screen'] = 1
            vim.g["test#go#runner"] = "gotest"
            vim.g["test#go#gotest#options"] = "-v --count=1"
            vim.g["test#echo_command"] = 1
    end
    }
    use {
        "lukas-reineke/indent-blankline.nvim",
        disable = false,
        event = "BufRead",
        config = function()
            require("plugins.others").blankline()
        end,
    }

    use {
      'folke/trouble.nvim',
      cmd = {'Trouble', 'TroubleToggle'},
      config = function()
        require("trouble").setup {}
      end
    }

    -- todo highlights
    use {
      'folke/todo-comments.nvim',
      requires = 'nvim-lua/plenary.nvim',
      config = function()
        require('plugins.todo-comments')
      end,
      event = 'BufWinEnter',
      disable = true,
    }
    use {
       "numToStr/Comment.nvim",
       module = "Comment",
       --config = override_req("nvim_comment", "(plugins.configs.others).comment()"),
       config = function ()
          require("plugins.others").comment()
       end,
       setup = function()
          require("core.keymappings").comment()
       end,
    }
    end
)
