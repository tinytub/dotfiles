local navic = require('nvim-navic')

local icons = require("plugins.lspkind_icons")

-- https://github.com/Strazil001/Nvim/blob/main/after/plugin/lualine.lua
-- https://github.com/LazyVim/LazyVim

local colors = {
  red = '#cdd6f4',
  grey = '#181825',
  black = '#1e1e2e',
  white = '#313244',
  light_green = '#6c7086',
  orange = '#fab387',
  green = '#a6e3a1',
  blue = '#80A7EA',
}
-- is e0bc, nf-ple-upper_left_triangle
-- is e0ba, nf-ple-lower_right_triangle


local vim_icons = {
  function()
    return " "
  end,
  --separator = { left = "", right = "" },
  color = { bg = "#313244", fg = "#80A7EA" },
  padding = { left = 1, right = 0 }
}

local space = {
  function()
    return " "
  end,
  color = { bg = colors.black, fg = "#80A7EA" },
  padding = { left = 0, right = 0 }
}

local dir = {
  function()

    local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")

    return dir_name
    --if vim.b.vaffle ~= nil then
    --  local short_path = M.shorten(vim.b.vaffle["dir"])
    --  return short_path
    --end

    --if vim.b.short_path == nil then
    --  vim.b.short_path = M.shorten(vim.fn.expand("%:p:h"))
    --end
    --print("dir")

    --return vim.b.short_path
  end,
  icon = "",
}

--local function dir()
--  local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
--
--  return dir_name
--end

local filename = {
  'filename',
  color = { bg = "#80A7EA", fg = "#242735" },
  path = 1,
  --separator = { left = "", right = "" },
}

local filetype = {
  "filetype",
  icon_only = true,
  colored = true,
  color = { bg = "#313244" },
  --separator = { left = "", right = "" },
}

local filetype_tab = {
  "filetype",
  icon_only = true,
  colored = true,
  color = { bg = "#313244" },
}

--local buffer = {
--  require 'tabline'.tabline_buffers,
--  separator = { left = "", right = "" },
--}
--
--local tabs = {
--  require 'tabline'.tabline_tabs,
--  separator = { left = "", right = "" },
--}

local fileformat = {
  'fileformat',
  color = { bg = "#b4befe", fg = "#313244" },
  --separator = { left = "", right = "" },
}

local encoding = {
  'encoding',
  color = { bg = "#313244", fg = "#80A7EA" },
  --separator = { left = "", right = "" },
}

local branch = {
  'branch',
  color = { bg = "#a6e3a1", fg = "#313244" },
  --separator = { left = "", right = "" },
}

local diff = {
  "diff",
  color = { bg = "#313244", fg = "#313244" },
  --separator = { left = "", right = "" },
  symbols = {
    added = icons.git.added,
    modified = icons.git.modified,
    removed = icons.git.removed,
  },

}

local modes = {
  'mode', fmt = function(str) return str:sub(1, 1) end,
  --color = { bg = "#fab387		", fg = "#1e1e2e" },
  --separator = { left = "", right = "" },
}

local function getLspName()
  local msg = 'No Active Lsp'
  local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
  local clients = vim.lsp.get_active_clients()
  if next(clients) == nil then
    return msg
  end
  for _, client in ipairs(clients) do
    local filetypes = client.config.filetypes
    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
      return "  " .. client.name
    end
  end
  return "  " .. msg
end

local dia = {
  'diagnostics',
  color = { bg = "#313244", fg = "#80A7EA" },
  --separator = { left = "", right = "" },
}

local lsp = {
  function()
    return getLspName()
  end,
  --separator = { left = "", right = "" },
  color = { bg = "#f38ba8", fg = "#1e1e2e" },
}

local function fg(name)
  return function()
    ---@type {foreground?:number}?
    local hl = vim.api.nvim_get_hl_by_name(name, true)
    return hl and hl.foreground and { fg = string.format("#%06x", hl.foreground) }
  end
end

local opts = {
  options = {
    icons_enabled = true,
    theme = "auto",
    globalstatus = true,
    disabled_filetypes = { statusline = { "alpha", "dashboard", "lazy", "alpha", "neo-tree" } },
    --component_separators = { left = "", right = "" },
    --section_separators = { left = "", right = "" },
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    --component_separators = { left = '', right = '' },
    --section_separators = { left = '', right = '' },

    ignore_focus = {},
    always_divide_middle = true,
    refresh = {
      statusline = 1000,
      --tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {
      --{ "mode", separator = { left = "", right = "" } },
      "mode",
      --modes,
      vim_icons,
    },
    lualine_b = {
      --"branch"
      space,
      dir,
    },
    lualine_c = {
      filename,
      filetype,
      space,
      branch,
      diff,
      --{
      --  "diagnostics",
      --  symbols = {
      --    error = icons.diagnostics.Error,
      --    warn = icons.diagnostics.Warn,
      --    info = icons.diagnostics.Info,
      --    hint = icons.diagnostics.Hint,
      --  },
      --},
      --{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
      --{ "filename",
      --  path = 1,
      --  symbols = { modified = "  ", readonly = "", unnamed = "" },
      --  shorting_target = 30, -- Shortens path to leave 40 space in the window
      --},
      ---- stylua: ignore
      --{
      --  function() return require("nvim-navic").get_location() end,
      --  cond = function() return package.loaded["nvim-navic"] and require("nvim-navic").is_available() end,
      --},
    },
    lualine_x = {
      space,
      ---- stylua: ignore
      --{
      --  function() return require("noice").api.status.command.get() end,
      --  cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
      --  color = fg("Statement")
      --},
      ---- stylua: ignore
      --{
      --  function() return require("noice").api.status.mode.get() end,
      --  cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
      --  color = fg("Constant"),
      --},
      --{ require("lazy.status").updates, cond = require("lazy.status").has_updates, color = fg("Special") },
      --{
      --  "diff",
      --  symbols = {
      --    added = icons.git.added,
      --    modified = icons.git.modified,
      --    removed = icons.git.removed,
      --  },
      --},

    },
    lualine_y = {
      encoding,
      fileformat,
      space,
      --{ "filetype", icon_only = false, },

      -- {
      --   "progress",
      --   fmt = function()
      --     local msg = "No Active Lsp"
      --     local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
      --     local clients = vim.lsp.get_active_clients()
      --     if next(clients) == nil then
      --       return msg
      --     end
      --     for _, client in ipairs(clients) do
      --       local filetypes = client.config.filetypes
      --       if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
      --         return client.name
      --       end
      --     end
      --     return msg
      --   end,
      --   icon = " ",
      -- }

    },
    lualine_z = {
      dia,
      lsp,
      ---- { "progress", separator = "", padding = { left = 1, right = 0 } },
      --{ "location", padding = { left = 1, right = 1 } },
      --function()
      --  -- encoding
      --  local enc = (vim.bo.fenc ~= '' and vim.bo.fenc) or vim.o.enc
      --  --return " " .. enc:upper() .. " "
      --  return enc:upper()
      --end,
      --function()
      --  -- file format
      --  local fmt = vim.bo.fileformat
      --  return fmt:upper()
      --end,
    },

  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
  --tabline = {
  --  lualine_a = {
  --    buffer,
  --  },
  --  lualine_b = {
  --  },
  --  lualine_c = {},
  --  lualine_x = {
  --    tabs,
  --  },
  --  lualine_y = {
  --    space,
  --  },
  --  lualine_z = {
  --  },
  --},
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
