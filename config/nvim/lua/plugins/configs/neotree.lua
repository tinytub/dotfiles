local M = {}

-- some from https://github.com/CKolkey/config/blob/master/nvim/lua/plugins/neo-tree.lua
-- some from LazyVim
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

function M.setup(opts)
  opts = vim.tbl_deep_extend("force", {
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
          if args.position == "left" or args.position == "right" then vim.cmd "wincmd =" end
        end,
      },
      {
        event = "neo_tree_window_after_close",
        handler = function(args)
          if args.position == "left" or args.position == "right" then vim.cmd "wincmd =" end
        end,
      },

      -- Toggle strong cursorline highlight
      { event = "neo_tree_buffer_enter", handler = set_cursorline },
      { event = "neo_tree_buffer_leave", handler = reset_cursorline },
    },
    window = {
      mappings = {
        ["<c-x>"] = "split_with_window_picker",
        ["<c-v>"] = "vsplit_with_window_picker",
        ["l"] = "open_with_window_picker",
        ["<cr>"] = "open_drop",
      },
    },
  }, opts or {})
  require("neo-tree").setup(opts)
end

return M
