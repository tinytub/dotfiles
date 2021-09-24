local present, packer = pcall(require, "packerInit")

if not present then
   return false
end

local use = packer.use

return packer.startup(
    function()
    use {"wbthomason/packer.nvim", event = "VimEnter"}

    -- TODO refactor all of this (for now it works, but yes I know it could be wrapped in a simpler function)
    use {
        "kabouzeid/nvim-lspinstall",
        opt = true,
        setup = function()
            require("core.utils").packer_lazy_load "nvim-lspinstall"
            -- reload the current file so lsp actually starts for it
            vim.defer_fn(function()
               vim.cmd "silent! e %"
            end, 0)
        end,
    }
    use {
        "ray-x/lsp_signature.nvim",
        after = "nvim-lspconfig",
        config = function ()
            require("plugins.lspsign").config()
        end
    }
    use {"neovim/nvim-lspconfig",
        after = "nvim-lspinstall",
        config = function ()
            require('lsp')
            require('lsp.bash')
            require('lsp.go')
            require('lsp.json')
            require('lsp.lua')
            require('lsp.python')
            require('lsp.vim')
            require('lsp.yaml')
        end
    }
--    use {
--        "onsails/lspkind-nvim",
--        event = "InsertEnter",
--        config = function()
--            require("lspkind").init()
--        end
--    }

--    use {
--        "glepnir/lspsaga.nvim",
--        --config = function ()
--        --   require("n-lspsaga-nvim").config()
--        --end,
--        event = "BufRead"
--    }

    -- Icons
    use {
       "kyazdani42/nvim-web-devicons",
        after = "packer.nvim",
        config = function()
          require "plugins.icons"
        end,
    }


    use {
        "sainnhe/gruvbox-material",
        config = function ()
            vim.cmd([[
                let g:nvcode_termcolors=256
                colorscheme gruvbox-material
            ]])
            --require "highlights"

           require("colors").init()
        end
    }

    --use {
    --    "NvChad/nvim-base16.lua",
    --    disable = true,
    --    config = function ()
    --       require("colors").init("tomorrow-night")
    --    end
    --}

    use {
       "famiu/feline.nvim",
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
        "nvim-lua/plenary.nvim",
    }

    use {
        "nvim-telescope/telescope.nvim",
        --cmd = "Telescope",
        after = "plenary.nvim",
        requires = {
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                run = "make"
            },
            {
                "nvim-telescope/telescope-media-files.nvim",
                disable = true
            },
            {
               "sudormrfbin/cheatsheet.nvim",
               disable = false,
               after = "telescope.nvim",
               config = function()
                  require "plugins.s-cheatsheets"
               end
            }
        },
        config = [[require('plugins.telescope')]],
    }
    -- Use fzy for telescope
    --use {
    --    "nvim-telescope/telescope-fzy-native.nvim",
    --    run = "make",
    --    cmd = "Telescope"
    --}

    -- Autocomplete
--    use {"hrsh7th/vim-vsnip", event = "InsertEnter"}
--    use {
--        "hrsh7th/nvim-compe",
--        config = function()
--            require("plugins.compe").config()
--        end,
--        requires = {
--            "rafamadriz/friendly-snippets"
--        }
--    }

   -- load luasnips + cmp related in insert mode only
   use {
      "rafamadriz/friendly-snippets",
      event = "InsertEnter",
   }

   use {
      "hrsh7th/nvim-cmp",
--      event = "InsertEnter",
      after = "friendly-snippets",
      config = function()
         require "plugins.cmp"
      end,
   }

   use {
      "L3MON4D3/LuaSnip",
      wants = "friendly-snippets",
      after = "nvim-cmp",
      config = function()
         require "plugins.luasnips"
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


   -- Treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        branch = "0.5-compat",
        event = "BufRead",
        config = function ()
           require "plugins.treesitter"
        end
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
        disable = false
    }
    -- Smart text objects
    use {
        "RRethy/nvim-treesitter-textsubjects",
        after = "nvim-treesitter",
        disable = false
    }
    -- Text objects using hint labels
    use {
        "mfussenegger/nvim-ts-hint-textobject",
        event = "BufRead",
        after = "nvim-treesitter",
        disable = false
    }




    ---- Neoformat
    --use {
    --    "sbdchd/neoformat",
    --    config = function()
    --      require "plugins.neoformat"
    --    end,
    --    event = "BufRead",
    --}

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
    --use {
    --    "windwp/nvim-autopairs",
    --    config = function() require'n-autopairs' end
    --}
    -- Autopairs
    use {
      "windwp/nvim-autopairs",
     -- after = {"nvim-compe", "nvim-treesitter"},
      after = "nvim-cmp",
      config = function()
        require "plugins.autopairs"
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

    -- Ranger
    use {
      "kevinhwang91/rnvimr",
      cmd = "Rnvimr",
      config = function()
        require("plugins.rnvimr").config()
      end,
      disable = false
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

    use {
        "norcalli/nvim-colorizer.lua",
        event = "BufWinEnter",
        config = function()
            require("plugins.others").colorizer()
        end,
        disable = false,
    }


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


    -- diagnostics
    use {"folke/trouble.nvim",
        cmd = 'TroubleToggle',
    }

    -- Debugging
    use {
      "mfussenegger/nvim-dap",
      config = function()
        local status_ok, dap = pcall(require, "dap")
        if not status_ok then
          return
        end
        -- require "dap"
        vim.fn.sign_define("DapBreakpoint", {
          text = "",
          texthl = "LspDiagnosticsSignError",
          linehl = "",
          numhl = "",
        })
        dap.defaults.fallback.terminal_win_cmd = "50vsplit new"
      end,
      disable = true,
    }

    -- Better quickfix
    use {
        "kevinhwang91/nvim-bqf",
        event = "BufRead",
        disable = false
    }


    use {"voldikss/vim-floaterm",
        cmd = {'FloatermNew','FloatermPrev','FloatermNext','FloatermFirst','FloatermLast','FloatermUpdate','FloatermToggle','FloatermShow','FloatermHide','FloatermKill','FloatermSend'},
        config = function()
            vim.g.floaterm_gitcommit='floaterm'
            vim.g.floaterm_autoinsert=1
            vim.g.floaterm_width=0.8
            vim.g.floaterm_height=0.8
            vim.g.floaterm_wintitle=0
            vim.g.floaterm_autoclose=1
        end,
        event = "BufRead",
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
    -- Interactive scratchpad
    use {
        'metakirby5/codi.vim',
        cmd = 'Codi',
        event = "BufRead",
    }

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

    ---- Tabnine
    --use {
    --  "tzachar/compe-tabnine",
    --  run = "./install.sh",
    --  requires = "hrsh7th/nvim-compe",
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
        "Pocco81/TrueZen.nvim",
        cmd = {
            "TZAtaraxis",
            "TZMinimalist",
            "TZFocus"
        },
        config = function()
            require "plugins.zenmode"
        end
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
    use {
        "liuchengxu/vista.vim",
        config = function ()
           require('plugins.vista').config()
        end
    }

    -- Git
    use {
        'tpope/vim-fugitive',
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
        config = function ()
            vim.g["test#strategy"] = "floaterm"
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


end)
