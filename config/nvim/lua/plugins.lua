local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
    execute "packadd packer.nvim"
end

vim.cmd "autocmd BufWritePost plugins.lua PackerCompile" -- Auto compile when there are changes in plugins.lua

return require("packer").startup(function(use)
    -- Packer can manage itself as an optional plugin
    use "wbthomason/packer.nvim"

    -- TODO refactor all of this (for now it works, but yes I know it could be wrapped in a simpler function)
    use {"neovim/nvim-lspconfig"}
    use {
        "glepnir/lspsaga.nvim",
        --config = function ()
        --   require("n-lspsaga-nvim").config()
        --end,
        event = "BufRead"
    }

    --TODO: not config
    use {"kabouzeid/nvim-lspinstall", event = "BufRead"}

    -- Telescope
    use {"nvim-lua/popup.nvim"}
    use {"nvim-lua/plenary.nvim"}
    use {"nvim-telescope/telescope.nvim"}

    -- Autocomplete
    use {
        "hrsh7th/nvim-compe",
        event = "InsertEnter",
        config = function()
            require("n-nvim-compe").config()
        end
    }


    use {"hrsh7th/vim-vsnip", event = "InsertEnter"}
    use {"rafamadriz/friendly-snippets", event = "InsertEnter"}


    -- Treesitter
    use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}

    use {"kyazdani42/nvim-tree.lua",
        -- cmd = "NvimTreeToggle",
        config = function()
            require("n-nvimtree").config()
        end
    }

    use {"lewis6991/gitsigns.nvim",
        event = "BufRead",
        config = function()
            require("n-gitsigns").config()
        end,
    }

    -- whichkey
    use {"folke/which-key.nvim"}

    -- autopairs
    use {"windwp/nvim-autopairs"}

    -- Color
    use {"christianchiarulli/nvcode-color-schemes.vim", opt = true}

    -- Icons
    use {"kyazdani42/nvim-web-devicons"}

    -- Status Line and Bufferline
    use {"glepnir/galaxyline.nvim"}

    use {
        "romgrk/barbar.nvim",
        config = function()
            vim.api.nvim_set_keymap('n', '<TAB>', ':BufferNext<CR>',
                                    {noremap = true, silent = true})
            vim.api.nvim_set_keymap('n', '<S-TAB>', ':BufferPrevious<CR>',
                                    {noremap = true, silent = true})
            vim.api.nvim_set_keymap('n', '<S-x>', ':BufferClose<CR>',
                                    {noremap = true, silent = true})
        end,
        event = "BufRead"
    }
    use {
        'phaazon/hop.nvim',
        event = 'BufRead',
        config = function()
            require('n-hop').config()
        end,
        disable = false,
        opt = true
    }

    -- Dashboard
    use {
        "ChristianChiarulli/dashboard-nvim",
        event = 'BufWinEnter',
        cmd = {"Dashboard", "DashboardNewFile", "DashboardJumpMarks"},
        config = function()
            require('n-dashboard').config()
        end,
        disable = false,
        opt = true
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
        event = "BufRead",
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

    -- Treesitter playground
    use {
        'nvim-treesitter/playground',
        event = "BufRead",
        disable = false,
    }


    -- diagnostics
    use {"folke/trouble.nvim",
        opt = true,
        cmd = 'TroubleToggle',
    }

    -- Debugging
    use {"mfussenegger/nvim-dap",
        opt = true,
        event = "BufRead",
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
    use {
        "ahmedkhalf/lsp-rooter.nvim",
        event = "BufRead",
        config = function()
            require("lsp-rooter").setup()
        end,
        disable = false,
    }

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
    -- Use fzy for telescope
    use {
        "nvim-telescope/telescope-fzy-native.nvim",
        event = "BufRead",
    }
    -- Use project for telescope
    use {
        "nvim-telescope/telescope-project.nvim",
        event = "BufRead",
        disable = false
    }

    -- HTML preview
    use {
        'turbio/bracey.vim',
        event = "BufRead",
        run = 'npm install --prefix server',
        disable = true
    }
    -- Language
    use {'fatih/vim-go',
        opt = true,
        ft = {'go','golang'},
        config = function()
            require('n-vim-go').config()
        end
    }

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
