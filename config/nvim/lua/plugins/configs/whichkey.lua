local which_key = require("which-key")
local Utils = require("utils")

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

local options = {
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "  ", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>", -- binding to scroll up inside the popup
  },
  window = {
    border = "none", -- none/single/double/shadow
  },
  layout = {
    spacing = 6, -- spacing between columns
  },

  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },

  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    i = { "j", "k" },
    v = { "j", "k" },
  },

  show_help = true, -- show help message on the command line when the popup is visible
  disable = {
    filetypes = { "TelescopePrompt", "neo-tree" },
  },
}

which_key.setup(options)

local opts = {
  mode = { "n", "v" }, -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false, -- use `nowait` when creating keymaps
}

local mappings = {
  --["/"] = "Comment",
  --["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
  ["e"] = {
    function()
      require("neo-tree.command").execute({ toggle = true, dir = Utils.get_root() })
    end,
    "Explorer" },
  --["F"] = { "<cmd>NvimTreeFindFile<cr>", "Find Current File" },
  ["F"] = {
    function()
      require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
    end,
    "Find Current File" },
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
    D = { "<cmd>Telescope diagnostics bufnr=0<cr>", "document_diagnostics" },
    d = { "<cmd>Telescope diagnostics<cr>", "workspace_diagnostics" },
    --f = {"<cmd>Telescope find_files <cr>"                 , "files"},
    f = { "<cmd>Telescope find_files follow=true no_ignore=true hidden=true <cr>", "files" },
    h = { "<cmd>Telescope command_history<cr>", "history" },
    a = { "<cmd>Telescope live_grep<cr>", "live grep" },
    b = { "<cmd>Telescope file_browser<cr>", "file browser" },
    u = { "<cmd>Telescope colorscheme<cr>", "colorschemes" },
    w = { "<cmd>Telescope grep_string<cr>", "grep_string" },
    o = { "<cmd>Telescope oldfiles<cr>", "oldfiles" },
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
    S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols" },
    --        ["<leader>pt"] = { "<cmd> Telescope terms <CR>", "   pick hidden term" },
    q = { "<cmd>Telescope quickfix<cr>", "Quickfix" },
    t = { "<cmd>TodoTelescope<cr>", "Find TODO" },
    T = { "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
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
    ["b"] = { "<cmd>Telescope buffers<cr>", "find bufers" },

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

      "Jump to current_context",
    },
  },
  g = {
    name = "+Git",
    b = { "<cmd>Git blame<cr>", "Git Blame" },
    d = { "<cmd>Git diff<cr>", "Git Diff" },
    l = { "<cmd>Git log<cr>", "Git Log" },
    s = { "<cmd>Git status<cr>", "Git Status" },

    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    B = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    f = { "<cmd>Telescope git_files<cr>", "git_files" },

    g = { function() Utils.float_term({ "lazygit" }, { cwd = Utils.get_root(), esc_esc = false }) end, "Lazygit (root dir)" },
    G = { function() Utils.float_term({ "lazygit" }, { esc_esc = false }) end, "Lazygit (cwd)" },

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
    l = { "<cmd>ToggleLspVirtualLine<cr>", "Lsp Lines" },
    --r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", "Quickfix" },
    t = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Type Definition" },
    x = { "<cmd>cclose<cr>", "Close Quickfix" },
    r = {
      function()
        --TODO: can use this tiny plugin https://github.com/smjonas/inc-rename.nvim
        --if require("lazyvim.util").has("inc-rename.nvim") then
        --  M._keys[#M._keys + 1] = {
        --    "<leader>cr",
        --    function()
        --      local inc_rename = require("inc_rename")
        --      return ":" .. inc_rename.config.cmd_name .. " " .. vim.fn.expand("<cword>")
        --    end,
        --    expr = true,
        --    desc = "Rename",
        --    has = "rename",
        --  }
        --else
        --  M._keys[#M._keys + 1] = { "<leader>cr", vim.lsp.buf.rename, desc = "Rename", has = "rename" }
        --end
        vim.lsp.buf.rename.float()
      end,
      "lsp rename",
    },
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
  ["<C-x>"] = { "<cmd>Bdelete<cr>", "close buffer" },
  ["<ESC>"] = { "<cmd> noh <CR>", "no highlight" },
  --["<M-[>"] = { "<cmd>vertical resize -2<CR>", "vertical resize -2" },
  --["<M-]>"] = { "<cmd>vertical resize +2<CR>", "vertical resize +2" },
  ["<M-[>"] = { "<cmd>lua require('smart-splits').resize_left(amount)<CR>", "vertical resize -2" },
  ["<M-]>"] = { "<cmd>lua require('smart-splits').resize_right(amount)<CR>", "vertical resize +2" },

  -- cycle through buffers
  ["<TAB>"] = { "<cmd> BufferLineCycleNext <CR>", "cycle next buffer" },
  ["<S-Tab>"] = { "<cmd> BufferLineCyclePrev <CR>", "cycle prev buffer" },
  ["<S-b>"] = { "<cmd> enew <CR>", "new buffer" },

  ["<F5>"] = { "<cmd>lua require'dap'.continue()<CR>", "dap continue" },
  ["<F10>"] = { "<cmd>lua require'dap'.step_over()<CR>", "dap step over" },
  ["<F11>"] = { "<cmd>lua require'dap'.step_into()<CR>", "dap step into" },
  ["<F12>"] = { "<cmd>lua require'dap'.step_out()<CR>", "dap step out" },
  ["<leader>/"] = {
    function()
      require("Comment.api").toggle.linewise.current()
    end,

    "toggle comment",
  },
}

local misc_v_opts = {
  mode = "v", -- NORMAL mode
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  -- noremap = true, -- use `noremap` when creating keymaps
  nowait = false, -- use `nowait` when creating keymaps
}
local misc_v_mapping = {
  ["<leader>/"] = {
    "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
    "toggle comment",
  },
}

map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })

local wk = require("which-key")

wk.register(misc_n_mapping, misc_n_opts)
wk.register(misc_v_mapping, misc_v_opts)

wk.register(mappings, opts)
