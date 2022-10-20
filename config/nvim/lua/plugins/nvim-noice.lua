local M = {}


M.config = function()
  local present, noi = pcall(require, "noice")

  if not present then
    return
  end

  noi.setup({
    cmdline = {
      enabled = true, -- disable if you use native command line UI
      --view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
      view = "cmdline"
      --opts = { buf_options = { filetype = "vim" } }, -- enable syntax highlighting in the cmdline
      --icons = {
      --  ["/"] = { icon = " ", hl_group = "DiagnosticWarn" },
      --  ["?"] = { icon = "? ", hl_group = "DiagnosticWarn" },
      --  [":"] = { icon = " ", hl_group = "DiagnosticInfo", firstc = false },
      --},
    },
    messages = {
      -- NOTE: If you enable noice messages UI, noice cmdline UI is enabled
      -- automatically. You cannot enable noice messages UI only.
      -- It is current neovim implementation limitation.  It may be fixed later.
      enabled = true, -- disable if you use native messages UI
    },
    popupmenu = {
      enabled = false, -- disable if you use something like cmp-cmdline
      ---@type 'nui'|'cmp'
      backend = "cmp", -- backend to use to show regular cmdline completions
      -- You can specify options for nui under `config.views.popupmenu`
    },
    history = {
      -- options for the message history that you get with `:Noice`
      view = "split",
      opts = { enter = true },
      filter = { event = "msg_show", ["not"] = { kind = { "search_count", "echo" } } },
    },
    notify = {
      -- Noice can be used as `vim.notify` so you can route any notification like other messages
      -- Notification messages have their level and other properties set.
      -- event is always "notify" and kind can be any log level as a string
      -- The default routes will forward notifications to nvim-notify
      -- Benefit of using Noice for this is the routing and consistent history view
      enabled = false,
    },
    hacks = {
      -- due to https://github.com/neovim/neovim/issues/20416
      -- messages are resent during a redraw. Noice detects this in most cases, but
      -- some plugins (mostly vim plugns), can still cause loops.
      -- When a loop is detected, Noice exits.
      -- Enable this option to simply skip duplicate messages instead.
      skip_duplicate_messages = false,
    },
    throttle = 1000 / 30, -- how frequently does Noice need to check for ui updates? This has no effect when in blocking mode.
    ---@type table<string, NoiceViewOptions>
    views = {
      cmdline_popup = {
        border = {
          style = "none",
          padding = { 2, 3 },
        },
        size = {
          width = "auto",
          height = "auto",
        },
        filter_options = {},
        win_options = {
          winblend = 5,
          winhighlight = {
            NormalFloat = "NormalFloat",
            FloatBorder = "FloatBorder",
            Normal = "NormalFloat",
            Search = "None",
            Pmenu = "NormalFloat",
          },
        },
      },
    }, -- @see the section on views below
    ---@type NoiceRouteConfig[]
    routes = {
      {
        filter = {
          event = "msg_show",
          kind = "",
          find = "written",
        },
        opts = { skip = true },
      },
      -- Use a Classic Bottom Cmdline for Search
      -- https://github.com/folke/noice.nvim/wiki/Configuration-Recipes#use-a-classic-bottom-cmdline-for-search
      {
        filter = {
          event = "cmdline",
          find = "^%s*[/?]",
        },
        view = "cmdline",
      },
      {
        view = "notify",
        filter = { event = "msg_showmode" },
      },
      {
        filter = { event = "msg_show", kind = "search_count" },
        opts = { skip = true },
      },
      {
        view = "split",
        filter = { event = "msg_show", min_height = 20 },
      },
      {
        filter = {
          event = "msg_show",
          find = "; before #",
        },
        opts = { skip = true },
      },
      {
        filter = {
          event = "msg_show",
          find = "; after #",
        },
        opts = { skip = true },
      },
      {
        filter = {
          event = "msg_show",
          find = " lines, ",
        },
        opts = { skip = true },
      },
      {
        filter = {
          event = "msg_show",
          find = "go up one level",
        },
        opts = { skip = true },
      },
      {
        filter = {
          event = "msg_show",
          find = "yanked",
        },
        opts = { skip = true },
      },
      {
        filter = { find = "No active Snippet" },
        opts = { skip = true },
      },
    }, -- @see the section on routes below
    ---@type table<string, NoiceFilter>
    status = {}, --@see the section on statusline components below
    ---@type NoiceFormatOptions
    format = {}, -- @see section on formatting
  })
end
return M