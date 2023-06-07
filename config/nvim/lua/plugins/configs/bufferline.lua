local bufferline = require "bufferline"

-- https://github.com/CKolkey/config/blob/master/nvim/lua/plugins/bufferline.lua
bufferline.setup {
  highlights = require("catppuccin.groups.integrations.bufferline").get(),
  options = {
    diagnostics = "nvim_lsp",
    show_buffer_close_icons = false,
    diagnostics_indicator = function(_, _, diag)
      --      local icons = require("lazyvim.config").icons.diagnostics
      local icons = require("plugins.configs.lspkind_icons").diagnostics
      local ret = (diag.error and icons.Error .. diag.error .. " " or "")
        .. (diag.warning and icons.Warn .. diag.warning or "")
      return vim.trim(ret)
    end,
    offsets = {
      {
        filetype = "neo-tree",
        text = "Neo-tree",
        highlight = "Directory",
        text_align = "left",
      },
    },
  },
}
