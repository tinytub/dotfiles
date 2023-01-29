-- globals must be set prior to requiring nvim-tree to function
--
local nvimtree = require("nvim-tree")
--require("base46").load_highlight "nvimtree"

local tree_cb = require 'nvim-tree.config'.nvim_tree_callback
local list = {
  { key = { "l", "<CR>", "o", "<2-LeftMouse>" }, cb = tree_cb "edit" },
  { key = { "<2-RightMouse>", "<C-]>" }, cb = tree_cb "cd" },
  { key = "<C-v>", cb = tree_cb "vsplit" },
  { key = "<C-x>", cb = tree_cb "split" },
  { key = "<C-t>", cb = tree_cb "tabnew" },
  { key = "<", cb = tree_cb "prev_sibling" },
  { key = ">", cb = tree_cb "next_sibling" },
  { key = "P", cb = tree_cb "parent_node" },
  { key = "<BS>", cb = tree_cb "close_node" },
  { key = "<S-CR>", cb = tree_cb "close_node" },
  { key = "<Tab>", cb = tree_cb "preview" },
  { key = "K", cb = tree_cb "first_sibling" },
  { key = "J", cb = tree_cb "last_sibling" },
  { key = "I", cb = tree_cb "toggle_ignored" },
  { key = "H", cb = tree_cb "toggle_dotfiles" },
  { key = "R", cb = tree_cb "refresh" },
  { key = "a", cb = tree_cb "create" },
  { key = "d", cb = tree_cb "remove" },
  { key = "r", cb = tree_cb "rename" },
  { key = "<C->", cb = tree_cb "full_rename" },
  { key = "x", cb = tree_cb "cut" },
  { key = "c", cb = tree_cb "copy" },
  { key = "p", cb = tree_cb "paste" },
  { key = "y", cb = tree_cb "copy_name" },
  { key = "Y", cb = tree_cb "copy_path" },
  { key = "gy", cb = tree_cb "copy_absolute_path" },
  { key = "[c", cb = tree_cb "prev_git_item" },
  { key = "}c", cb = tree_cb "next_git_item" },
  { key = "-", cb = tree_cb "dir_up" },
  { key = "q", cb = tree_cb "close" },
  { key = "g?", cb = tree_cb "toggle_help" },
}

nvimtree.setup {
  filters = {
    dotfiles = false,
    custom = { 'node_modules', '.cache', 'build', 'var', 'vendor' },
  },
  disable_netrw = true,
  open_on_setup = false,
  hijack_netrw = true,
  hijack_unnamed_buffer_when_opening = false,
  ignore_ft_on_setup = { "alpha" },
  --   ignore = { ".git", "node_modules", ".cache" },
  --auto_close = false,
  hijack_cursor = true,
  update_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = false,
  },
  git = {
    enable = true,
    --        ignore = false,
  },
  filesystem_watchers = {
    enable = true,
  },
  actions = {
    open_file = {
      resize_window = true,
    },
  },
  renderer = {
    highlight_git = false,
    highlight_opened_files = "none",
    indent_markers = {
      enable = false,
    },
    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
      glyphs = {
        default = "",
        symlink = "",
        folder = {
          default = "",
          empty = "",
          empty_open = "",
          open = "",
          symlink = "",
          symlink_open = "",
          arrow_open = "",
          arrow_closed = "",
        },
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
          ignored = "◌",
        },
      },
    },
  },
  view = {
    --adaptive_size = true,
    --allow_resize = true,
    side = "left",
    width = 25,
    mappings = {
      list = list,
    },
    --hide_root_folder = true,
    --update_focused_file = {
    --    enable = true,
    --    update_cwd = false,
    --    ignore_list = {},
    --}
  },
  --actions = {
  --  open_file = {
  --    quit_on_open = false,
  --    window_picker = {
  --      enable = true,
  --      exclude = {
  --        filetype = { 'notify', 'packer', 'qf' },
  --        buftype = {'terminal' },
  --      }
  --    }
  --  }
  --}
}
