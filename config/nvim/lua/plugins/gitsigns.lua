local M = {}

M.config = function()
  --    require("base46").load_highlight "git"
  local gitsigns = require("gitsigns")
  -- colors from gruvbox8
  gitsigns.setup({
    numhl         = false,
    watch_gitdir  = {
      interval = 100,
    },
    sign_priority = 5,
    signs         = {
      add          = { text = "▎" }, -- catppuccin
      change       = { text = "▎" }, -- catppuccin
      --add          = { text = "▐" },
      --change       = { text = "▐" },
      --topdelete = { text = "契" }, -- catppuccin
      --delete       = { text = "▎" }, -- catppuccin
      --topdelete    = { text = "▔" }, -- catppuccin
      delete       = { text = "" },
      topdelete    = { text = "" },
      changedelete = { text = "▎" }, -- catppuccin
      untracked    = { text = "▎" }, -- catppuccin
    },

    current_line_blame = false,
    current_line_blame_formatter = "<author>:<author_time:%Y-%m-%d> - <summary>",
    current_line_blame_opts = {
      virt_text         = true,
      -- virt_text_pos     = "right_align",
      virt_text_pos     = "eol",
      delay             = 1000,
      ignore_whitespace = true,
    },

  })
end

return M
