local bufferline = require("bufferline")

-- https://github.com/CKolkey/config/blob/master/nvim/lua/plugins/bufferline.lua
bufferline.setup {
  highlights = require("catppuccin.groups.integrations.bufferline").get(),
  options = {
    diagnostics = "nvim_lsp",
    indicator = { style = 'icon', icon = '▎' },
    separator_style = { '', '' },
    --separator_style = { '', '' },
    -- separator_style = "thin", -- options "slant" | "thick" | "thin" | { 'any', 'any' },
    buffer_close_icon = '',

    --themable = false,
    custom_filter = function(buf, _buf_nums)
      if vim.bo[buf].buflisted
          and not vim.bo[buf].mod
          and vim.api.nvim_buf_get_name(buf) == ""
          and vim.fn.bufwinnr(buf) < 0
      then
        return false
      else
        return true
      end
    end,

    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    max_name_length = 20,
    max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
    tab_size = 22,
    show_buffer_close_icons = false,
    show_close_icon = false,
    always_show_bufferline = false,
    diagnostics_indicator = function(_, _, diag)
      --      local icons = require("lazyvim.config").icons.diagnostics
      local icons = require("plugins.lspkind_icons").diagnostics
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
    --offsets = {
    --  {
    --    filetype = "NvimTree",
    --    --text = vim.fn.fnamemodify(vim.fn.getcwd(), ":~") .. "/" .. string.rep(" ", 30),
    --    --text_align = "left",
    --  },
    --},
  },
}
