local present, bufferline = pcall(require, "bufferline")
if not present then
  return
end

bufferline.setup {
  options = {
    indicator = { style = 'icon', icon = '▎' },
    separator_style = { '', '' },
    buffer_close_icon = '',
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    max_name_length = 20,
    max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
    tab_size = 22,
    show_buffer_close_icons = false,
    show_close_icon = false,
    always_show_bufferline = true,
    --  indicator = { style = 'icon', icon = '▎' },
    --  offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
    --  buffer_close_icon = "",
    --  modified_icon = "",
    --  close_icon = "",
    --  show_close_icon = true,
    --  left_trunc_marker = " ",
    --  right_trunc_marker = " ",
    --  max_name_length = 20,
    --  max_prefix_length = 13,
    --  tab_size = 20,
    --  show_tab_indicators = true,
    --  enforce_regular_tabs = false,
    --  show_buffer_close_icons = false,
    --  --separator_style = "thick",
    --  separator_style = { "|", "|" },
    --  themable = true,
    --  custom_filter = function(buf_number)
    --    -- Func to filter out our managed/persistent split terms
    --    local present_type, type = pcall(function()
    --      return vim.api.nvim_buf_get_var(buf_number, "term_type")
    --    end)

    --    if present_type then
    --      if type == "vert" then
    --        return false
    --      elseif type == "hori" then
    --        return false
    --      else
    --        return true
    --      end
    --    else
    --      return true
    --    end
    --  end,
  },
  --highlights = {
  --  buffer_selected = {
  --    underline = true,
  --    undercurl = true,
  --    italic = true
  --    --gui = "bold"
  --  },
  --},

}
