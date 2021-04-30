local config = {}

local function load_env_file()
  local env_file = os.getenv("HOME")..'/.env'
  local env_contents = {}
  if vim.fn.filereadable(env_file) ~= 1 then
    print('.env file does not exist')
    return
  end
  local contents = vim.fn.readfile(env_file)
  for _,item in pairs(contents) do
    local line_content = vim.fn.split(item,"=")
    env_contents[line_content[1]] = line_content[2]
  end
  return env_contents
end

local function load_dbs()
  local env_contents = load_env_file()
  local dbs = {}
  for key,value in pairs(env_contents) do
    if vim.fn.stridx(key,"DB_CONNECTION_") >= 0 then
      local db_name = vim.fn.split(key,"_")[3]:lower()
      dbs[db_name] = value
    end
  end
  return dbs
end

function config.vim_dadbod_ui()
  if packer_plugins['vim-dadbod'] and not packer_plugins['vim-dadbod'].loaded then
    vim.cmd [[packadd vim-dadbod]]
  end
  vim.g.db_ui_show_help = 0
  vim.g.db_ui_win_position = 'left'
  vim.g.db_ui_use_nerd_fonts = 1
  vim.g.db_ui_winwidth = 35
  vim.g.db_ui_save_location = os.getenv("HOME") .. '/.cache/vim/db_ui_queries'
  vim.g.dbs = load_dbs()
end

function config.vim_vista()
  vim.g['vista#renderer#enable_icon'] = 1
  vim.g.vista_disable_statusline = 1
  vim.g.vista_default_executive = 'ctags'
  vim.g.vista_echo_cursor_strategy = 'floating_win'
  vim.g.vista_vimwiki_executive = 'markdown'
  vim.g.vista_executive_for = {
    vimwiki =  'markdown',
    pandoc = 'markdown',
    markdown = 'toc',
    typescript = 'nvim_lsp',
    typescriptreact =  'nvim_lsp',
  }
end

function config.markdown()
  vim.g.vim_markdown_frontmatter = 1
  vim.g.vim_markdown_strikethrough = 1
  vim.g.vim_markdown_folding_level = 6
  vim.g.vim_markdown_override_foldtext = 1
  vim.g.vim_markdown_folding_style_pythonic = 1
  vim.g.vim_markdown_conceal = 0
  --vim.g.vim_markdown_conceal_code_blocks = 0
  --vim.g.vim_markdown_conceal = 1
  --vim.g.vim_markdown_conceal_code_blocks = 1
  vim.g.vim_markdown_new_list_item_indent = 0
  vim.g.vim_markdown_toc_autofit = 0
  vim.g.vim_markdown_edit_url_in = "vsplit"
  vim.g.vim_markdown_strikethrough = 1
  vim.g.vim_markdown_fenced_languages = {
    "c++=javascript",
    "js=javascript",
    "json=javascript",
    "jsx=javascript",
    "tsx=javascript"
  }
end

function config.mkdp()
  vim.g.mkdp_auto_start = 0
  vim.g.mkdp_command_for_global = 1
  vim.cmd(
    [[let g:mkdp_preview_options = { 'mkit': {}, 'katex': {}, 'uml': {}, 'maid': {}, 'disable_sync_scroll': 0, 'sync_scroll_type': 'middle', 'hide_yaml_meta': 1, 'sequence_diagrams': {}, 'flowchart_diagrams': {}, 'content_editable': v:true, 'disable_filename': 0 }]]
  )
end

function config.whichkey()
    require("which-key").setup {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
          operators = true, -- adds help for operators like d, y, ...
          motions = true, -- adds help for motions
          text_objects = true, -- help for text objects triggered after entering an operator
          windows = true, -- default bindings on <c-w>
          nav = true, -- misc bindings to work with windows
          z = true, -- bindings for folds, spelling and others prefixed with z
          g = true, -- bindings for prefixed with g
        },
      },
      icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+", -- symbol prepended to a group
      },
      window = {
        border = "none", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
      },
      layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 3, -- spacing between columns
      },
      hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "}, -- hide mapping boilerplate
      show_help = true -- show help message on the command line when the popup is visible
  }
  --wk.register(mappings, opts)

  -- Comments
  --vim.api.nvim_set_keymap("n", "<leader>/", ":CommentToggle<CR>", {noremap = true, silent = true})
  --vim.api.nvim_set_keymap("v", "<leader>/", ":CommentToggle<CR>", {noremap = true, silent = true})

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
        name = "+Find File",
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
        d = {"<cmd>Telescope lsp_document_diagnostics<cr>", "Document Diagnostics"},
        D = {"<cmd>Telescope lsp_workspace_diagnostics<cr>", "Workspace Diagnostics"},
        f = {"<cmd>LspFormatting<cr>", "Format"},
        i = {"<cmd>LspInfo<cr>", "Info"},
        l = {"<cmd>Lspsaga lsp_finder<cr>", "LSP Finder"},
        L = {"<cmd>Lspsaga show_line_diagnostics<cr>", "Line Diagnostics"},
        p = {"<cmd>Lspsaga preview_definition<cr>", "Preview Definition"},
        q = {"<cmd>Telescope quickfix<cr>", "Quickfix"},
        r = {"<cmd>Lspsaga rename<cr>", "Rename"},
        t = {"<cmd>LspTypeDefinition<cr>", "Type Definition"},
        x = {"<cmd>cclose<cr>", "Close Quickfix"},
        s = {"<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols"},
        S = {"<cmd>Telescope lsp_workspace_symbols<cr>", "Workspace Symbols"},
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
  local opts = {
    mode = "n", -- NORMAL mode
    -- prefix: use "<leader>f" for example for mapping everything related to finding files
    -- the prefix is prepended to every mapping part of `mappings`
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false -- use `nowait` when creating keymaps
  }
  local wk = require("which-key")
  wk.register(mappings, opts)
end

return config
