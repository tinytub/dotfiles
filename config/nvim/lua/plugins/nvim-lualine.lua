local navic = require('nvim-navic')

local icons = require("plugins.lspkind_icons")

local function fg(name)
  return function()
    ---@type {foreground?:number}?
    local hl = vim.api.nvim_get_hl_by_name(name, true)
    return hl and hl.foreground and { fg = string.format("#%06x", hl.foreground) }
  end
end

local opts = {
  options = {
    theme = "auto",
    globalstatus = true,
    disabled_filetypes = { statusline = { "alpha", "dashboard", "lazy", "alpha", "neo-tree" } },
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch" },
    lualine_c = {
      {
        "diagnostics",
        symbols = {
          error = icons.diagnostics.Error,
          warn = icons.diagnostics.Warn,
          info = icons.diagnostics.Info,
          hint = icons.diagnostics.Hint,
        },
      },
      { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
      { "filename",
        path = 1,
        symbols = { modified = "  ", readonly = "", unnamed = "" },
        shorting_target = 30, -- Shortens path to leave 40 space in the window
      },
      ---- stylua: ignore
      --{
      --  function() return require("nvim-navic").get_location() end,
      --  cond = function() return package.loaded["nvim-navic"] and require("nvim-navic").is_available() end,
      --},
    },
    lualine_x = {
      -- stylua: ignore
      {
        function() return require("noice").api.status.command.get() end,
        cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
        color = fg("Statement")
      },
      -- stylua: ignore
      {
        function() return require("noice").api.status.mode.get() end,
        cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
        color = fg("Constant"),
      },
      { require("lazy.status").updates, cond = require("lazy.status").has_updates, color = fg("Special") },
      {
        "diff",
        symbols = {
          added = icons.git.added,
          modified = icons.git.modified,
          removed = icons.git.removed,
        },
      },

    },
    lualine_y = {
      { "filetype", icon_only = false, },

      {
        "progress",
        fmt = function()
          local msg = "No Active Lsp"
          local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
          local clients = vim.lsp.get_active_clients()
          if next(clients) == nil then
            return msg
          end
          for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
              return client.name
            end
          end
          return msg
        end,
        icon = " ",
      }

    },
    lualine_z = {
      -- { "progress", separator = "", padding = { left = 1, right = 0 } },
      { "location", padding = { left = 1, right = 1 } },
      function()
        -- encoding
        local enc = (vim.bo.fenc ~= '' and vim.bo.fenc) or vim.o.enc
        --return " " .. enc:upper() .. " "
        return enc:upper()
      end,
      function()
        -- file format
        local fmt = vim.bo.fileformat
        return fmt:upper()
      end,
    },

  },
  extensions = { "neo-tree" },
  winbar = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {
      { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
      {
        'filename',
        path = 0,
        cond = navic.is_available,
        color = { gui = 'italic,bold' },
        symbols = { modified = "", readonly = "", unnamed = "" },

      },
      { navic.get_location, cond = navic.is_available },
    },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  inactive_winbar = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {
      { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
      { 'filename', path = 0, cond = navic.is_available, symbols = { modified = "", readonly = "", unnamed = "" }, },
    },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  }
}

require 'lualine'.setup(opts)


-----@type LazySpec
--local M = {
--  'hoob3rt/lualine.nvim',
--  dependencies = {
--    'nvim-tree/nvim-web-devicons',
--    'SmiteshP/nvim-navic',
--    'kosayoda/nvim-lightbulb',
--  },
--  lazy = false,
--}
--
--M.config = function()
--  local navic = require('nvim-navic')
--
--  local function diff()
--    local gitsigns = vim.b.gitsigns_status_dict
--    if gitsigns then
--      return {
--        added = gitsigns.added,
--        modified = gitsigns.changed,
--        removed = gitsigns.removed,
--      }
--    end
--  end
--
--  local function get_context()
--    if navic and navic.is_available() then
--      local loc = navic.get_location()
--      if loc ~= '' then
--        return loc
--      end
--    end
--    return ''
--  end
--
--  local function keymap()
--    if vim.bo.iminsert == 0 then
--      return [[us]]
--    else
--      return [[ru]]
--    end
--  end
--
--  local function action_available()
--    return require('nvim-lightbulb').get_status_text()
--  end
--
--  local function mode_to_symbol(mode)
--    local mode_sym_map = {
--      normal = 'α',
--      insert = 'Ɣ',
--      visual = 'Σ',
--      ['v-block'] = 'Θ',
--      select = 'Ϸ',
--      ['v-select'] = 'Ϸ',
--      command = 'Ψ',
--      replace = 'Δ',
--    }
--
--    return mode_sym_map[string.lower(mode)] or mode
--  end
--
--  local filename = {
--    'filename',
--    symbols = {
--      modified = ' ●',
--      readonly = ' ',
--      unnamed = ' ',
--      newfile = ' ',
--    },
--  }
--
--  local filename_path = table.shallow_copy(filename)
--  filename_path.path = 1
--
--  local no_winbar_ext = {
--    winbar = {},
--    inactive_winbar = {},
--    filetypes = {
--      'man',
--      'qf',
--      'Outline',
--      'dap-repl',
--      'dapui_console',
--      'dapui_watches',
--      'dapui_stacks',
--      'dapui_breakpoints',
--      'dapui_scopes',
--      'toggleterm',
--      'Trouble',
--    },
--  }
--
--  --  local noice = require('noice').api.status
--
--  require('lualine').setup({
--    options = {
--      theme = 'dracula',
--      section_separators = { '', '' },
--      component_separators = { '|', '|' },
--      icons_enabled = true,
--      fmt = mode_to_symbol,
--      globalstatus = true,
--    },
--    extensions = { no_winbar_ext },
--    sections = {
--      lualine_a = { 'mode', keymap },
--      lualine_b = { filename },
--      lualine_c = {
--        get_context,
--        action_available,
--      },
--      lualine_x = {
--        {
--          'diagnostics',
--          sources = { 'nvim_diagnostic' },
--          symbols = {
--            error = ' ',
--            warn = ' ',
--            info = '',
--            hint = ' ',
--          },
--        },
--        { 'diff', source = diff },
--        { 'b:gitsigns_head', icon = '' },
--      },
--      lualine_y = {
--        {
--          --noice.search.get,
--          --cond = noice.search.has,
--        },
--      },
--      lualine_z = {},
--    },
--    winbar = {
--      lualine_a = { filename_path },
--      lualine_b = {},
--      lualine_c = {},
--      lualine_x = { 'filetype' },
--      lualine_y = { 'progress' },
--      lualine_z = { 'location' },
--    },
--    inactive_winbar = {
--      lualine_a = {},
--      lualine_b = {},
--      lualine_c = { filename_path },
--      lualine_x = { 'filetype', 'progress', 'location' },
--      lualine_y = {},
--      lualine_z = {},
--    },
--  })
--end
--function table.shallow_copy(t)
--  local t2 = {}
--  for k, v in pairs(t) do
--    t2[k] = v
--  end
--  return t2
--end
--
--return M
