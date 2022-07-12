local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
    return
end

which_key.setup({
    -- plugins = {
    --     marks = true, -- shows a list of your marks on ' and `
    --     registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    --     -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    --     -- No actual key bindings are created
    --     presets = {
    --         operators = false, -- adds help for operators like d, y, ...
    --         motions = false, -- adds help for motions
    --         text_objects = false, -- help for text objects triggered after entering an operator
    --         windows = true, -- default bindings on <c-w>
    --         nav = true, -- misc bindings to work with windows
    --         z = true, -- bindings for folds, spelling and others prefixed with z
    --         g = true -- bindings for prefixed with g
    --     }
    -- },
    popup_mappings = {
        scroll_down = "<c-d>", -- binding to scroll down inside the popup
        scroll_up = "<c-u>", -- binding to scroll up inside the popup
    },
    icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+", -- symbol prepended to a group
    },
    window = {
        border = "single", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    },
    layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 6, -- spacing between columns
    },
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
    show_help = true, -- show help message on the command line when the popup is visible
    triggers_blacklist = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        i = { "j", "k" },
        v = { "j", "k" },
    },
})

local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
}

local mappings = {
    --["/"] = "Comment",
    ["c"] = "Close Buffer",
    ["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
    ["F"] = { "<cmd>NvimTreeFindFile<cr>", "Find Current File" },
    --["V"] = {"<cmd>Vista<cr>"                                          ,"Vista"},
    [";"] = { "<cmd>Dashboard<cr>", "home screen" },
    ["M"] = { "<cmd>MarkdownPreviewToggle<cr>", "markdown preview" },
    ["h"] = { '<cmd>let @/ = ""<cr>', "no highlight" },
    ["v"] = { "<C-W>v", "split right" },
    ["w"] = { "<cmd>execute 15 .. 'new +terminal' | let b:term_type = 'hori' | startinsert <CR>", "open terminal" },

    a = {
        name = "+actions",
        ["c"] = { "<cmd>ColorizerToggle<cr>", "colorizer" },
        ["h"] = { '<cmd>let @/ = ""<cr>', "remove search highlight" },
        ["i"] = { "<cmd>IndentBlanklineToggle<cr>", "toggle indent lines" },
        ["n"] = { "<cmd>set nonumber!<cr>", "line-numbers" },
        ["r"] = { "<cmd>set norelativenumber!<cr>", "relative line nums" },
    },

    f = {
        name = "+Finder",
        r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
        n = { "<cmd>enew<cr>", "New File" },
        --. = {"<cmd>Telescope filetypes<cr>"                   , "filetypes"},
        B = { "<cmd>Telescope git_branches<cr>", "git branches" },
        d = { "<cmd>Telescope lsp_document_diagnostics<cr>", " document_diagnostics" },
        D = { "<cmd>Telescope lsp_workspace_diagnostics<cr>", " workspace_diagnostics" },
        --f = {"<cmd>Telescope find_files <cr>"                 , "files"},
        f = { "<cmd>Telescope find_files follow=true no_ignore=true hidden=true <cr>", " files" },
        h = { "<cmd>Telescope command_history<cr>", " history" },
        i = { "<cmd>Telescope media_files<cr>", " media files" },
        m = { "<cmd>Telescope marks<cr>", "marks" },
        M = { "<cmd>Telescope man_pages<cr>", " man_pages" },
        v = { "<cmd>Telescope vim_options<cr>", "vim_options" },
        a = { "<cmd>Telescope live_grep<cr>", " live grep" },
        b = { "<cmd>Telescope file_browser<cr>", " file browser" },
        u = { "<cmd>Telescope colorscheme<cr>", " colorschemes" },
        g = { "<cmd>Telescope git_files<cr>", "git_files" },
        w = { "<cmd>Telescope grep_string<cr>", "grep_string" },
        o = { "<cmd>Telescope oldfiles<cr>", "oldfiles" },
        c = { "<cmd>Telescope git_commits<cr>", "git_commits" },
        s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
        S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols" },
        --        ["<leader>pt"] = { "<cmd> Telescope terms <CR>", "   pick hidden term" },
        q = { "<cmd>Telescope quickfix<cr>", "Quickfix" },
        t = { "<cmd>TodoTelescope<cr>", "Find TODO" },
        k = { "<cmd>Telescope keymaps<CR>", "Find keymaps" },
        W = { "<cmd>Telescope terms <CR>", "Pick a hidden term" },
    },

    b = {
        name = "+buffer",
        [">"] = { "<cmd>BufferMoveNext<cr>", "move next" },
        ["<"] = { "<cmd>BufferMovePrevious<cr>", "move prev" },
        ["P"] = { "<cmd>BufferPick<cr>", "pick buffer" },
        ["d"] = { "<cmd>BufferClose<cr>", "delete-buffer" },
        ["n"] = { "bnext", "next-buffer" },
        ["p"] = { "bprevious", "previous-buffer" },
        ["?"] = { "Buffers", "fzf-buffer" },
        ["b"] = { "<cmd>Telescope buffers<cr>", " find bufers" },

        ["c"] = {
            function()
                local ok, start = require("indent_blankline.utils").get_current_context(
                    vim.g.indent_blankline_context_patterns,
                    vim.g.indent_blankline_use_treesitter_scope
                )

                if ok then
                    vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start, 0 })
                    vim.cmd [[normal! _]]
                end
            end,

            "  Jump to current_context",
        },
    },
    g = {
        name = "+Git",
        b = { "<cmd>Git blame<cr>", "Git Blame" },
        d = { "<cmd>Git diff<cr>", "Git Diff" },
        l = { "<cmd>Git log<cr>", "Git Log" },
        s = { "<cmd>Git status<cr>", "  Git Status" },

        o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
        B = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
        c = { "<cmd>Telescope git_commits<cr>", "  Checkout commit" },
        C = {
            "<cmd>Telescope git_bcommits<cr>",
            "Checkout commit(for current file)",
        },
    },
    l = {
        name = "+LSP",
        a = { "<cmd>lua vim.lsp.buf.range_code_action()<CR>", "Code Action" },
        i = { "<cmd>LspInfo<cr>", "Info" },
        f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
        j = { "<cmd>lua vim.diagnostic.goto_next({popup_opts = {border = 'single'}})<cr>", "Next Diagnostic" },
        k = { "<cmd>lua vim.diagnostic.goto_prev({popup_opts = {border = 'single'}})<cr>", "Prev Diagnostic" },
        --r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
        q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", "Quickfix" },
        t = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Type Definition" },
        x = { "<cmd>cclose<cr>", "Close Quickfix" },
        r = {
            function()
                --TODO: can use this tiny plugin https://github.com/smjonas/inc-rename.nvim
                vim.lsp.buf.rename.float()
            end,
            --function()
            --    return ":IncRename " .. vim.fn.expand("<cword>")
            --end,
            "   lsp rename",
        },
    },
    --t = {
    --   name = '+Terminal' ,
    --   [";"] = {"<cmd>FloatermNew --wintype=normal --height=6<cr>"       , "terminal"},
    --   ["f"] = {"<cmd>FloatermNew fzf<cr>"                               , "fzf"},
    --   ["g"] = {"<cmd>FloatermNew lazygit<cr>"                           , "git"},
    --   ["n"] = {"<cmd>FloatermNew node<cr>"                              , "node"},
    --   ["p"] = {"<cmd>FloatermNew python<cr>"                            , "python"},
    --   ["t"] = {"<cmd>FloatermToggle<cr>"                                , "toggle"},
    --   ["k"] = {"<cmd>FloatermKill<cr>"                                  , "kill term"},
    --},
    p = {
        name = "Packer",
        ["u"] = { "<cmd>PackerUpdate<cr>", "packer update" },
        ["i"] = { "<cmd>PackerInstall<cr>", "packer install" },
        ["c"] = { "<cmd>PackerCompile<cr>", "packer compile" },
        ["s"] = { "<cmd>PackerSync<cr>", "packer sync" },
    },
    d = {
        name = "Dap",
        ["d"] = { "<cmd>lua require'dapui'.toggle()<CR>", "toggle dap UI" },
        ["f"] = { "<cmd>lua require'dapui'.eval()<CR>" },
        ["b"] = { "<cmd>lua require'dap'.toggle_breakpoint()<CR>", "toggle breakpoint" },
        ["c"] = {
            "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
            "set breakpoint",
        },
        ["l"] = {
            ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
            "Log point message",
        },
    },
    S = {
        name = "+Session",
        s = { "<cmd>SessionSave<cr>", "Save Session" },
        l = { "<cmd>SessionLoad<cr>", "Load Session" },
    },
}

local misc_n_opts = {
    mode = "n", -- NORMAL mode
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
}

local misc_n_mapping = {
    -- close buffer + hide terminal buffer
    ["<C-x>"] = { "<cmd>lua require('core.utils').close_buffer() <CR>", "  close buffer" },
    ["<ESC>"] = { "<cmd> noh <CR>", "  no highlight" },

    -- M-key means ALT-xxxx
    ["<M-[>"] = { "<cmd>vertical resize -2<CR>", "vertical resize -2" },
    ["<M-]>"] = { "<cmd>vertical resize +2<CR>", "vertical resize +2" },

    -- cycle through buffers
    ["<TAB>"] = { "<cmd> BufferLineCycleNext <CR>", "  cycle next buffer" },
    ["<S-Tab>"] = { "<cmd> BufferLineCyclePrev <CR>", "  cycle prev buffer" },
    ["<S-b>"] = { "<cmd> enew <CR>", "烙 new buffer" },

    ["<F5>"] = { "<cmd>lua require'dap'.continue()<CR>", "dap continue" },
    ["<F10>"] = { "<cmd>lua require'dap'.step_over()<CR>", "dap step over" },
    ["<F11>"] = { "<cmd>lua require'dap'.step_into()<CR>", "dap step into" },
    ["<F12>"] = { "<cmd>lua require'dap'.step_out()<CR>", "dap step out" },
    ["<leader>/"] = {
        function()
            require("Comment.api").toggle_current_linewise()
        end,

        "toggle comment",
    },
}

local misc_v_opts = {
    mode = "v", -- NORMAL mode
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
}

local misc_v_mapping = {
    ["<leader>/"] = {
        "<ESC><cmd>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>",
        "toggle comment",
    },
}

local wk = require("which-key")

wk.register(misc_n_mapping, misc_n_opts)
wk.register(misc_v_mapping, misc_v_opts)

wk.register(mappings, opts)
