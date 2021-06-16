local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
    execute "packadd packer.nvim"
end

--- Check if a file or directory exists in this path
local function require_plugin(plugin)
    local plugin_prefix = fn.stdpath("data") .. "/site/pack/packer/opt/"

    local plugin_path = plugin_prefix .. plugin .. "/"
    --	print('test '..plugin_path)
    local ok, err, code = os.rename(plugin_path, plugin_path)
    if not ok then
        if code == 13 then
            -- Permission denied, but it exists
            return true
        end
    end
    --	print(ok, err, code)
    if ok then vim.cmd("packadd " .. plugin) end
    return ok, err, code
end

vim.cmd "autocmd BufWritePost plugins.lua PackerCompile" -- Auto compile when there are changes in plugins.lua

return require("packer").startup(function(use)
    -- Packer can manage itself as an optional plugin
    use "wbthomason/packer.nvim"

    -- TODO refactor all of this (for now it works, but yes I know it could be wrapped in a simpler function)
    use {"neovim/nvim-lspconfig", opt = true}
    require_plugin("nvim-lspconfig")

    use {"glepnir/lspsaga.nvim", opt = true}
    require_plugin("lspsaga.nvim")

    use {"kabouzeid/nvim-lspinstall", opt = true}
    require_plugin("nvim-lspinstall")

    use {"folke/trouble.nvim", opt = true}
    require_plugin('trouble.nvim')

    -- Telescope
    use {"nvim-lua/popup.nvim", opt = true}
    require_plugin("popup.nvim")

    use {"nvim-lua/plenary.nvim", opt = true}
    require_plugin("plenary.nvim")

    use {"nvim-telescope/telescope.nvim", opt = true}
    require_plugin("telescope.nvim")
    use {"nvim-telescope/telescope-fzy-native.nvim", opt = true}
    use {"nvim-telescope/telescope-project.nvim", opt = true}
    require_plugin('telescope-project.nvim')

    -- Debugging
    use {"mfussenegger/nvim-dap", opt = true}
    require_plugin("nvim-dap")

    -- Autocomplete
    use {"hrsh7th/nvim-compe", opt = true}
    require_plugin("nvim-compe")
    use {"hrsh7th/vim-vsnip", opt = true}
    require_plugin("vim-vsnip")
    use {"rafamadriz/friendly-snippets", opt = true}
    require_plugin("friendly-snippets")

    -- Treesitter
    use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
    require_plugin("nvim-treesitter")
    use {"windwp/nvim-ts-autotag", opt = true}
    require_plugin("nvim-ts-autotag")
    use {'andymass/vim-matchup', opt = true}
    require_plugin('vim-matchup')

    -- Explorer
    use {"kyazdani42/nvim-tree.lua", opt = true}
    require_plugin("nvim-tree.lua")
    use {"ahmedkhalf/lsp-rooter.nvim", opt = true} -- with this nvim-tree will follow you
    require_plugin('lsp-rooter.nvim')
    -- TODO remove when open on dir is supported by nvimtree
    use "kevinhwang91/rnvimr"

    -- use {'lukas-reineke/indent-blankline.nvim', opt=true, branch = 'lua'}
    use {"lewis6991/gitsigns.nvim", opt = true}
    require_plugin("gitsigns.nvim")
    use {"folke/which-key.nvim", opt = true}
    require_plugin("which-key.nvim")
    use {"ChristianChiarulli/dashboard-nvim", opt = true}
    require_plugin("dashboard-nvim")
    use {"windwp/nvim-autopairs", opt = true}
    require_plugin("nvim-autopairs")
    use {"kevinhwang91/nvim-bqf", opt = true}  -- better quickfix window
    require_plugin("nvim-bqf")

    -- Comments
    -- use {"terrortylor/nvim-comment", opt = true}
    -- use {'JoosepAlviste/nvim-ts-context-commentstring', opt = true}

    -- Color
    use {"christianchiarulli/nvcode-color-schemes.vim", opt = true}
    require_plugin("nvcode-color-schemes.vim")

    -- Icons
    use {"kyazdani42/nvim-web-devicons", opt = true}
    require_plugin("nvim-web-devicons")

    -- Status Line and Bufferline
    use {"glepnir/galaxyline.nvim", opt = true}
    require_plugin("galaxyline.nvim")
    use {"romgrk/barbar.nvim", opt = true}
    require_plugin("barbar.nvim")

    -- Language
    use {'fatih/vim-go', opt = true, ft = {'go','golang'}}
    require_plugin('vim-go')

    use {"psliwka/vim-smoothie"}
    require_plugin("vim-smoothie")
    use {"sainnhe/gruvbox-material"}
    require_plugin("gruvbox-material")
    use {"voldikss/vim-floaterm", opt = true, cmd = {'FloatermNew','FloatermPrev','FloatermNext','FloatermFirst','FloatermLast','FloatermUpdate','FloatermToggle','FloatermShow','FloatermHide','FloatermKill','FloatermSend'}}
    require_plugin("voldikss/vim-floaterm")

--    require_plugin("nvim-ts-context-commentstring")

    -- Extras
    if O.extras then
        use {'metakirby5/codi.vim', opt = true}
        require_plugin('codi.vim')
        use {'iamcco/markdown-preview.nvim', run = 'cd app && npm install', opt = true}
        require_plugin('markdown-preview.nvim')
        use {'numToStr/FTerm.nvim', opt = true}
        require_plugin('numToStr/FTerm.nvim')
--        use {'monaqa/dial.nvim', opt = true}
--        require_plugin('dial.nvim')
        use {'nacro90/numb.nvim', opt = true} -- 自动跳转行数
        require_plugin('numb.nvim')
        use {'turbio/bracey.vim', run = 'npm install --prefix server', opt = true}
        require_plugin('bracey.vim')
        use {'phaazon/hop.nvim', opt = true}
        require_plugin('hop.nvim')
        use {'norcalli/nvim-colorizer.lua', opt = true}
        require_plugin('nvim-colorizer.lua')
        --use {'windwp/nvim-spectre', opt = true}
        --require_plugin('windwp/nvim-spectre')
        --use {'simrat39/symbols-outline.nvim', opt = true}
        --require_plugin('symbols-outline.nvim')
        use {'nvim-treesitter/playground', opt = true}
        require_plugin('playground')
        -- folke/todo-comments.nvim
        -- gennaro-tedesco/nvim-jqx
        -- TimUntersberger/neogit
        -- folke/lsp-colors.nvim
        -- simrat39/symbols-outline.nvim

        -- Git
        use {'tpope/vim-fugitive', opt = true}
        -- use {'tpope/vim-rhubarb', opt = true}
        -- pwntester/octo.nvim

        -- Easily Create Gists
        -- use {'mattn/vim-gist', opt = true}
        -- use {'mattn/webapi-vim', opt = true}
    end

end)
