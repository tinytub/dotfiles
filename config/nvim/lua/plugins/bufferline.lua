local bufferline = require("bufferline")

bufferline.setup {
  highlights = require("catppuccin.groups.integrations.bufferline").get(),
  options = {
    indicator = { style = 'icon', icon = '▎' },
    separator_style = { '', '' },
    -- separator_style = "thin", -- options "slant" | "thick" | "thin" | { 'any', 'any' },
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
    --offsets = {
    --  {
    --    filetype = "NvimTree",
    --    --text = vim.fn.fnamemodify(vim.fn.getcwd(), ":~") .. "/" .. string.rep(" ", 30),
    --    --text_align = "left",
    --  },
    --},
  },
}
