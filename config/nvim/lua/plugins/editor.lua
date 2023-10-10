local Util = require "utils"

local plugins = {

  ---- Easily speed up your neovim startup time!
  "nathom/filetype.nvim",

  -- Lua functions
  "nvim-lua/plenary.nvim",

  -- lsp signature 展示
  -- 或者试试 nvim_lsp_signature_help
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    enabled = true,
    dependencies = "nvim-lspconfig",
    opts = {
      bind = true,
      doc_lines = 0,
      floating_window = true,
      fix_pos = true,
      hint_enable = false,
      hint_prefix = "󰘎 ",
      hint_scheme = "String",
      hi_parameter = "Search",
      max_height = 22,
      max_width = 10,      -- max_width of signature floating_window, line will be wrapped if exceed max_width
      handler_opts = {
        border = "single", -- double, single, shadow, none
      },
      zindex = 200,        -- by default it will be on top of all floating windows, set to 50 send it to bottom
      padding = "",        -- character to pad on left and right of signature can be ' ', or '|'  etc
    },
  },

  -- Smarter Splits
  {
    "mrjones2014/smart-splits.nvim",
    module = "smart-splits",
    opts = {
      {
        ignored_filetypes = {
          "nofile",
          "quickfix",
          "qf",
          "prompt",
        },
        ignored_buftypes = { "nofile" },
      },
    },
    --    config = function() require "plugins.configs.smart-splits" end,
  },

  -- automatically highlighting other uses of the word under the cursor
  {
    "RRethy/vim-illuminate",
    event = "LazyFile",
    opts = {
      delay = 200,
      large_file_cutoff = 2000,
      large_file_overrides = {
        providers = {
          "lsp",
          --   "treesitter",
        },
      },
    },
    config = function(_, opts)
      require("illuminate").configure(opts)
      --vim.api.nvim_set_hl(0, "IlluminatedWordText", { ctermbg = "237", guibg = "#374145" })
      --vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "IlluminatedWordText" })
      --vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "IlluminatedWordText" })
      --local illuminate_bg = string.format("#%06x", vim.api.nvim_get_hl_by_name("Visual", true).background)
      --vim.api.nvim_set_hl(0, "IlluminatedWordText", { bg = illuminate_bg })
      --vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bg = illuminate_bg })
      --vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bg = illuminate_bg })
      --local ILLUMINATION = { bg = "#383D47" }
      --vim.api.nvim_set_hl(0, "IlluminatedWordText", ILLUMINATION)
      --vim.api.nvim_set_hl(0, "IlluminatedWordRead", ILLUMINATION)
      --vim.api.nvim_set_hl(0, "IlluminatedWordWrite", ILLUMINATION)
      --vim.api.nvim_set_hl(0, "@illuminate", ILLUMINATION)
      local function map(key, dir, buffer)
        vim.keymap.set(
          "n",
          key,
          function() require("illuminate")["goto_" .. dir .. "_reference"](false) end,
          { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer }
        )
      end

      map("]]", "next")
      map("[[", "prev")

      -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          local buffer = vim.api.nvim_get_current_buf()
          map("]]", "next", buffer)
          map("[[", "prev", buffer)
        end,
      })
    end,
    keys = {
      { "]]", desc = "Next Reference" },
      { "[[", desc = "Prev Reference" },
    },
    enabled = true,
  },

  ---- Better buffer closing
  --{
  --  "famiu/bufdelete.nvim",
  --  module = "bufdelete",
  --  cmd = { "Bdelete", "Bwipeout" },
  --},

  -- Fuzzy finder.
  -- The default key bindings to find files will use Telescope's
  -- `find_files` or `git_files` depending on whether the
  -- directory is a git repo.
  {
    "nvim-telescope/telescope.nvim",
    commit = vim.fn.has "nvim-0.9.0" == 0 and "057ee0f8783" or nil,
    cmd = "Telescope",
    version = false,
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        enabled = vim.fn.executable("make") == 1,
        config = function()
          Util.on_load("telescope.nvim", function()
            require("telescope").load_extension("fzf")
          end)
        end,
      },
    },

    keys = {
      { "<leader>,", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
      { "<leader>/", Util.telescope "live_grep",                         desc = "Grep (root dir)" },
      { "<leader>:", "<cmd>Telescope command_history<cr>",               desc = "Command History" },
      {
        "<leader><space>",
        Util.telescope "files",
        desc = "Find Files (root dir)",
      },
      -- find
      { "<leader>bb", "<cmd>Telescope buffers<cr>",                         desc = "Buffers" },
      {
        "<leader>ff",
        Util.telescope "files",
        desc = "Find Files (root dir)",
      },
      { "<leader>fa", "<cmd>Telescope live_grep<cr>",                       desc = "Live Grep" },
      { "<leader>fF", Util.telescope("files", { cwd = false }),             desc = "Find Files (cwd)" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>",                        desc = "Recent" },
      { "<leader>fR", Util.telescope("oldfiles", { cwd = vim.loop.cwd() }), desc = "Recent (cwd)" },
      -- git
      { "<leader>gc", "<cmd>Telescope git_commits<CR>",                     desc = "commits" },
      { "<leader>gs", "<cmd>Telescope git_status<CR>",                      desc = "status" },
      { "<leader>go", "<cmd>Telescope git_status<cr>",                      desc = "Open changed file" },
      { "<leader>gB", "<cmd>Telescope git_branches<cr>",                    desc = "Checkout branch" },
      { "<leader>gf", "<cmd>Telescope git_files<cr>",                       desc = "git_files" },

      -- search
      { '<leader>s"', "<cmd>Telescope registers<cr>",                       desc = "Registers" },
      { "<leader>sa", "<cmd>Telescope autocommands<cr>",                    desc = "Auto Commands" },
      { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>",       desc = "Buffer" },
      { "<leader>sc", "<cmd>Telescope command_history<cr>",                 desc = "Command History" },
      { "<leader>sC", "<cmd>Telescope commands<cr>",                        desc = "Commands" },
      {
        "<leader>sd",
        "<cmd>Telescope diagnostics bufnr=0<cr>",
        desc = "Document diagnostics",
      },
      {
        "<leader>sD",
        "<cmd>Telescope diagnostics<cr>",
        desc = "Workspace diagnostics",
      },
      { "<leader>sg", Util.telescope "live_grep",                   desc = "Grep (root dir)" },
      { "<leader>sG", Util.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
      { "<leader>sh", "<cmd>Telescope help_tags<cr>",               desc = "Help Pages" },
      {
        "<leader>sH",
        "<cmd>Telescope highlights<cr>",
        desc = "Search Highlight Groups",
      },
      { "<leader>sk", "<cmd>Telescope keymaps<cr>",                                      desc = "Key Maps" },
      { "<leader>sM", "<cmd>Telescope man_pages<cr>",                                    desc = "Man Pages" },
      { "<leader>sm", "<cmd>Telescope marks<cr>",                                        desc = "Jump to Mark" },
      { "<leader>so", "<cmd>Telescope vim_options<cr>",                                  desc = "Options" },
      { "<leader>sR", "<cmd>Telescope resume<cr>",                                       desc = "Resume" },
      { "<leader>sw", Util.telescope("grep_string", { word_match = "-w" }),              desc = "Word (root dir)" },
      { "<leader>sW", Util.telescope("grep_string", { cwd = false, word_match = "-w" }), desc = "Word (cwd)" },
      {
        "<leader>sw",
        Util.telescope "grep_string",
        mode = "v",
        desc = "Selection (root dir)",
      },
      {
        "<leader>sW",
        Util.telescope("grep_string", { cwd = false }),
        mode = "v",
        desc = "Selection (cwd)",
      },
      {
        "<leader>uC",
        Util.telescope("colorscheme", { enable_preview = true }),
        desc = "Colorscheme with preview",
      },
      {
        "<leader>ss",
        Util.telescope("lsp_document_symbols", {
          symbols = {
            "Class",
            "Function",
            "Method",
            "Constructor",
            "Interface",
            "Module",
            "Struct",
            "Trait",
            "Field",
            "Property",
            "Enum",
            "Constant",
          },
        }),
        desc = "Goto Symbol",
      },
      {
        "<leader>sS",
        Util.telescope("lsp_dynamic_workspace_symbols", {
          symbols = {
            "Class",
            "Function",
            "Method",
            "Constructor",
            "Interface",
            "Module",
            "Struct",
            "Trait",
            "Field",
            "Property",
            "Enum",
            "Constant",
          },
        }),
        desc = "Goto Symbol (Workspace)",
      },
    },
    config = function() require "plugins.configs.telescope" end,
  },

  -- Smooth escaping
  {
    "max397574/better-escape.nvim",
    enabled = false,
    event = "InsertCharPre",
    opts = {
      mapping = { "jk" },
      timeout = 300,
      clear_empty_lines = false, -- clear line after escaping if there is only whitespace
      keys = "<Esc>",
    },
  },

  -- copilot
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    opts = {
      suggestion = { enabled = false },
      --suggestion = {
      --  enabled = true,
      --  auto_trigger = false,
      --  debounce = 75,
      --  keymap = {
      --    accept = "<M-l>",
      --    accept_word = false,
      --    accept_line = false,
      --    next = "<M-]>",
      --    prev = "<M-[>",
      --    dismiss = "<C-]>",
      --  },
      --},
      panel = { enabled = false },
    },
  },

  {
    "jackMort/ChatGPT.nvim",
    enabled = false,
    event = "VeryLazy",
    config = function() require("chatgpt").setup() end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },
  -- better text-objects
  {
    "echasnovski/mini.ai",
    enabled = true,
    event = "VeryLazy",
    opts = function()
      local ai = require "mini.ai"
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }, {}),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
          t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
        },
      }
    end,
    config = function(_, opts)
      require("mini.ai").setup(opts)
      -- register all text objects with which-key
      require("utils").on_load("which-key.nvim", function()
        ---@type table<string, string|table>
        local i = {
          [" "] = "Whitespace",
          ['"'] = 'Balanced "',
          ["'"] = "Balanced '",
          ["`"] = "Balanced `",
          ["("] = "Balanced (",
          [")"] = "Balanced ) including white-space",
          [">"] = "Balanced > including white-space",
          ["<lt>"] = "Balanced <",
          ["]"] = "Balanced ] including white-space",
          ["["] = "Balanced [",
          ["}"] = "Balanced } including white-space",
          ["{"] = "Balanced {",
          ["?"] = "User Prompt",
          _ = "Underscore",
          a = "Argument",
          b = "Balanced ), ], }",
          c = "Class",
          f = "Function",
          o = "Block, conditional, loop",
          q = "Quote `, \", '",
          t = "Tag",
        }
        local a = vim.deepcopy(i)
        for k, v in pairs(a) do
          a[k] = v:gsub(" including.*", "")
        end
        local ic = vim.deepcopy(i)
        local ac = vim.deepcopy(a)
        for key, name in pairs { n = "Next", l = "Last" } do
          i[key] = vim.tbl_extend("force", { name = "Inside " .. name .. " textobject" }, ic)
          a[key] = vim.tbl_extend("force", { name = "Around " .. name .. " textobject" }, ac)
        end
        require("which-key").register {
          mode = { "o", "x" },
          i = i,
          a = a,
        }
      end)
    end,
  },

  -- buffer remove
  {
    "echasnovski/mini.bufremove",
    keys = {
      {
        "<leader>bd",
        function()
          local bd = require("mini.bufremove").delete
          if vim.bo.modified then
            local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
            if choice == 1 then -- Yes
              vim.cmd.write()
              bd(0)
            elseif choice == 2 then -- No
              bd(0, true)
            end
          else
            bd(0)
          end
        end,
        desc = "Delete Buffer",
      },
      -- stylua: ignore
      { "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
    },
  },

  {
    "nvim-tree/nvim-tree.lua",
    --after = "nvim-web-devicons",
    ft = "alpha",
    event = "VimEnter",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    --cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    config = function()
      --require("plugins.configs.nvimtree").config()
      require "plugins.configs.nvimtree"
    end,
    enabled = false,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = { "Neotree", "NeotreeLogs" },
    version = "3.*",
    enabled = true,
    dependencies = {
      {
        "s1n7ax/nvim-window-picker",
        --"tinytub/nvim-window-picker",
        version = "v2.*",
        opts = {
          --hint = "floating-big-letter",
          statusline_winbar_picker = {
            use_winbar = "smart",
          },
          filter_rules = {
            autoselect_one = true,
            include_current_win = false,
            bo = {
              filetype = { "neo-tree", "neo-tree-popup", "notify", "quickfix", "edgy", "noice" },
              buftype = { "terminal", "quickfix" },
            },
          },
          --         other_win_hl_color = "#e35e4f",
        },
        config = function(_, opts) require("window-picker").setup(opts) end,
      },
    },
    keys = {
      {
        "<leader>fe",
        function() require("neo-tree.command").execute { toggle = true, dir = require("utils").get_root() } end,
        desc = "Explorer NeoTree (root dir)",
      },
      {
        "<leader>fE",
        function() require("neo-tree.command").execute { toggle = true, dir = vim.loop.cwd() } end,
        desc = "Explorer NeoTree (cwd)",
      },
      { "<leader>e", "<leader>fe", desc = "Explorer NeoTree (root dir)", remap = true },
      { "<leader>E", "<leader>fE", desc = "Explorer NeoTree (cwd)",      remap = true },
    },

    deactivate = function() vim.cmd [[Neotree close]] end,
    init = function()
      if vim.fn.argc() == 1 then
        local stat = vim.loop.fs_stat(vim.fn.argv(0))
        if stat and stat.type == "directory" then require "neo-tree" end
      end
    end,
    opts = {
      sources = { "filesystem", "buffers", "git_status", "document_symbols" },
      open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "Outline" },
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
      },
      window = {
        mappings = {
          ["<space>"] = "none",
          ["<c-x>"] = "split_with_window_picker",
          ["<c-v>"] = "vsplit_with_window_picker",
          ["l"] = "open_with_window_picker",
          ["<cr>"] = "open_drop",
        },
      },
      document_symbols = {
        follow_cursor = true,
        renderers = {
          symbol = {
            { "indent",    with_expanders = true },
            { "kind_icon", default = "?" },
            { "name",      zindex = 10 },
            -- removed the kind text as its redundant with the icon
          },
        },
      },
      default_component_configs = {
        indent = {
          with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },
      },
    },
    config = function(_, opts)
      local function on_move(data) Util.on_rename(data.source, data.destination) end

      local events = require "neo-tree.events"
      opts.event_handlers = opts.event_handlers or {}
      vim.list_extend(opts.event_handlers, {
        { event = events.FILE_MOVED,   handler = on_move },
        { event = events.FILE_RENAMED, handler = on_move },
      })
      -- some from https://github.com/CKolkey/config/blob/master/nvim/lua/plugins/neo-tree.lua
      -- Enable a strong cursorline.
      local function set_cursorline()
        vim.wo.winhighlight = "CursorLine:WildMenu"
        vim.wo.cursorline = true
        vim.o.signcolumn = "auto"
      end

      -- Find previous neo-tree window and clear bright highlight selection.
      -- Don't hide cursorline though, so 'follow_current_file' works.
      local function reset_cursorline()
        local winid = vim.fn.win_getid(vim.fn.winnr "#")
        vim.api.nvim_win_set_option(winid, "winhighlight", "")
      end

      --require("plugins.configs.neotree").setup(opts)

      opts = vim.tbl_deep_extend("force", {
        event_handlers = { -- {{{
          { event = "neo_tree_buffer_enter", handler = set_cursorline },
          { event = "neo_tree_buffer_leave", handler = reset_cursorline },
        },
      }, opts or {})

      require("neo-tree").setup(opts)

      vim.api.nvim_create_autocmd("TermClose", {
        pattern = "*lazygit",
        callback = function()
          if package.loaded["neo-tree.sources.git_status"] then require("neo-tree.sources.git_status").refresh() end
        end,
      })
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    event = "LazyFile",
    enabled = true,
    --cond = function()
    --   return vim.fn.isdirectory ".git" == 1
    --end,
    opts = {
      --numhl         = false,
      watch_gitdir = {
        interval = 100,
      },
      sign_priority = 5,
      signs = {
        add = { text = "▎" }, -- catppuccin
        change = { text = "▎" }, -- catppuccin
        --add          = { text = "▐" },
        --change       = { text = "▐" },
        --topdelete = { text = "契" }, -- catppuccin
        --delete       = { text = "▎" }, -- catppuccin
        --topdelete    = { text = "▔" }, -- catppuccin
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" }, -- catppuccin
        untracked = { text = "▎" }, -- catppuccin
      },
      --current_line_blame           = false,
      --current_line_blame_formatter = "<author>:<author_time:%Y-%m-%d> - <summary>",
      --current_line_blame_opts      = {
      --  virt_text         = true,
      --  -- virt_text_pos     = "right_align",
      --  virt_text_pos     = "eol",
      --  delay             = 1000,
      --  ignore_whitespace = true,
      --},
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns
        local function map(mode, l, r, desc) vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc }) end
        -- stylua: ignore start
        map("n", "]h", gs.next_hunk, "Next Hunk")
        map("n", "[h", gs.prev_hunk, "Prev Hunk")
        map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
        map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<leader>ghd", gs.diffthis, "Diff This")
        map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end,
    },
    --config = function() require("plugins.configs.gitsigns").config() end,
    --init = function()
    --  -- load gitsigns only when a git file is opened
    --  vim.api.nvim_create_autocmd({ "BufRead" }, {
    --    group = vim.api.nvim_create_augroup("GitSignslazy_load", { clear = true }),
    --    callback = function()
    --      vim.fn.system("git -C " .. '"' .. vim.fn.expand "%:p:h" .. '"' .. " rev-parse")
    --      if vim.v.shell_error == 0 then
    --        vim.api.nvim_del_augroup_by_name "GitSignslazy_load"
    --        vim.schedule(function() require("lazy").load { plugins = "gitsigns.nvim" } end)
    --      end
    --    end,
    --  })
    --end,
  },

  {
    "echasnovski/mini.starter",
    --optional = false,
    opts = function(_, opts)
      local items = {
        {
          name = "Projects",
          action = "Telescope projects",
          section = string.rep(" ", 22) .. "Telescope",
        },
      }
      vim.list_extend(opts.items, items)
    end,
  },

  -- matchup 高亮显示光标所在位置对应的括号,函数等
  --{
  --  "andymass/vim-matchup",
  --  event = "CursorMoved",
  --  --opt = true,
  --  config = function()
  --    require("plugins.configs.matchup").config()
  --  end,
  --  enabled = true,
  --},

  -- surround
  {
    "echasnovski/mini.surround",
    keys = function(_, keys)
      -- Populate the keys based on the user's options
      local plugin = require("lazy.core.config").spec.plugins["mini.surround"]
      local opts = require("lazy.core.plugin").values(plugin, "opts", false)
      local mappings = {
        { opts.mappings.add,            desc = "Add surrounding",                     mode = { "n", "v" } },
        { opts.mappings.delete,         desc = "Delete surrounding" },
        { opts.mappings.find,           desc = "Find right surrounding" },
        { opts.mappings.find_left,      desc = "Find left surrounding" },
        { opts.mappings.highlight,      desc = "Highlight surrounding" },
        { opts.mappings.replace,        desc = "Replace surrounding" },
        { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
      }
      mappings = vim.tbl_filter(function(m) return m[1] and #m[1] > 0 end, mappings)
      return vim.list_extend(mappings, keys)
    end,
    opts = {
      mappings = {
        add = "gsa",            -- Add surrounding in Normal and Visual modes
        delete = "gsd",         -- Delete surrounding
        find = "gsf",           -- Find surrounding (to the right)
        find_left = "gsF",      -- Find surrounding (to the left)
        highlight = "gsh",      -- Highlight surrounding
        replace = "gsr",        -- Replace surrounding
        update_n_lines = "gsn", -- Update `n_lines`
      },
    },
  },

  -- 直接跳到数字
  {
    "nacro90/numb.nvim",
    --event = "BufRead",
    config = function()
      require("numb").setup {
        show_numbers = true,    -- Enable 'number' for the window while peeking
        show_cursorline = true, -- Enable 'cursorline' for the window while peeking
      }
    end,
    enabled = true,
  },
  -- Better quickfix
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    cmd = "BqfAutoToggle",
    event = "QuickFixCmdPost",
    config = function() require "plugins.configs.nvim-bqf" end,
    enabled = true,
  },

  -- Terminal
  {
    "akinsho/toggleterm.nvim",
    --commit = commit.toggleterm,

    optional = false,
    event = "BufWinEnter",
    opts = {
      -- size can be a number or function which is passed the current terminal
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = [[<c-\>]],
      hide_numbers = true, -- hide the number column in toggleterm buffers
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,       -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
      start_in_insert = true,
      insert_mappings = true,   -- whether or not the open mapping applies in insert mode
      persist_size = false,
      direction = "horizontal", --'vertical' | 'horizontal' | 'window' | 'float'
      close_on_exit = true,     -- close the terminal window when the process exits
      shell = vim.o.shell,      -- change the default shell
      -- This field is only relevant if direction is set to 'float'
      float_opts = {
        -- The border key is *almost* the same as 'nvim_open_win'
        -- see :h nvim_open_win for details on borders however
        -- the 'curved' border is a custom border type
        -- not natively supported but implemented in this plugin.
        border = "rounded",
        --winblend = 0,
        --highlights = {
        --  border = "Normal",
        --  background = "Normal",
        --}
      },
      execs = {
        { "lazygit", "gg", "LazyGit" },
      },
    },
    --disable = not lvim.builtin.terminal.active,
  },

  -- Markdown preview
  {
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
    ft = "markdown",
    event = "BufRead",
  },

  -- LSP Colors
  {
    "folke/lsp-colors.nvim",
    event = "BufRead",
    enabled = true,
  },
  -- Lazygit
  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
    enabled = false,
  },
  {
    "jose-elias-alvarez/typescript.nvim",
  },

  -- smooth scroll
  {
    "psliwka/vim-smoothie",
    event = "VeryLazy",
    enabled = false,
  },
  {
    "karb94/neoscroll.nvim",
    enabled = true,
    --        event = "WinScrolled",
    config = function() require("neoscroll").setup() end,
    event = "VeryLazy",
  },

  -- Add Flash
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    vscode = true,
    ---@type Flash.Config
    opts = {
      search = {
        -- search/jump in all windows
        multi_window = false,
        -- search direction
        forward = true,
        warp = false,
      },
      modes = {
        -- treesitter = {
        --   label = {
        --     rainbow = { enabled = true },
        --   },
        -- },
        char = {
          jump_labels = false,
        },
        treesitter_search = {
          label = {
            rainbow = { enabled = true },
          },
        },
      },
    },
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash" },
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o",               function() require("flash").remote() end,     desc = "Remote Flash" },
      {
        "R",
        mode = { "o", "x" },
        function() require("flash").treesitter_search() end,
        desc =
        "Treesitter Search"
      },
      {
        "<c-s>",
        mode = { "c" },
        function() require("flash").toggle() end,
        desc =
        "Toggle Flash Search"
      },
    },
  },

  {
    enabled = false,
    "unblevable/quick-scope",
    config = function() require("plugins.configs.others").quickscope() end,
  },

  -- Git
  {
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
    keys = {
      { "<leader>gb", "<cmd>Git blame<cr>",  desc = "Git Blame" },
      { "<leader>gd", "<cmd>Git diff<cr>",   desc = "Git Diff" },
      { "<leader>gl", "<cmd>Git log<cr>",    desc = "Git Log" },
      { "<leader>gs", "<cmd>Git status<cr>", desc = "Git Status" },
      {
        "<leader>gg",
        function() Util.float_term({ "lazygit" }, { cwd = Util.get_root(), esc_esc = false, ctrl_hjkl = false }) end,
        desc = "Lazygit (root dir)",
      },
      {
        "<leader>gG",
        function() Util.float_term({ "lazygit" }, { esc_esc = false, ctrl_hjkl = false }) end,
        desc = "Lazygit (cwd)",
      },
    },
  },

  {
    "vim-test/vim-test",
    event = "BufRead",
    config = function()
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
      vim.g["test#preserve_screen"] = 1
      vim.g["test#go#runner"] = "gotest"
      vim.g["test#go#gotest#options"] = "-v --count=1"
      vim.g["test#echo_command"] = 1
    end,
    enabled = true,
  },

  {
    "folke/trouble.nvim",

    cmd = { "Trouble", "TroubleToggle" },
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>",  desc = "Document Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
      { "<leader>xL", "<cmd>TroubleToggle loclist<cr>",               desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>",              desc = "Quickfix List (Trouble)" },
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").previous { skip_groups = true, jump = true }
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then vim.notify(err, vim.log.levels.ERROR) end
          end
        end,
        desc = "Previous trouble/quickfix item",
      },
      {
        "]q",
        function()
          if require("trouble").is_open() then
            require("trouble").next { skip_groups = true, jump = true }
          else
            local ok, err = pcall(vim.cmd.cnext)
            if not ok then vim.notify(err, vim.log.levels.ERROR) end
          end
        end,
        desc = "Next trouble/quickfix item",
      },
    },
    config = function() require "plugins.configs.nvim-trouble" end,
    enabled = true,
  },

  -- 注释工具
  {
    "numToStr/Comment.nvim",
    --keys = { "gc", "gb" },
    --config = override_req("nvim_comment", "(plugins.configs.configs.others).comment()"),
    opts = {
      padding = true, -- Add a space b/w comment and the line
      sticky = true,  -- Whether the cursor should stay at its position

      -- We define all mappings manually to support neovim < 0.7
      mappings = {
        basic = false,    -- Includes `gcc`, `gbc`, `gc[count]{motion}` and `gb[count]{motion}`
        extra = false,    -- Includes `gco`, `gcO`, `gcA`
        extended = false, -- Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
      },
    },
    --config = function()
    --  require("plugins.configs.others").comment()
    --end,
    enabled = false,
  },

  -- Displays a popup with possible key bindings of the command you started typing
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    --keys = { "<leader>", '"', "'", "`", "c", "v" },
    opts = {
      triggers_blacklist = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        i = { "j", "k" },
        v = { "j", "k" },
      },

      show_help = true, -- show help message on the command line when the popup is visible
      disable = {
        filetypes = { "TelescopePrompt", "neo-tree" },
      },

      hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },
      plugins = { spelling = true },
      defaults = {
        mode = { "n", "v" },
        ["g"] = { name = "+goto" },
        ["gs"] = { name = "+surround" },
        ["<leader>v"] = { "<C-W>v", "split right" },
        ["]"] = { name = "+next" },
        ["["] = { name = "+prev" },
        ["<leader><tab>"] = { name = "+tabs" },
        ["<leader>b"] = { name = "+buffer" },
        ["<leader>c"] = { name = "+code" },
        ["<leader>f"] = { name = "+file/find" },
        ["<leader>g"] = { name = "+git" },
        ["<leader>gh"] = { name = "+hunks" },
        ["<leader>q"] = { name = "+quit/session" },
        ["<leader>s"] = { name = "+search" },
        ["<leader>t"] = { name = "+test" },
        ["<leader>u"] = { name = "+ui" },
        ["<leader>w"] = { name = "+windows" },
        ["<leader>x"] = { name = "+diagnostics/quickfix" },
      },
      misc_n = {
        mode = { "n" },
        ["<C-x>"] = { function() require("mini.bufremove").delete(0, false) end, "Delete Buffer" },
        ["<ESC>"] = { "<cmd> noh <CR>", "no highlight" },
        ["<M-[>"] = { "<cmd>lua require('smart-splits').resize_left(amount)<CR>", "vertical resize -2" },
        ["<M-]>"] = { "<cmd>lua require('smart-splits').resize_right(amount)<CR>", "vertical resize +2" },
        ["<TAB>"] = { "<cmd> BufferLineCycleNext <CR>", "cycle next buffer" },
        ["<S-Tab>"] = { "<cmd> BufferLineCyclePrev <CR>", "cycle prev buffer" },
      },
    },
    --module = "which-key",
    --config = function() require "plugins.configs.whichkey" end,
    config = function(_, opts)
      local wk = require "which-key"
      wk.setup(opts)
      wk.register(opts.defaults)
      wk.register(opts.misc_n)
    end,
    --cond = function() return not vim.g.vscode end,
  },
}

return plugins
