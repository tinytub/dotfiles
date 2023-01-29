-- may be try https://github.com/anuvyklack/dotfiles/blob/main/roles/neovim/files/lua/anuvyklack/heirline/init.lua
-- https://github.com/rebelot/dotfiles/blob/master/nvim/lua/plugins/heirline.lua

-- https://github.com/JK-Flip-Flop96/nvim-config/blob/main/lua/configs/heirline.lua
-- Load Heirline
local heirline_status, heirline = pcall(require, "heirline")

-- Exit on Load Error
if not heirline_status then
  return
end

-- Custom Configuration for Heirline

-- Load Heirline's utilities
local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

-- ## COLOURS ## --

-- Get the palette from Catppuccin
local function setup_colors()
  return require("catppuccin.palettes").get_palette()
end

-- Pass the colours to Heirline
heirline.load_colors(setup_colors())

vim.api.nvim_create_augroup("Heirline", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    local colors = setup_colors()
    utils.on_colorscheme(colors)
  end,
  group = "Heirline",
})

-- ## GENERIC STATUS LINE COMPONENTS ## --

-- Alignment components
local Space = { provider = " " }
local Align = { provider = "%=" }

-- ## STATUS LINE COMPONENTS ## --

local ViMode = {
  init = function(self)
    self.mode = vim.fn.mode(1)
    if not self.once then
      vim.cmd("au ModeChanged *:*o redrawstatus")
    end
    self.once = true
  end,
  static = {
    mode_names = {
      n = "NORMAL",
      no = "NORMAL [?]",
      nov = "NORMAL [?]",
      noV = "NORMAL [?]",
      ["no\22"] = "NORMAL [?]",
      niI = "NORMAL [i]",
      niR = "NORMAL [r]",
      niV = "NORMAL [v]",
      nt = "NORMAL [t]",
      v = "VISUAL",
      vs = "VISUAL [s]",
      V = "VISUAL_",
      Vs = "VISUAL [s]",
      ["\22"] = "^VISUAL",
      ["\22s"] = "^VISUAL",
      s = "SELECT",
      S = "SELECT_",
      ["\19"] = "^SELECT",
      i = "INSERT",
      ic = "INSERT [c]",
      ix = "INSERT [x]",
      R = "REPLACE",
      Rc = "REPLACE [c]",
      Rx = "REPLACE [x]",
      Rv = "REPLACE [v]",
      Rvc = "REPLACE [v]",
      Rvx = "REPLACE [v]",
      c = "COMMAND",
      cv = "EX",
      r = "...",
      rm = "M",
      ["r?"] = "?",
      ["!"] = "!",
      t = "TERMINAL",
    },
  },
  provider = function(self)
    return "  %2(" .. self.mode_names[self.mode] .. " %)"
  end,

  hl = function(self)
    -- Get the pair of colours from the table
    local m_colors = self:mode_color()

    -- Return the highlight
    return { bg = m_colors[1], fg = m_colors[2], bold = true }
  end,

  update = {
    "ModeChanged",
  },
}
-- Mode Indicator - Modified from the Heirline Cookbook
--local ViMode = {
--  init = function(self)
--    self.mode = vim.fn.mode(1)
--
--    if not self.once then
--      vim.api.nvim_create_autocmd("ModeChanged", { command = 'redrawstatus' })
--    end
--  end,
--
--  -- Define the text used in each mode
--  static = {
--    mode_names = {
--      n = "NORMAL",
--      no = "NORMAL [?]",
--      nov = "NORMAL [?]",
--      noV = "NORMAL [?]",
--      ["no\22"] = "NORMAL [?]",
--      niI = "NORMAL [i]",
--      niR = "NORMAL [r]",
--      niV = "NORMAL [v]",
--      nt = "NORMAL [t]",
--      v = "VISUAL",
--      vs = "VISUAL [s]",
--      V = "VISUAL_",
--      Vs = "VISUAL [s]",
--      ["\22"] = "^VISUAL",
--      ["\22s"] = "^VISUAL",
--      s = "SELECT",
--      S = "SELECT_",
--      ["\19"] = "^SELECT",
--      i = "INSERT",
--      ic = "INSERT [c]",
--      ix = "INSERT [x]",
--      R = "REPLACE",
--      Rc = "REPLACE [c]",
--      Rx = "REPLACE [x]",
--      Rv = "REPLACE [v]",
--      Rvc = "REPLACE [v]",
--      Rvx = "REPLACE [v]",
--      c = "COMMAND",
--      cv = "EX",
--      r = "...",
--      rm = "M",
--      ["r?"] = "?",
--      ["!"] = "!",
--      t = "TERMINAL",
--    },
--  },
--
--  -- Define the layout of the indicator
--  provider = function(self)
--    return " %2(" .. self.mode_names[self.mode] .. " %)"
--  end,
--
--  -- Define the colours of the indicator
--  hl = function(self)
--    -- Get the pair of colours from the table
--    local m_colors = self:mode_color()
--
--    -- Return the highlight
--    return { bg = m_colors[1], fg = m_colors[2], }
--  end,
--
--  -- Update when the vim mode changes
--  update = "ModeChanged"
--}

-- Get the cwd and add it to the statusline.
local WorkDir = {
  provider = function()
    -- Prepend a 'g' for a global working directory or an 'l' for a local working directory
    local icon = (vim.fn.haslocaldir(0) == 1 and " " or " ") .. " "

    -- Get the current working directory
    local cwd = vim.fn.getcwd(0)

    -- Shorten the cwd relative to the home dir if appropriate
    cwd = vim.fn.fnamemodify(cwd, ":~")

    -- Shorten the cwd if it's too long
    if not conditions.width_percent_below(#cwd, 0.25) then
      cwd = vim.fn.pathshorten(cwd)
    end

    -- Add a trailing space and a slash if there isn't one
    local trail = cwd:sub(-1) == '/' and ' ' or "/ "

    -- Concatonate the icon and cwd
    return icon .. cwd .. trail
  end,

  -- Set the colour
  hl = { fg = "subtext0", bg = "surface0", bold = false },

  -- Toggle nvim-tree when the cwd is clicked
  on_click = {
    callback = function()
      vim.cmd("NvimTreeToggle")
    end,
    name = "heirline_nvimtree",
  },
}

-- Basic Ruler
local Ruler = {
  provider = "  Ln %l/%L Cl %c ",
  hl = { fg = "subtext0", bg = "surface0" }
}

-- Git Information
local GitFolder = {
  conditions = conditions.is_git_repo,
  update = { "BufEnter", "BufWrite" },
  init = function(self)
    local status_table = {}

    for s in vim.fn.system("git status --porcelain"):gmatch("[^\r\n]+") do
      table.insert(status_table, s)
    end

    local untracked, modified, staged = 0, 0, 0

    for _, line in ipairs(status_table) do
      local X = line:sub(1, 1)
      local Y = line:sub(2, 2)
      if X == "?" and Y == "?" then
        untracked = untracked + 1
      else
        if Y == "M" then
          modified = modified + 1
        end
        if Y == "A" or X == "M" then
          staged = staged + 1
        end
      end
    end

    self.status_dict = {
      untracked = untracked,
      modified = modified,
      staged = staged,
      head = vim.fn.system("git rev-parse --abbrev-ref HEAD"):gsub("%s+", ""),
    }
    self.has_changes = self.status_dict.untracked ~= 0 or self.status_dict.modified ~= 0 or self.status_dict.staged ~= 0
  end,

  hl = { fg = "subtext0", bg = "surface1" },
  {
    conditions = function(self)
      return self.status_dict.head:sub(1, 5) ~= 'fatal'
    end,
    provider = function(self)
      return "  " .. self.status_dict.head .. " "
    end,
    hl = { bg = "surface0" },
  },
  {
    condition = function(self)
      return self.has_changes
    end,
    provider = " ",
    hl = { fg = "surface1" }
  },
  {
    provider = function(self)
      local count = self.status_dict.staged or 0
      return count > 0 and (" " .. count .. " ")
    end,
    hl = { fg = "teal" }
  },
  {
    provider = function(self)
      local count = self.status_dict.modified or 0
      return count > 0 and (" " .. count .. " ")
    end,
    hl = { fg = "peach" }
  },
  {
    provider = function(self)
      local count = self.status_dict.untracked or 0
      return count > 0 and (" " .. count .. " ")
    end,
    hl = { fg = "blue" }
  },
  on_click = {
    callback = function()
      vim.defer_fn(function()
        Lazygit_Toggle()
      end, 100)
    end,
    name = "heirline_lazygit",
  }
}

local GitFile = {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(0)
  end,
  {
    provider = function(self)
      local filename = self.filename
      filename = filename == "" and "[No Name]" or vim.fn.fnamemodify(filename, ":t")
      return "  " .. filename .. " "
    end,
    hl = { fg = "subtext0", bg = "surface0" },
  },
  {
    conditions = conditions.is_git_repo,

    init = function(self)
      self.status_dict = vim.b.gitsigns_status_dict or { head = '', added = 0, changed = 0, removed = 0 }
      self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
    end,

    hl = { fg = "subtext0", bg = "surface1" },

    {
      condition = function(self)
        return self.has_changes
      end,
      provider = " ",
      hl = { fg = "surface1" }
    },
    {
      provider = function(self)
        local count = self.status_dict.added or 0
        return count > 0 and (" " .. count .. " ")
      end,
      hl = { fg = "green" }
    },
    {
      provider = function(self)
        local count = self.status_dict.changed or 0
        return count > 0 and (" " .. count .. " ")
      end,
      hl = { fg = "yellow" }
    },
    {
      provider = function(self)
        local count = self.status_dict.removed or 0
        return count > 0 and (" " .. count .. " ")
      end,
      hl = { fg = "red" }
    },
  }
}

local LSPActive = {
  conditions = conditions.lsp_attached,
  update = { 'LspAttach', 'LspDetach', 'BufEnter' },

  provider = function()
    local names = {}
    for _, server in pairs(vim.lsp.buf_get_clients(0)) do
      local name = server.name

      -- Explicitly exclude copilot and null-ls from this element
      if name ~= "copilot" and name ~= "null-ls" then
        table.insert(names, name)
      end
    end

    -- If there are no names, return nothing
    if #names == 0 then
      return ""
    else
      return "  " .. table.concat(names, " ") .. " "
    end
  end,
  hl = { fg = "subtext0", bg = "surface0" }
}

-- Diagnostics signs
local Diagnostics = {
  -- Only display this component if diagnostics are available for the current buffer
  conditions = conditions.has_diagnostics,

  -- Get the icons for the diagnostics

  static = {
    error_icon = " ",
    warn_icon = " ",
    info_icon = " ",
    hint_icon = " ",
    --   error_icon = vim.fn.sign_getdefined("DiagnosticSignError")[1].text,
    --   warn_icon = vim.fn.sign_getdefined("DiagnosticSignWarn")[1].text,
    --   info_icon = vim.fn.sign_getdefined("DiagnosticSignInfo")[1].text,
    --   hint_icon = vim.fn.sign_getdefined("DiagnosticSignHint")[1].text,
  },



  -- Get the counts for each type of diagnostic message
  init = function(self)
    self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
    self.total = self.errors + self.warnings + self.hints + self.info
  end,

  -- Update when the diagnostics change or when entering a new buffer
  update = { "DiagnosticChanged", "BufEnter" },

  -- Bring up the Trouble diagnostics windown when the element is clicked
  on_click = {
    callback = function()
      require("trouble").toggle({ mode = "document_diagnostics" })
    end,
    name = "heirline_diagnostics",
  },

  -- Define the text to display
  {
    -- Leading space
    provider = function(self)
      return self.total > 0 and " "
    end,
    hl = { bg = "surface1" },
  },
  {
    -- Errors
    provider = function(self)
      return self.errors > 0 and (self.error_icon .. self.errors .. " ")
    end,
    hl = { fg = "red", bg = "surface1" },
  },
  {
    -- Warnings
    provider = function(self)
      return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
    end,
    hl = { fg = "yellow", bg = "surface1" },
  },
  {
    -- Info
    provider = function(self)
      return self.info > 0 and (self.info_icon .. self.info .. " ")
    end,
    hl = { fg = "blue", bg = "surface1" },
  },
  {
    -- Hints
    provider = function(self)
      return self.hints > 0 and (self.hint_icon .. self.hints .. " ")
    end,
    hl = { fg = "teal", bg = "surface1" },
  },
}

-- File Type/Info

local FileType = {
  provider = function()
    return string.upper(vim.bo.filetype)
  end,
  hl = { fg = utils.get_highlight("Type").fg }
}

local FileEncoding = {
  provider = function()
    local enc = (vim.bo.fenc ~= '' and vim.bo.fenc) or vim.o.enc
    return " " .. enc:upper() .. " "
  end,
  hl = { fg = "subtext0", bg = "surface0" }
}

local FileFormat = {
  provider = function()
    local fmt = vim.bo.fileformat
    return " " .. fmt:upper() .. " "
  end,
  hl = { fg = "subtext0", bg = "surface0" }
}

local FileIcon = {
  init = function(self)
    local filename = self.filename
    local extension = vim.fn.fnamemodify(filename, ":e")

    self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
  end,
  provider = function(self)
    return self.icon and (self.icon .. " ")
  end,
  hl = function(self)
    return { fg = self.icon_color }
  end
}

local LanguageBlock = {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(0)
  end,
  Space,
  FileIcon,
  FileType,
  Space,
  hl = function(self)
    -- Colour this element based on the current vim mode
    local mode_color = self:mode_color()
    return { bg = mode_color[1], fg = mode_color[2], force = true }
  end,
}

local ShowCommand = {
  condition = false,
  provider = function()
    if require("noice").api.statusline.command.get() == nil then
      return ""
    else
      return "  " .. require("noice").api.statusline.command.get() .. " "
    end
  end,
  hl = { fg = "subtext0", bg = "surface0" }
}

local SearchResults = {
  condition = function(self)
    local lines = vim.api.nvim_buf_line_count(0)
    if lines > 50000 then return end

    local query = vim.fn.getreg("/")
    if query == "" then return end

    if query:find("@") then return end

    local search_count = vim.fn.searchcount({ recompute = 1, maxcount = -1 })
    local active = false
    if vim.v.hlsearch and vim.v.hlsearch == 1 and search_count.total > 0 then
      active = true
    end
    if not active then return end

    query = query:gsub([[\\v]], "")
    query = query:gsub([[\<]], ""):gsub([[\>]], "")

    self.query = query
    self.count = search_count
    return true
  end,
  {
    provider = function(self)
      return '  ' .. self.query .. ' '
    end,
    hl = { fg = "subtext0", bg = "surface0" }
  },
  {
    provider = function(self)
      return ' ' .. self.count.current .. '/' .. self.count.total .. ' '
    end,
    hl = { fg = "rosewater", bg = "surface1" }
  },
  Space
}

local StatusLineOffset = {
  condition = function(self)
    local win = vim.api.nvim_tabpage_list_wins(0)[1]
    local bufnr = vim.api.nvim_win_get_buf(win)
    self.winid = win

    if vim.bo[bufnr].filetype == "NvimTree" then
      return true
    end
    if vim.bo[bufnr].filetype == "neotree" then
      return true
    end
  end,
  {
    provider = function(self)
      return string.rep(" ", vim.api.nvim_win_get_width(self.winid))
    end,

    hl = { bg = "mantle" },
  },
}

--    return { bg = m_colors[1], fg = m_colors[2], }
--ViMode = utils.surround({ "", "" }, m_colors[1], { ViMode })
-- Build out the status line
local statusline = {
  {
    StatusLineOffset,
    ViMode,
    WorkDir,
    Space,
    GitFile,
    Space,
    GitFolder,
    Space,
    Align,
    SearchResults,
    LSPActive,
    Diagnostics,
    -- ShowCommand,
    Space,
    Ruler,
    Space,
    FileEncoding,
    Space,
    FileFormat,
    Space,
    LanguageBlock,
  },
  static = {
    -- Define the color used in each mode
    mode_colors_map = {
      n = { "blue", "base" },
      i = { "green", "base" },
      v = { "teal", "base" },
      V = { "teal", "base" },
      ["\22"] = { "teal", "base" },
      c = { "peach", "base" },
      s = { "mauve", "base" },
      S = { "mauve", "base" },
      ["\19"] = { "mauve", "base" },
      R = { "peach", "base" },
      r = { "peach", "base" },
      ["!"] = { "red", "base" },
      t = { "red", "base" },
    },

    -- Function to get the current mode colour
    mode_color = function(self)
      local mode = conditions.is_active() and vim.fn.mode() or "n"
      return self.mode_colors_map[mode]
    end,
  }
}

-- ## WINBAR ## --

local Navic = {
  condition = require("nvim-navic").is_available,
  static = {
    type_hl = {
      File = "Directory",
      Module = "@include",
      Namespace = "@namespace",
      Package = "@include",
      Class = "@structure",
      Method = "@method",
      Property = "@property",
      Field = "@field",
      Constructor = "@constructor",
      Enum = "@field",
      Interface = "@type",
      Function = "@function",
      Variable = "@variable",
      Constant = "@constant",
      String = "@string",
      Number = "@number",
      Boolean = "@boolean",
      Array = "@field",
      Object = "@type",
      Key = "@keyword",
      Null = "@comment",
      EnumMember = "@field",
      Struct = "@structure",
      Event = "@keyword",
      Operator = "@operator",
      TypeParameter = "@type",
    },
  },
  init = function(self)
    local data = require("nvim-navic").get_data() or {}
    local children = {}
    local fg_hl = conditions.is_active() and "subtext1" or "overlay0"

    for i, d in ipairs(data) do
      if i == 1 then
        table.insert(children, { provider = "> ", hl = { fg = fg_hl } })
      end

      local child = {
        {
          provider = d.icon,
          hl = self.type_hl[d.type],
        },
        {
          provider = d.name,
          hl = { fg = fg_hl },
        },
      }

      if i < #data then
        table.insert(child, {
          provider = " > ",
          hl = { fg = fg_hl },
        })
      end

      table.insert(children, child)

    end

    self[1] = self:new(children, 1)
  end,
  hl = { fg = "subtext0" },
}

local WinbarFileName = {
  provider = function(self)
    local filename = self.filename
    filename = filename == "" and "[No Name]" or vim.fn.fnamemodify(filename, ":t")
    return filename
  end,
}

local WinbarFileNameBlock = {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(0)
  end,
  Space,
  FileIcon,
  WinbarFileName
}

-- Build out the winbar
local FileWinbar = {
  Space,
  WinbarFileNameBlock,
  Space,
  Navic,
  Align,
  hl = function()
    if conditions.is_active() then
      return { fg = "subtext1", bg = "surface1" }
    else
      return { fg = "overlay0", bg = "surface0" }
    end
  end,
}

local TerminalWinbar = {
  Align,
  {
    provider = "TERMINAL",
  },
  Align,
  hl = function()
    if conditions.is_active() then
      return { fg = "red", bg = "surface1" }
    else
      return { fg = "red", bg = "surface0" }
    end
  end,
}


local winbar = {
  fallthrough = false,
  {
    condition = function()
      return conditions.buffer_matches({
        buftype = { "nofile", "terminal", "prompt", "help", "quickfix", "nvimtree", "neotree" },
        filetype = { "^git.*", "alpha", "nvimtree", "dashboard", "neotree" },
      })
    end,
    init = function()
      vim.opt_local.winbar = nil
    end,
  },
  {
    condition = function()
      return conditions.buffer_matches({
        buftype = { "terminal" },
      })
    end,
    TerminalWinbar
  },
  {
    FileWinbar,
  }
}

---- ## TABLINE ## --
--
---- Get the number of the buffer
--local TablineBufnr = {
--  provider = function(self)
--    return tostring(self.bufnr) .. ": "
--  end,
--  hl = function(self)
--    if self.is_active then
--      return "TabLineSel"
--    else
--      return "TabLine"
--    end
--  end,
--}
--
---- Get the file's name
--local TablineFileName = {
--  provider = function(self)
--    local filename = self.filename
--    filename = filename == "" and "[No Name]" or vim.fn.fnamemodify(filename, ":t")
--    return filename
--  end,
--  -- Bold the text if the buffer is visible
--  hl = function(self)
--    return { bold = self.is_active or self.is_visible }
--  end,
--}
--
---- Add additional icons to the block based on the file's flags
--local TablineFileFlags = {
--  {
--    provider = function(self)
--      if vim.bo[self.bufnr].modified then
--        return " "
--      end
--    end,
--    hl = { fg = "yellow" }
--  },
--  {
--    provider = function(self)
--      if not vim.bo[self.bufnr].modifiable or vim.bo[self.bufnr].readonly then
--        return " "
--      end
--    end,
--    hl = { fg = "peach" },
--  },
--}
--
---- Construct the final file name block
--local TablineFileNameBlock = {
--  -- Get the file's name on initialisation
--  init = function(self)
--    self.filename = vim.api.nvim_buf_get_name(self.bufnr)
--  end,
--  hl = function(self)
--    if self.is_active then
--      return "TabLineSel"
--    else
--      return "TabLine"
--    end
--  end,
--  on_click = {
--    callback = function(_, minwid, _, button)
--      if (button == "m") then
--        vim.api.nvim_buf_delete(minwid, { force = false })
--      else
--        vim.api.nvim_win_set_buf(0, minwid)
--      end
--    end,
--    minwid = function(self)
--      return self.bufnr
--    end,
--    name = "heirline_tabline_buffer_callback"
--  },
--  TablineBufnr,
--  FileIcon,
--  TablineFileName,
--  TablineFileFlags,
--}
--
---- Add a close button to the buffer block
--local TablineCloseButton = {
--  condition = function(self)
--    return not vim.bo[self.bufnr].modified
--  end,
--  Space,
--  {
--    provider = "",
--    on_click = {
--      callback = function(_, minwid)
--        vim.api.nvim_buf_delete(minwid, { force = false })
--      end,
--
--      minwid = function(self)
--        return self.bufnr
--      end,
--      name = "heirline_tabline_close_buffer_callback",
--    },
--  },
--  hl = function(self)
--    if self.is_active then
--      return "TabLineSel"
--    else
--      return "TabLine"
--    end
--  end,
--}

--local TablineBufferBlockLeft = {
--  provider = "▎ ",
--  hl = function(self)
--    if self.is_active then
--      return { bg = utils.get_highlight("TablineSel").bg, fg = utils.get_highlight("TablineFill").bg }
--    else
--      return { bg = utils.get_highlight("Tabline").bg, fg = utils.get_highlight("TablineFill").bg }
--    end
--  end,
--}

--local TablineBufferBlockRight = {
--  provider = "█▊",
--  hl = function(self)
--    if self.is_active then
--      return { bg = utils.get_highlight("TablineFill").bg, fg = utils.get_highlight("TablineSel").bg }
--    else
--      return { bg = utils.get_highlight("TablineFill").bg, fg = utils.get_highlight("Tabline").bg }
--    end
--  end,
--}
--
---- Construct the final buffer block
--local TablineBufferBlock = { TablineBufferBlockLeft, TablineFileNameBlock, TablineCloseButton, TablineBufferBlockRight }

-- Construct the bufferline using the elements defined above
--local BufferLine = utils.make_buflist(
--  TablineBufferBlock,
--  -- Define the icons used for left/right truncation
--  { provicer = "", hl = { fg = "subtext0" } },
--  { provicer = "", hl = { fg = "subtext0" } }
--)
--
--local TabPage = {
--  provider = function(self)
--    return "%" .. self.tabnr .. "T " .. self.tabnr .. " %T"
--  end,
--  hl = function(self)
--    if not self.is_active then
--      return "TabLine"
--    else
--      return "TabLineSel"
--    end
--  end,
--}

--local TabPageClose = {
--  provider = "%999X  %X",
--  hl = "TabLine",
--}
--
--local TabPages = {
--  condition = function()
--    return #vim.api.nvim_list_tabpages() >= 2
--  end,
--  Align, -- Make the following component right justified
--  utils.make_tablist(TabPage),
--  TabPageClose,
--}

--local TablineOffset = {
--  condition = function(self)
--    local win = vim.api.nvim_tabpage_list_wins(0)[1]
--    local bufnr = vim.api.nvim_win_get_buf(win)
--    self.winid = win
--
--    if vim.bo[bufnr].filetype == "NvimTree" then
--      self.title = "Files"
--      return true
--    end
--  end,
--  {
--    provider = function(self)
--      local title = self.title
--      local width = vim.api.nvim_win_get_width(self.winid)
--      local leftpad = math.ceil((width - #title) / 2)
--      local rightPad = leftpad
--
--      -- Correct for odd widths
--      if width % 2 ~= #title % 2 then
--        rightPad = rightPad - 1
--      end
--
--      return string.rep(" ", leftpad) .. title .. string.rep(" ", rightPad)
--    end,
--
--    hl = function(self)
--      if vim.api.nvim_get_current_win() == self.winid then
--        return "TabLineSel"
--      else
--        return "TabLine"
--      end
--    end,
--
--  },
--  {
--    Space,
--  },
--
--}

-- Build out the tabline
--local tabline = { TablineOffset, BufferLine, TabPages }

-- Set the statusline
--heirline.setup({ TablineOffset, statusline }, winbar, tabline)
heirline.setup({
  statusline = statusline,
  winbar = winbar
})
