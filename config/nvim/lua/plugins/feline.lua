--https://github.com/FelixKratz/dotfiles/blob/4275dd32d3/.config/nvim/lua/plugins/feline.lua
local lsp = require("feline.providers.lsp")
local lsp_severity = vim.diagnostic.severity
local b = vim.b

local assets = {
  left_semicircle = "",
  right_semicircle = "",
  right_semicircle_cut = "",
  left_semicircle_cut = "",
  vertical_bar_chubby = "█",
  vertical_bar_medium = "┃",
  vertical_bar_thin = "│",
  left_arrow_thin = "",
  right_arrow_thin = "",
  left_arrow_filled = "",
  right_arrow_filled = "",
  slant_left = "",
  slant_left_thin = "",
  slant_right = "",
  slant_right_thin = "",
  slant_left_2 = "",
  slant_left_2_thin = "",
  slant_right_2 = "",
  slant_right_2_thin = "",
  chubby_dot = "●",
  slim_dot = "•",
}

local clrs = require("catppuccin.palettes").get_palette()

-- settings
local sett = {
  --bkg = clrs.surface0,
  bkg = '#2e363c', -- from base46
  diffs = clrs.overlay0,
  extras = clrs.overlay1,
  position = clrs.rosewater,
}

local mode_colors = {
  ["n"] = { "NORMAL", clrs.lavender },
  ["no"] = { "N-PENDING", clrs.lavender },
  ["i"] = { "INSERT", clrs.rosewater },
  ["ic"] = { "INSERT", clrs.rosewater },
  ["t"] = { "TERMINAL", clrs.green },
  ["v"] = { "VISUAL", clrs.flamingo },
  ["V"] = { "V-LINE", clrs.flamingo },
  [""] = { "V-BLOCK", clrs.flamingo },
  ["R"] = { "REPLACE", clrs.maroon },
  ["Rv"] = { "V-REPLACE", clrs.maroon },
  ["s"] = { "SELECT", clrs.maroon },
  ["S"] = { "S-LINE", clrs.maroon },
  [""] = { "S-BLOCK", clrs.maroon },
  ["c"] = { "COMMAND", clrs.red },
  ["cv"] = { "COMMAND", clrs.red },
  ["ce"] = { "COMMAND", clrs.red },
  ["r"] = { "PROMPT", clrs.teal },
  ["rm"] = { "MORE", clrs.teal },
  ["r?"] = { "CONFIRM", clrs.mauve },
  ["!"] = { "SHELL", clrs.green },
}

local M = {}

function M.get()
  local shortline = false

  local function is_enabled(is_shortline, winid, min_width)
    if is_shortline then
      return true
    end

    winid = winid or 0
    return vim.api.nvim_win_get_width(winid) > min_width
  end

  -- Initialize the components table
  local components = {
    active = {},
    inactive = {},
  }

  table.insert(components.active, {}) -- (1) left
  table.insert(components.active, {}) -- (2) center
  table.insert(components.active, {}) -- (3) right

  -- global components
  local invi_sep = {
    str = " ",
    hl = {
      fg = sett.bkg,
      bg = sett.bkg,
    },
  }

  -- helpers
  local function any_git_changes()
    local gst = b.gitsigns_status_dict -- git stats
    if gst then
      if gst["added"] and gst["added"] > 0
          or gst["removed"] and gst["removed"] > 0
          or gst["changed"] and gst["changed"] > 0 then
        return true
      end
    end
    return false
  end

  -- #################### STATUSLINE ->

  -- ######## Left

  -- Current vi mode ------>
  local vi_mode_hl = function()
    return {
      fg = sett.bkg,
      bg = mode_colors[vim.fn.mode()][2],
      style = "bold",
    }
  end

  components.active[1][1] = {
    provider = assets.vertical_bar_chubby,
    hl = function()
      return {
        fg = mode_colors[vim.fn.mode()][2],
        bg = sett.bkg,
      }
    end,
  }

  components.active[1][2] = {
    provider = "",
    hl = function()
      return {
        fg = sett.bkg,
        bg = mode_colors[vim.fn.mode()][2],
      }
    end,
  }

  components.active[1][3] = {
    provider = function()
      return " " .. mode_colors[vim.fn.mode()][1]
    end,
    hl = vi_mode_hl,
  }

  -- there is a dilema: we need to hide Diffs if there is no git info. We can do that, but this will
  -- leave the right_semicircle colored with purple, and since we can't change the color conditonally
  -- then the solution is to create two right_semicircles: one with a mauve sett.bkg and the other one normal
  -- sett.bkg; both have the same fg (vi mode). The mauve one appears if there is git info, else the one with
  -- the normal sett.bkg appears. Fixed :)

  -- enable if git diffs are not available
  components.active[1][4] = {
    provider = assets.right_semicircle,
    hl = function()
      return {
        fg = mode_colors[vim.fn.mode()][2],
        bg = sett.bkg,
      }
    end,
    enabled = function()
      return not any_git_changes()
    end,
  }

  -- enable if git diffs are available
  components.active[1][5] = {
    provider = assets.right_semicircle,
    hl = function()
      return {
        fg = mode_colors[vim.fn.mode()][2],
        bg = sett.diffs,
      }
    end,
    enabled = function()
      return any_git_changes()
    end,
  }
  -- Current vi mode ------>

  -- Diffs ------>
  components.active[1][6] = {
    provider = "git_diff_added",
    hl = {
      fg = sett.bkg,
      bg = sett.diffs,
    },
    icon = "  ",
  }

  components.active[1][7] = {
    provider = "git_diff_changed",
    hl = {
      fg = sett.bkg,
      bg = sett.diffs,
    },
    icon = "  ",
  }

  components.active[1][8] = {
    provider = "git_diff_removed",
    hl = {
      fg = sett.bkg,
      bg = sett.diffs,
    },
    icon = "  ",
  }

  components.active[1][9] = {
    provider = assets.right_semicircle,
    hl = {
      fg = sett.diffs,
      bg = sett.bkg,
    },
    enabled = function()
      return any_git_changes()
    end,
  }

  components.active[1][10] = {
    provider = "git_branch",
    enabled = is_enabled(shortline, winid, 70),
    hl = {
      fg = sett.extras,
      bg = sett.bkg,
    },
    icon = "  ",
    left_sep = invi_sep,
    right_sep = invi_sep,
  }


  -- Diffs ------>

  -- Extras ------>

  -- Extras ------>

  -- ######## Left

  -- ######## Center

  -- Diagnostics ------>
  -- workspace loader
  --components.active[2][1] = {
  --  provider = function()
  --    local Lsp = vim.lsp.util.get_progress_messages()[1]

  --    if Lsp then
  --      local msg = Lsp.message or ""
  --      local percentage = Lsp.percentage or 0
  --      local title = Lsp.title or ""
  --      local spinners = {
  --        "",
  --        "",
  --        "",
  --      }
  --      local success_icon = {
  --        "",
  --        "",
  --        "",
  --      }
  --      local ms = vim.loop.hrtime() / 1000000
  --      local frame = math.floor(ms / 120) % #spinners

  --      if percentage >= 70 then
  --        return string.format(" %%<%s %s %s (%s%%%%) ", success_icon[frame + 1], title, msg, percentage)
  --      end

  --      return string.format(" %%<%s %s %s (%s%%%%) ", spinners[frame + 1], title, msg, percentage)
  --    end

  --    return ""
  --  end,
  --  enabled = is_enabled(shortline, winid, 80),
  --  hl = {
  --    fg = clrs.rosewater,
  --    bg = sett.bkg,
  --  },
  --}

  -- genral diagnostics (errors, warnings. info and hints)
  components.active[2][2] = {
    provider = "diagnostic_errors",
    enabled = function()
      return lsp.diagnostics_exist(lsp_severity.ERROR)
    end,

    hl = {
      fg = clrs.red,
      bg = sett.bkg,
    },
    icon = "  ",
  }

  components.active[2][3] = {
    provider = "diagnostic_warnings",
    enabled = function()
      return lsp.diagnostics_exist(lsp_severity.WARN)
    end,
    hl = {
      fg = clrs.yellow,
      bg = sett.bkg,
    },
    icon = "  ",
  }

  components.active[2][4] = {
    provider = "diagnostic_info",
    enabled = function()
      return lsp.diagnostics_exist(lsp_severity.INFO)
    end,
    hl = {
      fg = clrs.sky,
      bg = sett.bkg,
    },
    icon = "  ",
  }

  components.active[2][5] = {
    provider = "diagnostic_hints",
    enabled = function()
      return lsp.diagnostics_exist(lsp_severity.HINT)
    end,
    hl = {
      fg = clrs.rosewater,
      bg = sett.bkg,
    },
    icon = "  ",
  }

  components.active[3][1] = {
    provider = function()
      if next(vim.lsp.buf_get_clients()) ~= nil then
        local names = {}
        local clients = vim.lsp.get_active_clients()
        for _, client in ipairs(clients) do
          if client.attached_buffers[vim.api.nvim_get_current_buf()] then
            table.insert(names, client.name)
          end
        end
        local name = ""
        if names ~= {} then
          name = table.concat(names, '|')
        end
        return ("   LSP ~ " .. name .. " ") or "   LSP "
      else
        return ""
      end
    end,
    hl = {
      fg = sett.extras,
      bg = sett.bkg,
    },
    right_sep = invi_sep,
  }
  components.active[3][2] = {
    provider = assets.left_semicircle,
    hl = {
      fg = clrs.red,
      bg = sett.bkg,
    }
  }

  components.active[3][3] = {
    -- icon
    left_sep = {
      str = "" .. " ",
      hl = {
        fg = sett.bkg,
        bg = clrs.red,
      }
    },

    -- dirname
    provider = function()
      local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
      return " " .. dir_name .. " "
    end,

    hl = {
      fg = sett.bkg,
      --bg = sett.bkg,
      bg = clrs.red,
    },
  }

  components.active[3][4] = {
    provider = function()
      local current_line = vim.fn.line "."
      local current_col = vim.fn.col "."
      local total_line = vim.fn.line "$"

      if current_col < 10 then
        current_col = " " .. current_col
      end

      if current_line == 1 then
        --return " " .. current_line .. ":" .. current_col .. "/" .. "Top "
        return " " .. current_line .. ":" .. current_col .. "/" .. "Top "
      elseif current_line == vim.fn.line "$" then
        --return " " .. current_line .. ":" .. current_col .. "/" .. "Bot "
        return " " .. current_line .. ":" .. current_col .. "/" .. "Bot "
      end
      local result, _ = math.modf((current_line / total_line) * 100)

      if result < 10 then
        result = " " .. result
      end

      --return " " .. current_line .. ":" .. current_col .. "/" .. result .. "%% "
      return " " .. current_line .. ":" .. current_col .. "/" .. result .. "%% "
    end,

    hl = {
      fg = sett.bkg,
      --bg = sett.position,
      bg = clrs.green,
    },
    left_sep = {
      str = assets.left_semicircle,
      hl = {
        --fg = sett.position,
        fg = clrs.green,
        --bg = sett.bkg,
        bg = clrs.red,
      },
    },
  }
  return components
end

require("feline").setup({ components = M.get() })

local winbar_components = {
  file = {
    provider = {
      name = "file_info",
      --opts = {
      --    file_readonly_icon = '',
      --    file_modified_icon = '',
      --},
    },
    left_sep = {
      str = "  ",
    },
    --hl = { bg = '#1c1c1c', style = 'bold' },
  },
  gps = {
    provider = function()
      --local gps_loaded, gps = pcall(require, "nvim-gps")
      --if not gps_loaded then
      --    return
      --end

      --local location = gps.get_location()
      --return location == "" and "" or "  " .. location

      local gps_loaded, gps = pcall(require, "nvim-navic")
      if not gps_loaded then
        return
      end

      local location = gps.get_location()
      return location == "" and "" or "  " .. location
    end,
    enabled = function()
      --local gps_loaded, gps = pcall(require, "nvim-gps")

      --if not gps_loaded then
      --    return false
      --end
      --return gps.is_available()

      local gps_loaded, gps = pcall(require, "nvim-navic")

      if not gps_loaded then
        return false
      end
      return gps.is_available()
    end,
    --    hl = { fg = '#eeeeee', bg = '#1c1c1c' },
    hl = {
      --fg = options.colors.purple,
      fg = '#ecafcc',
      --bg = options.colors.statusline_bg,
      --bg = '#2e363c',
      bg = sett.bkg,
    },
  },
}
local winbar = {
  {
    --        winbar_components.file,
    winbar_components.gps,
  },
}
require("feline").winbar.setup({
  --components = { active = winbar, inactive = winbar },
  components = { active = winbar },
  disable = {
    filetypes = {
      "term",
      "startify",
      "NvimTree",
      "packer",
      "Telescop",
    },
  },
})



---------------------------------------------------
--local present, feline = pcall(require, "feline")
--
--if not present then
--  return
--end
--
--local fn = vim.fn
--
--local options = {
--  colors = require('base46').get_colors('base_30'),
--  lsp = require "feline.providers.lsp",
--  lsp_severity = vim.diagnostic.severity,
--}
--
--local icons = {
--  mode_icon = "  ",
--  position_icon = "  ",
--  empty_file = "  Empty ",
--  dir = " ",
--  clock = " ",
--}
--options.icons = icons
--
---- https://github.com/FelixKratz/dotfiles/blob/master/.config/nvim/lua/custom/plugins/feline.lua
--
--options.icon_styles = {
--  default = {
--    left = "",
--    right = " ",
--    main_icon = " ",
--    vi_mode_icon = " ",
--    position_icon = " ",
--  },
--  arrow = {
--    left = "",
--    right = "",
--    main_icon = " ",
--    vi_mode_icon = "",
--    position_icon = " ",
--  },
--
--  block = {
--    left = " ",
--    right = " ",
--    main_icon = " ",
--    vi_mode_icon = "",
--    position_icon = "  ",
--  },
--
--  round = {
--    left = "",
--    right = "",
--    main_icon = " ",
--    vi_mode_icon = " ",
--    position_icon = " ",
--  },
--
--  slant = {
--    left = " ",
--    right = " ",
--    main_icon = " ",
--    vi_mode_icon = " ",
--    position_icon = " ",
--  },
--}
--
--options.mode_colors = {
--  ["n"] = { "NORMAL", options.colors.nord_blue },
--  ["no"] = { "N-PENDING", options.colors.red },
--  ["i"] = { "INSERT", options.colors.dark_purple },
--  ["ic"] = { "INSERT", options.colors.dark_purple },
--  ["t"] = { "TERMINAL", options.colors.green },
--  ["v"] = { "VISUAL", options.colors.cyan },
--  ["V"] = { "V-LINE", options.colors.cyan },
--  [""] = { "V-BLOCK", options.colors.cyan },
--  ["R"] = { "REPLACE", options.colors.orange },
--  ["Rv"] = { "V-REPLACE", options.colors.orange },
--  ["s"] = { "SELECT", options.colors.nord_blue },
--  ["S"] = { "S-LINE", options.colors.nord_blue },
--  [""] = { "S-BLOCK", options.colors.nord_blue },
--  ["c"] = { "COMMAND", options.colors.pink },
--  ["cv"] = { "COMMAND", options.colors.pink },
--  ["ce"] = { "COMMAND", options.colors.pink },
--  ["r"] = { "PROMPT", options.colors.teal },
--  ["rm"] = { "MORE", options.colors.teal },
--  ["r?"] = { "CONFIRM", options.colors.teal },
--  ["!"] = { "SHELL", options.colors.green },
--}
--
--options.separator_style = options.icon_styles["round"]
--
--options.main_icon = {
--  provider = function()
--    return "  " .. options.mode_colors[vim.fn.mode()][1] .. " "
--  end,
--
--  --hl = {
--  --    fg = options.colors.statusline_bg,
--  --    bg = options.colors.nord_blue,
--  --},
--
--  hl = function()
--    return {
--      fg = options.colors.black,
--      bg = options.mode_colors[fn.mode()][2],
--    }
--  end,
--
--  right_sep = {
--    str = options.separator_style.right,
--    hl = function()
--      return {
--        fg = options.mode_colors[fn.mode()][2],
--        bg = options.colors.grey,
--      }
--    end,
--
--    --hl = {
--    --    fg = options.colors.nord_blue,
--    --    bg = options.colors.grey,
--    --},
--  },
--}
--
--options.separator_left = {
--  provider = options.separator_style.right,
--  hl = {
--    fg = options.colors.grey,
--    bg = options.colors.lightbg,
--  }
--}
--
--options.dir_name = {
--  provider = function()
--    local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
--    local filename = vim.fn.expand "%:t"
--    local extension = vim.fn.expand "%:e"
--    local icon = require("nvim-web-devicons").get_icon(filename, extension)
--    if icon == nil then
--      icon = " "
--    end
--    return " " .. icon .. " " .. dir_name .. " "
--  end,
--
--  hl = {
--    fg = options.colors.white,
--    bg = options.colors.lightbg,
--  },
--
--  right_sep = {
--    str = options.separator_style.right,
--    hl = { fg = options.colors.lightbg, bg = options.colors.lightbg2 },
--  },
--}
--
--options.left_file_info = {
--  left_sep = {
--    --str = statusline_style.left,
--    str = "",
--    hl = {
--      bg = options.colors.lightbg,
--      fg = options.colors.white,
--    },
--
--  },
--
--  -- file icon
--  provider = function()
--    local filename = fn.expand("%:t")
--    local extension = fn.expand("%:e")
--
--    if filename == "" then
--      return options.icons.empty_file
--    end
--
--    local icon = require("nvim-web-devicons").get_icon(filename, extension)
--
--    if icon == nil then
--      icon = "  "
--    else
--      icon = " " .. icon .. " "
--    end
--
--    return icon
--  end,
--
--  hl = {
--    bg = options.colors.lightbg,
--    fg = options.colors.white,
--  },
--
--  -- file name
--  right_sep = {
--    str = function()
--      local filename = fn.expand("%:t")
--      return "" .. fn.fnamemodify(filename, ":r") .. " "
--    end,
--
--    hl = {
--      bg = options.colors.lightbg,
--      fg = options.colors.white,
--    },
--  },
--}
--
--options.separator_left2 = {
--  provider = options.separator_style.right,
--  hl = {
--    fg = options.colors.lightbg,
--    bg = options.colors.statusline_bg,
--  }
--}
--
--options.diff = {
--  add = {
--    provider = "git_diff_added",
--    hl = {
--      fg = options.colors.grey_fg2,
--      bg = options.colors.statusline_bg,
--    },
--    icon = "  ",
--  },
--
--  change = {
--    provider = "git_diff_changed",
--    hl = {
--      fg = options.colors.grey_fg2,
--      bg = options.colors.statusline_bg,
--    },
--    icon = "  ",
--  },
--
--  remove = {
--    provider = "git_diff_removed",
--    hl = {
--      fg = options.colors.grey_fg2,
--      bg = options.colors.statusline_bg,
--    },
--    icon = "  ",
--  },
--}
--
--options.git_branch = {
--  provider = "git_branch",
--  hl = {
--    fg = options.colors.grey_fg2,
--    bg = options.colors.statusline_bg,
--  },
--  icon = "  ",
--}
--
--options.diagnostic = {
--  error = {
--    provider = "diagnostic_errors",
--    enabled = function()
--      return options.lsp.diagnostics_exist(options.lsp_severity.ERROR)
--    end,
--
--    hl = { fg = options.colors.red },
--    icon = "  ",
--  },
--
--  warning = {
--    provider = "diagnostic_warnings",
--    enabled = function()
--      return options.lsp.diagnostics_exist(options.lsp_severity.WARN)
--    end,
--    hl = { fg = options.colors.yellow },
--    icon = "  ",
--  },
--
--  hint = {
--    provider = "diagnostic_hints",
--    enabled = function()
--      return options.lsp.diagnostics_exist(options.lsp_severity.HINT)
--    end,
--    hl = { fg = options.colors.grey_fg2 },
--    icon = "  ",
--  },
--
--  info = {
--    provider = "diagnostic_info",
--    enabled = function()
--      return options.lsp.diagnostics_exist(options.lsp_severity.INFO)
--    end,
--    hl = { fg = options.colors.green },
--    icon = "  ",
--  },
--}
--
--options.lsp_progress = {
--  provider = function()
--    local Lsp = vim.lsp.util.get_progress_messages()[1]
--
--    if Lsp then
--      local msg = Lsp.message or ""
--      local percentage = Lsp.percentage or 0
--      local title = Lsp.title or ""
--      local spinners = {
--        "",
--        "",
--        "",
--      }
--
--      local success_icon = {
--        "",
--        "",
--        "",
--      }
--
--      local ms = vim.loop.hrtime() / 1000000
--      local frame = math.floor(ms / 120) % #spinners
--
--      if percentage >= 70 then
--        return string.format(" %%<%s %s %s (%s%%%%) ", success_icon[frame + 1], title, msg, percentage)
--      end
--
--      return string.format(" %%<%s %s %s (%s%%%%) ", spinners[frame + 1], title, msg, percentage)
--    end
--
--    return ""
--  end,
--  hl = { fg = options.colors.green },
--}
--
--options.lsp_status = {
--  provider = function()
--    if next(vim.lsp.buf_get_clients()) ~= nil then
--      local names = {}
--      local clients = vim.lsp.get_active_clients()
--      for _, client in ipairs(clients) do
--        if client.attached_buffers[vim.api.nvim_get_current_buf()] then
--          table.insert(names, client.name)
--        end
--      end
--      local name = ""
--      if names ~= {} then
--        name = table.concat(names, '|')
--      end
--      return ("   LSP ~ " .. name .. " ") or "   LSP "
--      --return content and ("%#St_LspStatus#" .. content) or ""
--      --local lsp_name = vim.lsp.get_active_clients()[1].name
--
--      --return "   LSP ~ " .. lsp_name .. " "
--    else
--      return ""
--    end
--  end,
--
--  hl = {
--    fg = options.colors.teal,
--    bg = options.colors.statusline_bg,
--  }
--}
--
--options.cwd = {
--  -- icon
--  left_sep = {
--    str = "" .. icons.dir,
--    hl = {
--      fg = options.colors.one_bg,
--      bg = options.colors.red,
--    }
--  },
--
--  -- dirname
--  provider = function()
--    local dir_name = fn.fnamemodify(fn.getcwd(), ":t")
--    return " " .. dir_name .. " "
--  end,
--
--  hl = {
--    fg = options.colors.white,
--    bg = options.colors.lightbg,
--  },
--}
--options.separator_right_position = {
--  provider = options.separator_style.left,
--  hl = {
--    fg = options.colors.green,
--    bg = options.colors.grey,
--  }
--}
--
--options.separator_right_position2 = {
--  provider = options.separator_style.left,
--  hl = {
--    fg = options.colors.red,
--    bg = options.colors.statusline_bg,
--  }
--}
--options.position_icon = {
--  provider = options.separator_style.position_icon,
--  hl = {
--    fg = options.colors.black,
--    bg = options.colors.green,
--  }
--}
--options.current_line = {
--  provider = function()
--    local current_line = vim.fn.line(".")
--    local total_line = vim.fn.line("$")
--
--    if current_line == 1 then
--      return " Top "
--    elseif current_line == vim.fn.line("$") then
--      return " Bot "
--    end
--    local result, _ = math.modf((current_line / total_line) * 100)
--    return " " .. result .. "%% "
--  end,
--  --enabled = shortline or function(winid)
--  --    return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 90
--  --end,
--  hl = {
--    fg = options.colors.green,
--    bg = options.colors.lightbg,
--  },
--}
--
--local function add_table(tbl, inject)
--  if inject then
--    table.insert(tbl, inject)
--  end
--end
--
---- components are divided in 3 sections
--options.left = {}
--options.middle = {}
--options.right = {}
--
---- left
--add_table(options.left, options.main_icon)
--add_table(options.left, options.separator_left)
--add_table(options.left, options.left_file_info)
--add_table(options.left, options.separator_left2)
--add_table(options.left, options.git_branch)
--add_table(options.left, options.diff.add)
--add_table(options.left, options.diff.change)
--add_table(options.left, options.diff.remove)
--
----add_table(options.middle, options.lsp_progress)
--
---- right
--add_table(options.right, options.diagnostic.error)
--add_table(options.right, options.diagnostic.warning)
--add_table(options.right, options.diagnostic.hint)
--add_table(options.right, options.diagnostic.info)
--add_table(options.right, options.lsp_status)
--
--add_table(options.right, options.separator_right_position2)
--add_table(options.right, options.cwd)
--add_table(options.right, options.separator_right_position)
--add_table(options.right, options.position_icon)
--add_table(options.right, options.current_line)
--
----add_table(options.right, options.position_icon)
----add_table(options.right, options.current_line)
--
---- Initialize the components table
--options.components = { active = {} }
--
--options.components.active[1] = options.left
--options.components.active[2] = options.middle
--options.components.active[3] = options.right
--
--options.theme = {
--  bg = options.colors.statusline_bg,
--  fg = options.colors.fg,
--}
--
--feline.setup {
--  theme = options.theme,
--  components = options.components,
--}
--
--local winbar_components = {
--  file = {
--    provider = {
--      name = "file_info",
--      --opts = {
--      --    file_readonly_icon = '',
--      --    file_modified_icon = '',
--      --},
--    },
--    left_sep = {
--      str = "  ",
--    },
--    --hl = { bg = '#1c1c1c', style = 'bold' },
--  },
--  gps = {
--    provider = function()
--      --local gps_loaded, gps = pcall(require, "nvim-gps")
--      --if not gps_loaded then
--      --    return
--      --end
--
--      --local location = gps.get_location()
--      --return location == "" and "" or "  " .. location
--
--      local gps_loaded, gps = pcall(require, "nvim-navic")
--      if not gps_loaded then
--        return
--      end
--
--      local location = gps.get_location()
--      return location == "" and "" or "  " .. location
--    end,
--    enabled = function()
--      --local gps_loaded, gps = pcall(require, "nvim-gps")
--
--      --if not gps_loaded then
--      --    return false
--      --end
--      --return gps.is_available()
--
--      local gps_loaded, gps = pcall(require, "nvim-navic")
--
--      if not gps_loaded then
--        return false
--      end
--      return gps.is_available()
--    end,
--    --    hl = { fg = '#eeeeee', bg = '#1c1c1c' },
--    hl = {
--      fg = options.colors.purple,
--      bg = options.colors.statusline_bg,
--    },
--  },
--}
--local winbar = {
--  {
--    --        winbar_components.file,
--    winbar_components.gps,
--  },
--}
--feline.winbar.setup({
--  --components = { active = winbar, inactive = winbar },
--  components = { active = winbar },
--  disable = {
--    filetypes = {
--      "term",
--      "startify",
--      "NvimTree",
--      "packer",
--      "Telescop",
--    },
--  },
--})
