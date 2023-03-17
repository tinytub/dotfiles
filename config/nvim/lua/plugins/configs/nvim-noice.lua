local noice_status, noice = pcall(require, 'noice')
if not noice_status then
  return
end
--https://github.com/LazyVim/LazyVim
local opts = {
  --cmdline = {
  --  view = "cmdline"
  --},
  lsp = {
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
    },
    signature = {
      enabled = false,
      --  silent = true,
    },
  },
  presets = {
    bottom_search = true,
    command_palette = true,
    long_message_to_split = true,
  },
}

noice.setup(opts)
