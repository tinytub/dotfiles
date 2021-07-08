local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
    execute "packadd packer.nvim"
end

local packer_ok, packer = pcall(require, "packer")
if not packer_ok then
  return
end

packer.init {
  -- compile_path = vim.fn.stdpath('data')..'/site/pack/loader/start/packer.nvim/plugin/packer_compiled.vim',
  compile_path = require("packer.util").join_paths(vim.fn.stdpath "config", "plugin", "packer_compiled.vim"),
  git = {
    clone_timeout = 300
  },
  display = {
    open_fn = function()
      return require("packer.util").float { border = "single" }
    end,
  },
}

--vim.cmd "autocmd BufWritePost plugins.lua PackerCompile" -- Auto compile when there are changes in plugins.lua

return require("packer").startup(function(use)
    -- Packer can manage itself as an optional plugin
    use "wbthomason/packer.nvim"

    -- TODO refactor all of this (for now it works, but yes I know it could be wrapped in a simpler function)
    use {"neovim/nvim-lspconfig"}
    use { "kabouzeid/nvim-lspinstall", event = "BufRead"}
    use {
        "onsails/lspkind-nvim",
        event = "BufRead",
        config = function()
            require("lspkind").init()
        end
    }

--    use {
--        "glepnir/lspsaga.nvim",
--        --config = function ()
--        --   require("n-lspsaga-nvim").config()
--        --end,
--        event = "BufRead"
--    }

    -- Telescope
    use {"nvim-lua/popup.nvim"}
    use {"nvim-lua/plenary.nvim"}
    use {
        "nvim-telescope/telescope.nvim",
        config = [[require('n-telescope')]],
    }
    -- Use fzy for telescope
    use {
        "nvim-telescope/telescope-fzy-native.nvim",
        event = "BufRead",
    }
    -- Use project for telescope
    use {
        "nvim-telescope/telescope-project.nvim",
        after = "telescope.nvim",
        setup = function () vim.cmd[[packadd telescope.nvim]] end,
        event = "BufRead",
        disable = false
    }

    -- Autocomplete
    use {"hrsh7th/vim-vsnip", event = "InsertEnter"}
    use {"rafamadriz/friendly-snippets", event = "InsertEnter"}
    use {
        "hrsh7th/nvim-compe",
        event = "InsertEnter",
        config = function()
            require("n-nvim-compe").config()
        end,
        requires = {
            "rafamadriz/friendly-snippets"
        }
    }


    -- Treesitter
    use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
    -- Treesitter playground
    use {
        'nvim-treesitter/playground',
        event = "BufRead",
        disable = false,
    }
    -- Custom semantic text objects
    use {
      "nvim-treesitter/nvim-treesitter-textobjects",
      disable = false
    }
    -- Smart text objects
    use {
      "RRethy/nvim-treesitter-textsubjects",
      disable = false
    }
    -- Text objects using hint labels
    use {
      "mfussenegger/nvim-ts-hint-textobject",
      event = "BufRead",
      disable = false
    }




    -- Neoformat
    use {
        "sbdchd/neoformat",
        config = function()
          require "n-neoformat"
        end,
        event = "BufRead",
    }

    use {"kyazdani42/nvim-tree.lua",
        -- cmd = "NvimTreeToggle",
        config = function()
            require("n-nvimtree").config()
        end
    }

    use {"lewis6991/gitsigns.nvim",
        config = function()
            require("n-gitsigns").config()
        end,
        event = "BufRead",
    }

    -- whichkey
    use {"folke/which-key.nvim"}

    ---- autopairs
    --use {
    --    "windwp/nvim-autopairs",
    --    config = function() require'n-autopairs' end
    --}
    -- Autopairs
    use {
      "windwp/nvim-autopairs",
      event = "InsertEnter",
      after = { "telescope.nvim", "nvim-compe"},
      config = function()
        require "n-autopairs"
      end,
    }

    -- Color
    use {"christianchiarulli/nvcode-color-schemes.vim", opt = true}

    -- Icons
    use {"kyazdani42/nvim-web-devicons"}

    -- Status Line and Bufferline
    use {
        "glepnir/galaxyline.nvim",
        config = function ()
            require("n-galaxyline")
        end
    }
    use {
      "akinsho/nvim-bufferline.lua",
      config = function()
        require("n-bufferline").config()
      end,
      --event = "BufRead",
    }
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
    --use {
    --    "ChristianChiarulli/dashboard-nvim",
    --    event = 'BufWinEnter',
    --    cmd = {"Dashboard", "DashboardNewFile", "DashboardJumpMarks"},
    --    config = function()
    --        require('n-dashboard').config()
    --    end,
    --    disable = false,
    --    opt = true
    --}
    -- Ranger
    use {
      "kevinhwang91/rnvimr",
      cmd = "Rnvimr",
      config = function()
        require("n-rnvimr").config()
      end,
      disable = false
    }

    -- matchup
    use {
        'andymass/vim-matchup',
        event = "CursorMoved",
        config = function()
            require('n-matchup').config()
        end,
        disable = false
    }

    use {
        "norcalli/nvim-colorizer.lua",
        event = "BufWinEnter",
        config = function()
            require("colorizer").setup()
            vim.cmd("ColorizerReloadAllBuffers")
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
        opt = true,
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
      disable = false,
    }

    -- Better quickfix
    use {
        "kevinhwang91/nvim-bqf",
        event = "BufRead",
        disable = false
    }


    use {"voldikss/vim-floaterm",
        opt = true,
        cmd = {'FloatermNew','FloatermPrev','FloatermNext','FloatermFirst','FloatermLast','FloatermUpdate','FloatermToggle','FloatermShow','FloatermHide','FloatermKill','FloatermSend'},
        config = function()
            vim.g.floaterm_gitcommit='floaterm'
            vim.g.floaterm_autoinsert=1
            vim.g.floaterm_width=0.8
            vim.g.floaterm_height=0.8
            vim.g.floaterm_wintitle=0
            vim.g.floaterm_autoclose=1
        end,
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
    }
    -- Interactive scratchpad
    use {
        'metakirby5/codi.vim',
        cmd = 'Codi',
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

    use {"psliwka/vim-smoothie"}
    use {
        "sainnhe/gruvbox-material",
        config = function ()
            vim.cmd('let g:nvcode_termcolors=256')
            vim.cmd('colorscheme gruvbox-material')
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
           require('n-vista').config()
        end
    }

    -- Git
    use {'tpope/vim-fugitive'}


end)
