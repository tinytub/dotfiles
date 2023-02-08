-- some from https://github.com/CKolkey/config/blob/master/nvim/lua/plugins/neo-tree.lua
-- some from LazyVim
require("neo-tree").setup({
  log_level            = "error",
  log_to_file          = true,
  close_if_last_window = true,
  popup_border_style   = "rounded",
  hide_root_node       = true,
  enable_git_status    = true,
  enable_diagnostics   = false,


  default_component_configs = { -- {{{
    indent = {
      indent_size        = 2,
      padding            = 0,
      with_expanders     = nil,
      with_markers       = true,
      indent_marker      = "│ ",
      last_indent_marker = "╰─ ",
      highlight          = "NeoTreeIndentMarker",
    },
    name = {
      trailing_slash = true,
      use_git_status_colors = true,
    },

    diagnostics = {
      symbols = {
        hint = "",
        info = " ",
        warn = " ",
        error = " ",
      },
      highlights = {
        hint = "DiagnosticSignHint",
        info = "DiagnosticSignInfo",
        warn = "DiagnosticSignWarn",
        error = "DiagnosticSignError",
      },
    },
    modified = {
      symbol = " ",
      highlight = "NeoTreeModified",
    },
    git_status = {
      symbols = {
        -- added = "",
        -- conflict = "",
        -- deleted = "",
        -- ignored = "◌",
        -- renamed = "➜",
        -- staged = "✓",
        -- unmerged = "",
        -- unstaged = "",
        -- untracked = "★",
        status_added    = " ",
        status_removed  = " ",
        status_modified = " ",
        added           = " ",
        deleted         = " ",
        modified        = " ",
        renamed         = " ",
        untracked       = " ",
        ignored         = " ",
        unstaged        = " ",
        staged          = " ",
        conflict        = " ",
      },
    },
  }, -- }}}


  window = {
    width = 30,
    mappings = { -- {{{
      ["<c-v>"] = "open_vsplit",
      ["l"] = "open",
      ["<cr>"] = "open_drop",
      ["t"] = "open_tab_drop",
      ["<tab>"] = { "toggle_preview", config = { use_float = false } },

      ["h"] = function(state)
        local node = state.tree:get_node()
        if node.type == "directory" and node:is_expanded() then
          require("neo-tree.sources.filesystem").toggle_directory(state, node)
        else
          require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
        end
      end,
      ["e"] = function()
        vim.api.nvim_exec("Neotree focus filesystem left", true)
      end,
      ["b"] = function()
        vim.api.nvim_exec("Neotree focus buffers left", true)
      end,
      ["g"] = function()
        vim.api.nvim_exec("Neotree focus git_status left", true)
      end,

      ["o"] = function(state)
        local node = state.tree:get_node()
        if node and node.type == "file" then
          local file_path = node:get_id()
          -- reuse built-in commands to open and clear filter
          local cmds = require("neo-tree.sources.filesystem.commands")
          cmds.open(state)
          cmds.clear_filter(state)
          -- reveal the selected file without focusing the tree
          require("neo-tree.sources.filesystem").navigate(state, state.path, file_path)
        end
      end,

      ["i"] = function(state)
        local node = state.tree:get_node()
        local path = node:get_id()
        vim.api.nvim_input(": " .. path .. "<Home>")
      end,
      ["<space>"] = "none",
    }, -- }}}
  },

  event_handlers = { -- {{{
    {
      event = "file_opened",
      handler = function()
        --auto close
        require("neo-tree").close_all()
      end,
    },
    {
      event = "neo_tree_window_after_open",
      handler = function(args)
        if args.position == "left" or args.position == "right" then
          vim.cmd("wincmd =")
        end
      end,
    },
    {
      event = "neo_tree_window_after_close",
      handler = function(args)
        if args.position == "left" or args.position == "right" then
          vim.cmd("wincmd =")
        end
      end,
    },
  }, -- }}}

  filesystem = { -- {{{
    filtered_items = {
      hide_dotfiles = false,
      hide_by_name = {
        "node_modules",
        ".git",
        "target",
        "vendor",
      },
      never_show = {
        ".DS_Store",
        "thumbs.db",
      },
    },
    find_args = {
      fd = {
        "-uu",
        "--exclude",
        ".git",
        "--exclude",
        "node_modules",
        "--exclude",
        "target",
      },
    },
    follow_current_file = true,
    use_libuv_file_watcher = true,
  }, -- }}}
  deactivate = function()
    vim.cmd([[Neotree close]])
  end,
}
)
