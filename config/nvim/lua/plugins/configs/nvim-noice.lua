local noice_status, noice = pcall(require, "noice")
if not noice_status then return end
--https://github.com/LazyVim/LazyVim
local opts = {
  lsp = {
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
    signature = { enabled = false },
  },
  messages = {
    view_search = false,
  },
  routes = {
    {
      filter = {
        event = "msg_show",
        find = "%d+L, %d+B",
      },
      view = "mini",
    },
    {
      filter = { event = "msg_show", find = "Hunk %d+ of %d+" },
      view = "mini",
    },
    {
      filter = { event = "msg_show", find = "%d+ more lines" },
      opts = { skip = true },
    },
    {
      filter = { event = "msg_show", find = "%d+ lines yanked" },
      opts = { skip = true },
    },
    {
      filter = { event = "msg_show", kind = "quickfix" },
      view = "mini",
    },
    {
      filter = { event = "msg_show", kind = "search_count" },
      view = "mini",
    },
    {
      filter = { event = "msg_show", kind = "wmsg" },
      view = "mini",
    },
    {
      --- hide written messages
      filter = {
        event = "msg_show",
        kind = "",
        find = "written",
      },
      opts = { skip = true },
    },
    {
      --- hide edits
      filter = {
        event = "msg_show",
        kind = "",
        find = "newer than edits",
      },
      opts = { skip = true },
    },
    {
      --- hide more line
      filter = {
        event = "msg_show",
        kind = "",
        find = " more line",
      },
      opts = { skip = true },
    },
  },
  presets = {
    bottom_search = true,
    command_palette = true,
    long_message_to_split = true,
    lsp_doc_border = true,
  },
  commands = {
    all = {
      view = "split",
      opts = { enter = true, format = "details" },
      filter = {},
    },
  },
  ---@type NoiceConfigViews
  views = {
    mini = {
      zindex = 100,
      win_options = { winblend = 0 },
    },
  },
}

noice.setup(opts)
