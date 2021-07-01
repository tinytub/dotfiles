require("which-key").setup {
    plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
            operators = false, -- adds help for operators like d, y, ...
            motions = false, -- adds help for motions
            text_objects = false, -- help for text objects triggered after entering an operator
            windows = true, -- default bindings on <c-w>
            nav = true, -- misc bindings to work with windows
            z = true, -- bindings for folds, spelling and others prefixed with z
            g = true -- bindings for prefixed with g
        }
    },
    icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+" -- symbol prepended to a group
    },
    window = {
        border = "single", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = {1, 0, 1, 0}, -- extra window margin [top, right, bottom, left]
        padding = {2, 2, 2, 2} -- extra window padding [top, right, bottom, left]
    },
    layout = {
        height = {min = 4, max = 25}, -- min and max height of the columns
        width = {min = 20, max = 50}, -- min and max width of the columns
        spacing = 3 -- spacing between columns
    },
    hidden = {"<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "}, -- hide mapping boilerplate
    show_help = true -- show help message on the command line when the popup is visible
}

local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false -- use `nowait` when creating keymaps
}

local mappings = {
    --["/"] = "Comment",
    ["c"] = "Close Buffer",
    ["e"] = {"<cmd>NvimTreeToggle<cr>"                                 ,"Explorer"},
    ["F"] = {"<cmd>NvimTreeFindFile<cr>"                               ,"Find Current File"},
    ["V"] = {"<cmd>Vista<cr>"                                          ,"Vista"},
    [";"] = {"<cmd>Dashboard<cr>"                                        , "home screen"},
    ["M"] = {"<cmd>MarkdownPreviewToggle<cr>"                          , "markdown preview"},
    ["h"] = {"<cmd>let @/ = \"\"<cr>"                                    , "no highlight" },
    ["T"] = {"<cmd>TSHighlightCapturesUnderCursor<cr>"                 , "treesitter highlight" },
    ["v"] = {"<C-W>v"                                          , "split right"},

    a = {
      name= '+actions' ,
      ['c'] = {"<cmd>ColorizerToggle<cr>"        , 'colorizer'},
      ['h'] = {"<cmd>let @/ = \"\"<cr>"            , 'remove search highlight'},
      ['i'] = {"<cmd>IndentBlanklineToggle<cr>"  , 'toggle indent lines'},
      ['n'] = {"<cmd>set nonumber!<cr>"          , 'line-numbers'},
      ['r'] = {"<cmd>set norelativenumber!<cr>"  , 'relative line nums'},
    },
    f = {
        name = "+Finder",
        r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
        n = { "<cmd>enew<cr>", "New File" },
        --. = {"<cmd>Telescope filetypes<cr>"                   , "filetypes"},
        B = {"<cmd>Telescope git_branches<cr>"                , "git branches"},
        d = {"<cmd>Telescope lsp_document_diagnostics<cr>"    , "document_diagnostics"},
        D = {"<cmd>Telescope lsp_workspace_diagnostics<cr>"   , "workspace_diagnostics"},
        f = {"<cmd>Telescope find_files<cr>"                 , "files"},
        h = {"<cmd>Telescope command_history<cr>"            , "history"},
        i = {"<cmd>Telescope media_files<cr>"                , "media files"},
        m = {"<cmd>Telescope marks<cr>"                      , "marks"},
        M = {"<cmd>Telescope man_pages<cr>"                  , "man_pages"},
        v = {"<cmd>Telescope vim_options<cr>"                , "vim_options"},
        a = {"<cmd>Telescope live_grep<cr>"                  , "text"},
        b = {"<cmd>Telescope file_browser<cr>"               , "file browser"},
        u = {"<cmd>Telescope colorscheme<cr>"                , "colorschemes"},
        g = {"<cmd>Telescope git_files<cr>"                  , "git_files"},
        w = {"<cmd>Telescope grep_string<cr>"                , "grep_string"},
        o = {"<cmd>Telescope oldfiles<cr>"                   , "oldfiles"},
        c = {"<cmd>Telescope git_commits<cr>"                , "git_commits"},
        s = {"<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols"},
        S = {"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols"},
        q = {"<cmd>Telescope quickfix<cr>", "Quickfix"},
      },

    b = {
      name = '+buffer' ,
      ['>'] = {"<cmd>BufferMoveNext<cr>"        , 'move next'},
      ['<'] = {"<cmd>BufferMovePrevious<cr>"    , 'move prev'},
      ['P'] = {"<cmd>BufferPick<cr>"            , 'pick buffer'},
      ['d'] = {"<cmd>BufferClose<cr>"           , 'delete-buffer'},
      ['n'] = {"bnext"                  , 'next-buffer'},
      ['p'] = {"bprevious"              , 'previous-buffer'},
      ['?'] = {"Buffers"                , 'fzf-buffer'},
      ['b'] = {"<cmd>Telescope buffers<cr>"                , 'find bufers'},
    },
    d = {
        name = "+Debug",
        b = {"<cmd>DebugToggleBreakpoint<cr>", "Toggle Breakpoint"},
        c = {"<cmd>DebugContinue<cr>", "Continue"},
        i = {"<cmd>DebugStepInto<cr>", "Step Into"},
        o = {"<cmd>DebugStepOver<cr>", "Step Over"},
        r = {"<cmd>DebugToggleRepl<cr>", "Toggle Repl"},
        s = {"<cmd>DebugStart<cr>", "Start"},
    },
    g = {
        name = "+Git",
        b = {"<cmd>Git blame<cr>", "Git Blame"},
        d = {"<cmd>Git diff<cr>", "Git Diff"},
        l = {"<cmd>Git log<cr>", "Git Log"},
        s = {"<cmd>Git status<cr>", "Git Status"},
    },
    l = {
        name = "+LSP",
        a = {"<cmd>Lspsaga code_action<cr>", "Code Action"},
        A = {"<cmd>Lspsaga range_code_action<cr>", "Selected Action"},
--        d = {"<cmd>Telescope lsp_document_diagnostics<cr>", "Document Diagnostics"},
--        D = {"<cmd>Telescope lsp_workspace_diagnostics<cr>", "Workspace Diagnostics"},
--        f = {"<cmd>LspFormatting<cr>", "Format"},
       i = {"<cmd>LspInfo<cr>", "Info"},
        f = {"<cmd>lua vim.lsp.buf.formatting()<cr>", "Format"},
        h = {"<cmd>Lspsaga hover_doc<cr>", "Hover Doc"},
        l = {"<cmd>Lspsaga lsp_finder<cr>", "LSP Finder"},
        L = {"<cmd>Lspsaga show_line_diagnostics<cr>", "Line Diagnostics"},
        p = {"<cmd>Lspsaga preview_definition<cr>", "Preview Definition"},
        r = {"<cmd>Lspsaga rename<cr>", "Rename"},
--        t = {"<cmd>LspTypeDefinition<cr>", "Type Definition"},
        x = {"<cmd>cclose<cr>", "Close Quickfix"},
    },
    t = {
       name = '+Terminal' ,
       [";"] = {"<cmd>FloatermNew --wintype=normal --height=6<cr>"       , "terminal"},
       ["f"] = {"<cmd>FloatermNew fzf<cr>"                               , "fzf"},
       ["g"] = {"<cmd>FloatermNew lazygit<cr>"                           , "git"},
       ["n"] = {"<cmd>FloatermNew node<cr>"                              , "node"},
       ["p"] = {"<cmd>FloatermNew python<cr>"                            , "python"},
       ["t"] = {"<cmd>FloatermToggle<cr>"                                , "toggle"},
       ["k"] = {"<cmd>FloatermKill<cr>"                                  , "kill term"},
    },
    p = {
        name = 'Packer' ,
        ["u"]  = {"<cmd>PackerUpdate<cr>"      ,  'packer update'},
        ["i"]  = {"<cmd>PackerInstall<cr>"     ,  'packer install'},
        ["c"]  = {"<cmd>PackerCompile<cr>"     ,  'packer compile'},
        ["s"]  = {"<cmd>PackerSync<cr>"        ,  'packer sync'},
    },
    S = {name = "+Session", s = {"<cmd>SessionSave<cr>", "Save Session"}, l = {"<cmd>SessionLoad<cr>", "Load Session"}}
}

--local mappings = {
--    --["/"] = "Comment",
--    ["c"] = "Close Buffer",
--    ["e"] = {"<cmd>NvimTreeToggle<cr>"                                 ,"Explorer"},
--    ["F"] = {"<cmd>NvimTreeFindFile<cr>"                               ,"Find Current File"},
--    ["V"] = {"<cmd>Vista<cr>"                                          ,"Vista"},
--    [";"] = {"<cmd>Dashboard<cr>"                                        , "home screen"},
--    ["M"] = {"<cmd>MarkdownPreviewToggle<cr>"                          , "markdown preview"},
--    ["h"] = {"<cmd>let @/ = \"\"<cr>"                                    , "no highlight" },
--    ["T"] = {"<cmd>TSHighlightCapturesUnderCursor<cr>"                 , "treesitter highlight" },
--    ["v"] = {"<C-W>v"                                          , "split right"},
--
--    a = {
--      name= '+actions' ,
--      ['c'] = {"<cmd>ColorizerToggle<cr>"        , 'colorizer'},
--      ['h'] = {"<cmd>let @/ = \"\"<cr>"            , 'remove search highlight'},
--      ['i'] = {"<cmd>IndentBlanklineToggle<cr>"  , 'toggle indent lines'},
--      ['n'] = {"<cmd>set nonumber!<cr>"          , 'line-numbers'},
--      ['r'] = {"<cmd>set norelativenumber!<cr>"  , 'relative line nums'},
--    },
--    f = {
--        name = "+Finder",
--        r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
--        n = { "<cmd>enew<cr>", "New File" },
--        --. = {"<cmd>Telescope filetypes<cr>"                   , "filetypes"},
--        B = {"<cmd>Telescope git_branches<cr>"                , "git branches"},
--        d = {"<cmd>Telescope lsp_document_diagnostics<cr>"    , "document_diagnostics"},
--        D = {"<cmd>Telescope lsp_workspace_diagnostics<cr>"   , "workspace_diagnostics"},
--        f = {"<cmd>Telescope find_files<cr>"                 , "files"},
--        h = {"<cmd>Telescope command_history<cr>"            , "history"},
--        i = {"<cmd>Telescope media_files<cr>"                , "media files"},
--        m = {"<cmd>Telescope marks<cr>"                      , "marks"},
--        M = {"<cmd>Telescope man_pages<cr>"                  , "man_pages"},
--        v = {"<cmd>Telescope vim_options<cr>"                , "vim_options"},
--        a = {"<cmd>Telescope live_grep<cr>"                  , "text"},
--        b = {"<cmd>Telescope file_browser<cr>"               , "file browser"},
--        u = {"<cmd>Telescope colorscheme<cr>"                , "colorschemes"},
--        g = {"<cmd>Telescope git_files<cr>"                  , "git_files"},
--        w = {"<cmd>Telescope grep_string<cr>"                , "grep_string"},
--        o = {"<cmd>Telescope oldfiles<cr>"                   , "oldfiles"},
--        c = {"<cmd>Telescope git_commits<cr>"                , "git_commits"},
--        s = {"<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols"},
--        S = {"<cmd>Telescope lsp_workspace_symbols<cr>", "Workspace Symbols"},
--        q = {"<cmd>Telescope quickfix<cr>", "Quickfix"},
--      },
--
--    b = {
--      name = '+buffer' ,
--      ['>'] = {"<cmd>BufferMoveNext<cr>"        , 'move next'},
--      ['<'] = {"<cmd>BufferMovePrevious<cr>"    , 'move prev'},
--      ['P'] = {"<cmd>BufferPick<cr>"            , 'pick buffer'},
--      ['d'] = {"<cmd>BufferClose<cr>"           , 'delete-buffer'},
--      ['n'] = {"bnext"                  , 'next-buffer'},
--      ['p'] = {"bprevious"              , 'previous-buffer'},
--      ['?'] = {"Buffers"                , 'fzf-buffer'},
--      ['b'] = {"<cmd>Telescope buffers<cr>"                , 'find bufers'},
--    },
--    d = {
--        name = "+Debug",
--        b = {"<cmd>DebugToggleBreakpoint<cr>", "Toggle Breakpoint"},
--        c = {"<cmd>DebugContinue<cr>", "Continue"},
--        i = {"<cmd>DebugStepInto<cr>", "Step Into"},
--        o = {"<cmd>DebugStepOver<cr>", "Step Over"},
--        r = {"<cmd>DebugToggleRepl<cr>", "Toggle Repl"},
--        s = {"<cmd>DebugStart<cr>", "Start"},
--    },
--    g = {
--        name = "+Git",
--        b = {"<cmd>Git blame<cr>", "Git Blame"},
--        d = {"<cmd>Git diff<cr>", "Git Diff"},
--        l = {"<cmd>Git log<cr>", "Git Log"},
--        s = {"<cmd>Git status<cr>", "Git Status"},
--    },
--    l = {
--        name = "+LSP",
--        a = {"<cmd>Lspsaga code_action<cr>", "Code Action"},
--        A = {"<cmd>Lspsaga range_code_action<cr>", "Selected Action"},
----        d = {"<cmd>Telescope lsp_document_diagnostics<cr>", "Document Diagnostics"},
----        D = {"<cmd>Telescope lsp_workspace_diagnostics<cr>", "Workspace Diagnostics"},
----        f = {"<cmd>LspFormatting<cr>", "Format"},
----       i = {"<cmd>LspInfo<cr>", "Info"},
--        l = {"<cmd>Lspsaga lsp_finder<cr>", "LSP Finder"},
--        L = {"<cmd>Lspsaga show_line_diagnostics<cr>", "Line Diagnostics"},
--        p = {"<cmd>Lspsaga preview_definition<cr>", "Preview Definition"},
--        r = {"<cmd>Lspsaga rename<cr>", "Rename"},
----        t = {"<cmd>LspTypeDefinition<cr>", "Type Definition"},
--        x = {"<cmd>cclose<cr>", "Close Quickfix"},
--    },
--    t = {
--       name = '+Terminal' ,
--       [";"] = {"<cmd>FloatermNew --wintype=normal --height=6<cr>"       , "terminal"},
--       ["f"] = {"<cmd>FloatermNew fzf<cr>"                               , "fzf"},
--       ["g"] = {"<cmd>FloatermNew lazygit<cr>"                           , "git"},
--       ["n"] = {"<cmd>FloatermNew node<cr>"                              , "node"},
--       ["p"] = {"<cmd>FloatermNew python<cr>"                            , "python"},
--       ["t"] = {"<cmd>FloatermToggle<cr>"                                , "toggle"},
--       ["k"] = {"<cmd>FloatermKill<cr>"                                  , "kill term"},
--    },
--    p = {
--        name = 'Packer' ,
--        ["u"]  = {"<cmd>PackerUpdate<cr>"      ,  'packer update'},
--        ["i"]  = {"<cmd>PackerInstall<cr>"     ,  'packer install'},
--        ["c"]  = {"<cmd>PackerCompile<cr>"     ,  'packer compile'},
--        ["s"]  = {"<cmd>PackerSync<cr>"        ,  'packer sync'},
--    },
--    S = {name = "+Session", s = {"<cmd>SessionSave<cr>", "Save Session"}, l = {"<cmd>SessionLoad<cr>", "Load Session"}}
--  }

local wk = require("which-key")
wk.register(mappings, opts)
