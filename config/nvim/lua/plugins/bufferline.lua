local M = {}

M.config = function()
    require "bufferline".setup {
        options = {
            offsets = {{filetype = "NvimTree", text = "", padding = 1}},
            buffer_close_icon = "",
            modified_icon = "",
            close_icon = "",
            left_trunc_marker = "",
            right_trunc_marker = "",
            max_name_length = 14,
            max_prefix_length = 13,
            tab_size = 20,
            show_tab_indicators = true,
            enforce_regular_tabs = false,
            view = "multiwindow",
            show_buffer_close_icons = true,
            separator_style = "thin",
            mappings = "true"
        }
    }
  -- Buffer line setup
  --require("bufferline").setup {
  --  options = {
  --    indicator_icon = "▎",
  --    buffer_close_icon = "",
  --    modified_icon = "●",
  --    close_icon = "",
  --    close_command = "bdelete %d",
  --    right_mouse_command = "bdelete! %d",
  --    left_trunc_marker = "",
  --    right_trunc_marker = "",
  --    offsets = {
  --      {
  --        filetype = "NvimTree",
  --        text = "",
  --        text_align = "center",
  --        padding = 1,
  --      },
  --    },
  --    show_tab_indicators = true,
  --    show_close_icon = false,
  --  },
  --  highlights = {
  --    fill = {
  --      guifg = { attribute = "fg", highlight = "Normal" },
  --      guibg = { attribute = "bg", highlight = "StatusLineNC" },
  --    },
  --  },
  --}
end

return M
