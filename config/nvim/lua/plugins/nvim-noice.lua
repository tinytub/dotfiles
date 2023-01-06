local noice_status, noice = pcall(require, 'noice')
if not noice_status then
  return
end

local M = {}

function M.config()
  noice.setup({
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
      hover = {
        enabled = true,
      },
      signature = {
        enabled = false,
      },
      format = {
        spinner = {
          --name = "dots12",
          name = "sand",
        },
      },
      progress = {
        enabled = false,
      },
    },
    cmdline = {
      format = {
        search_down = {
          kind = "search", pattern = "^/", icon = " ", lang = "regex"
        },
        search_up = {
          kind = "search", pattern = "^%?", icon = " ", lang = "regex"
        },
      },
    },
    presets = {
      bottom_search = false, -- use a classic bottom cmdline for search
      command_palette = true, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = false, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = false, -- add a border to hover docs and signature help
    },
    views = {
      confirm = {
        position = {
          row = "90%",
          col = "90%",
        },
      }
    },
    routes = {
      { -- filter annoying buffer messages
        filter = {
          event = "msg_show",
          kind = "",
          any = {
            { find = "written" },
            { find = "line less" },
            { find = "fewer lines" },
            { find = "more line" },
            { find = "change; before" },
            { find = "change; after" },
            { find = '<leader>' },
          },
        },
        opts = { skip = true },
      },
      --{
      --  filter = {
      --    event = "msg_show",
      --    kind = "search_count",
      --  },
      --  opts = { skip = true },
      --},
    }
  })
end

return M

----https://github.com/max397574/omega-nvim/blob/master/lua/omega/modules/ui/noice.lua
