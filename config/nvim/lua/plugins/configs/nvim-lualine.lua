--local navic = require('nvim-navic')
--
--local icons = require("plugins.configs.lspkind_icons")
--local Utils = require("utils")
--
---- https://github.com/Strazil001/Nvim/blob/main/after/plugin/lualine.lua
---- https://github.com/LazyVim/LazyVim
--
--local colors = {
--  red = '#cdd6f4',
--  grey = '#181825',
--  black = '#1e1e2e',
--  white = '#313244',
--  base = "#24273A", -- https://github.com/catppuccin/nvim/blob/main/lua/catppuccin/palettes/macchiato.lua
--  light_green = '#6c7086',
--  orange = '#fab387',
--  green = '#a6e3a1',
--  blue = '#80A7EA',
--}
---- is e0bc, nf-ple-upper_left_triangle
---- is e0ba, nf-ple-lower_right_triangle
--
--
--local vim_icons = {
--  function()
--    --return " "
--    return " "
--
--  end,
--  separator = { left = "", right = "" },
--  color = { bg = "#313244", fg = "#80A7EA" },
--  padding = { left = 1, right = 0 }
--}
--
--local space = {
--  function()
--    return " "
--  end,
--  color = { bg = colors.base, fg = "#80A7EA" },
--  padding = { left = 0, right = 0 }
--}
--
--local dir = {
--  function()
--
--    local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
--
--    return dir_name
--    --if vim.b.vaffle ~= nil then
--    --  local short_path = M.shorten(vim.b.vaffle["dir"])
--    --  return short_path
--    --end
--
--    --if vim.b.short_path == nil then
--    --  vim.b.short_path = M.shorten(vim.fn.expand("%:p:h"))
--    --end
--    --print("dir")
--
--    --return vim.b.short_path
--  end,
--  separator = { left = "", right = "" },
--  icon = "",
--}
--
----local function dir()
----  local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
----
----  return dir_name
----end
--
--local filename = {
--  'filename',
--  color = { bg = "#80A7EA", fg = "#242735" },
--  path = 1,
--  separator = { left = "", right = "" },
--}
--
--local filetype = {
--  "filetype",
--  icon_only = true,
--  colored = true,
--  color = { bg = "#313244" },
--  separator = { left = "", right = "" },
--}
--
----local filetype_tab = {
----  "filetype",
----  icon_only = true,
----  colored = true,
----  color = { bg = "#313244" },
----}
--
----local buffer = {
----  require 'tabline'.tabline_buffers,
----  separator = { left = "", right = "" },
----}
----
----local tabs = {
----  require 'tabline'.tabline_tabs,
----  separator = { left = "", right = "" },
----}
--
--local fileformat = {
--  'fileformat',
--  color = { bg = "#b4befe", fg = "#313244" },
--  separator = { left = "", right = "" },
--}
--
--local encoding = {
--  'encoding',
--  color = { bg = "#313244", fg = "#80A7EA" },
--  separator = { left = "", right = "" },
--}
--
--local branch = {
--  'branch',
--  color = { bg = "#a6e3a1", fg = "#313244" },
--  separator = { left = "", right = "" },
--}
--
--local function buffer_git_diff()
--  local diff = vim.b.gitsigns_status_dict
--
--  if diff then
--    return { added = diff.added, modified = diff.changed, removed = diff.removed }
--  else
--    return {}
--  end
--end
--
--local function buffer_not_empty()
--  return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
--end
--
--local diff = {
--  "diff",
--  color = { bg = "#313244", fg = "#313244" },
--  cond = buffer_not_empty,
--  separator = { left = "", right = "" },
--  symbols = {
--    added = icons.git.added,
--    modified = icons.git.modified,
--    removed = icons.git.removed,
--  },
--
--  -- condition buffer_not_empty
--  source = buffer_git_diff,
--}
--
--local modes = {
--  'mode', fmt = function(str) return str:sub(1, 1) end,
--  --color = { bg = "#fab387		", fg = "#1e1e2e" },
--  separator = { left = "", right = "" },
--}
--
--local function getLspName()
--  local msg = 'No Active Lsp'
--  local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
--  local clients = vim.lsp.get_active_clients()
--  if next(clients) == nil then
--    return msg
--  end
--  for _, client in ipairs(clients) do
--    local filetypes = client.config.filetypes
--    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
--      --return "  " .. client.name
--      return " " .. client.name
--    end
--  end
--  return "  " .. msg
--end
--
--local dia = {
--  'diagnostics',
--  cond = buffer_not_empty,
--  color = { bg = "#313244", fg = "#80A7EA" },
--  separator = { left = "", right = "" },
--  symbols = {
--    error = icons.diagnostics.Error,
--    warn = icons.diagnostics.Warn,
--    info = icons.diagnostics.Info,
--    hint = icons.diagnostics.Hint,
--  },
--}
--
--local lsp = {
--  function()
--    return getLspName()
--  end,
--
--  cond = buffer_not_empty,
--  separator = { left = "", right = "" },
--  color = { bg = "#f38ba8", fg = "#1e1e2e" },
--}
--
--local opts = {
--  options = {
--    icons_enabled = true,
--    theme = "auto",
--    globalstatus = true,
--    disabled_filetypes = { statusline = { "alpha", "dashboard", "alpha", "neo-tree", "terminal" } },
--    --component_separators = { left = "", right = "" },
--    --section_separators = { left = "", right = "" },
--    --component_separators = { left = '', right = '' },
--    --section_separators = { left = '', right = '' },
--    component_separators = { left = '', right = '' },
--    section_separators = { left = '', right = '' },
--
--    ignore_focus = {},
--    always_divide_middle = true,
--    refresh = {
--      statusline = 1000,
--      --tabline = 1000,
--      winbar = 1000,
--    }
--  },
--  sections = {
--    lualine_a = {
--      { "mode", separator = { left = "", right = "" } },
--      --"mode",
--      --modes,
--      vim_icons,
--    },
--    lualine_b = {
--      --"branch"
--      space,
--      dir,
--      space,
--    },
--    lualine_c = {
--      filename,
--      filetype,
--      space,
--      branch,
--      diff,
--      --{
--      --  function() return require("nvim-navic").get_location() end,
--      --  cond = function() return package.loaded["nvim-navic"] and require("nvim-navic").is_available() end,
--      --},
--      --{
--      --  "diagnostics",
--      --  symbols = {
--      --    error = icons.diagnostics.Error,
--      --    warn = icons.diagnostics.Warn,
--      --    info = icons.diagnostics.Info,
--      --    hint = icons.diagnostics.Hint,
--      --  },
--      --},
--      --{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
--      --{ "filename",
--      --  path = 1,
--      --  symbols = { modified = "  ", readonly = "", unnamed = "" },
--      --  shorting_target = 30, -- Shortens path to leave 40 space in the window
--      --},
--      ---- stylua: ignore
--      --{
--      --  function() return require("nvim-navic").get_location() end,
--      --  cond = function() return package.loaded["nvim-navic"] and require("nvim-navic").is_available() end,
--      --},
--    },
--    lualine_x = {
--      space,
--      -- stylua: ignore
--      {
--        function() return require("noice").api.status.command.get() end,
--        cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
--        color = Utils.fg("Statement"),
--      },
--      -- stylua: ignore
--      {
--        function() return require("noice").api.status.mode.get() end,
--        cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
--        color = Utils.fg("Constant"),
--      },
--      -- stylua: ignore
--      {
--        function() return "  " .. require("dap").status() end,
--        cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
--        color = Utils.fg("Debug"),
--      },
--      { require("lazy.status").updates, cond = require("lazy.status").has_updates, color = Utils.fg("Special") },
--      {
--        "diff",
--        symbols = {
--          added = icons.git.added,
--          modified = icons.git.modified,
--          removed = icons.git.removed,
--        },
--      },
--
--    },
--    lualine_y = {
--      encoding,
--      fileformat,
--      space,
--      --{ "filetype", icon_only = false, },
--
--      -- {
--      --   "progress",
--      --   fmt = function()
--      --     local msg = "No Active Lsp"
--      --     local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
--      --     local clients = vim.lsp.get_active_clients()
--      --     if next(clients) == nil then
--      --       return msg
--      --     end
--      --     for _, client in ipairs(clients) do
--      --       local filetypes = client.config.filetypes
--      --       if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
--      --         return client.name
--      --       end
--      --     end
--      --     return msg
--      --   end,
--      --   icon = " ",
--      -- }
--
--    },
--    lualine_z = {
--      dia,
--      { require("lazy.status").updates, cond = require("lazy.status").has_updates, color = Utils.fg("Special") },
--      lsp,
--      ---- { "progress", separator = "", padding = { left = 1, right = 0 } },
--      --{ "location", padding = { left = 1, right = 1 } },
--      --function()
--      --  -- encoding
--      --  local enc = (vim.bo.fenc ~= '' and vim.bo.fenc) or vim.o.enc
--      --  --return " " .. enc:upper() .. " "
--      --  return enc:upper()
--      --end,
--      --function()
--      --  -- file format
--      --  local fmt = vim.bo.fileformat
--      --  return fmt:upper()
--      --end,
--    },
--
--  },
--  inactive_sections = {
--    lualine_a = {},
--    lualine_b = {},
--    lualine_c = { 'filename' },
--    lualine_x = { 'location' },
--    lualine_y = {},
--    lualine_z = {}
--  },
--  --tabline = {
--  --  lualine_a = {
--  --    buffer,
--  --  },
--  --  lualine_b = {
--  --  },
--  --  lualine_c = {},
--  --  lualine_x = {
--  --    tabs,
--  --  },
--  --  lualine_y = {
--  --    space,
--  --  },
--  --  lualine_z = {
--  --  },
--  --},
--  extensions = { "neo-tree", "lazy" },
--  winbar = {
--    lualine_a = {},
--    lualine_b = {
--      --{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
--      --{
--      --  'filename',
--      --  path = 0,
--      --  cond = navic.is_available,
--      --  color = { gui = 'italic,bold' },
--      --  symbols = { modified = "", readonly = "", unnamed = "" },
--
--      --},
--      { navic.get_location, cond = navic.is_available },
--    },
--    lualine_c = {
--    },
--    lualine_x = {},
--    lualine_y = {
--      --{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
--      { "filetype", icon_only = true,
--        separator = { left = "", right = "" },
--        --separator = "",
--        padding = { left = 1, right = 0 }
--      },
--      {
--        'filename',
--        path = 0,
--        cond = navic.is_available,
--        color = { gui = 'italic,bold' },
--        symbols = { modified = "", readonly = "", unnamed = "" },
--      },
--    },
--    lualine_z = {},
--  },
--  inactive_winbar = {
--    lualine_a = {},
--    lualine_b = {},
--    lualine_c = {
--    },
--    lualine_x = {},
--    lualine_y = {
--      { "filetype", icon_only = true,
--        separator = { left = "", right = "" },
--        --separator = "",
--        padding = { left = 1, right = 0 }
--      },
--      --{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
--      { 'filename', path = 0, cond = navic.is_available, symbols = { modified = "", readonly = "", unnamed = "" }, },
--    },
--    lualine_z = {}
--  }
--}

--require 'lualine'.setup(opts)

return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      local navic = require('nvim-navic')

      local icons = require("plugins.configs.lspkind_icons")
      local Utils = require("utils")

      -- https://github.com/Strazil001/Nvim/blob/main/after/plugin/lualine.lua
      -- https://github.com/LazyVim/LazyVim

      local colors = {
        red = '#cdd6f4',
        grey = '#181825',
        black = '#1e1e2e',
        white = '#313244',
        base = "#24273A", -- https://github.com/catppuccin/nvim/blob/main/lua/catppuccin/palettes/macchiato.lua
        light_green = '#6c7086',
        orange = '#fab387',
        green = '#a6e3a1',
        blue = '#80A7EA',
      }
      -- is e0bc, nf-ple-upper_left_triangle
      -- is e0ba, nf-ple-lower_right_triangle


      local vim_icons = {
        function()
          --return " "
          return " "

        end,
        separator = { left = "", right = "" },
        color = { bg = "#313244", fg = "#80A7EA" },
        padding = { left = 1, right = 0 }
      }

      local space = {
        function()
          return " "
        end,
        color = { bg = colors.base, fg = "#80A7EA" },
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
        separator = { left = "", right = "" },
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
        separator = { left = "", right = "" },
      }

      local filetype = {
        "filetype",
        icon_only = true,
        colored = true,
        color = { bg = "#313244" },
        separator = { left = "", right = "" },
      }

      --local filetype_tab = {
      --  "filetype",
      --  icon_only = true,
      --  colored = true,
      --  color = { bg = "#313244" },
      --}

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
        separator = { left = "", right = "" },
      }

      local encoding = {
        'encoding',
        color = { bg = "#313244", fg = "#80A7EA" },
        separator = { left = "", right = "" },
      }

      local branch = {
        'branch',
        color = { bg = "#a6e3a1", fg = "#313244" },
        separator = { left = "", right = "" },
      }

      local function buffer_git_diff()
        local diff = vim.b.gitsigns_status_dict

        if diff then
          return { added = diff.added, modified = diff.changed, removed = diff.removed }
        else
          return {}
        end
      end

      local function buffer_not_empty()
        return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
      end

      local diff = {
        "diff",
        color = { bg = "#313244", fg = "#313244" },
        cond = buffer_not_empty,
        separator = { left = "", right = "" },
        symbols = {
          added = icons.git.added,
          modified = icons.git.modified,
          removed = icons.git.removed,
        },

        -- condition buffer_not_empty
        source = buffer_git_diff,
      }

      local modes = {
        'mode', fmt = function(str) return str:sub(1, 1) end,
        --color = { bg = "#fab387		", fg = "#1e1e2e" },
        separator = { left = "", right = "" },
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
            --return "  " .. client.name
            return " " .. client.name
          end
        end
        return "  " .. msg
      end

      local dia = {
        'diagnostics',
        cond = buffer_not_empty,
        color = { bg = "#313244", fg = "#80A7EA" },
        separator = { left = "", right = "" },
        symbols = {
          error = icons.diagnostics.Error,
          warn = icons.diagnostics.Warn,
          info = icons.diagnostics.Info,
          hint = icons.diagnostics.Hint,
        },
      }

      local lsp = {
        function()
          return getLspName()
        end,

        cond = buffer_not_empty,
        separator = { left = "", right = "" },
        color = { bg = "#f38ba8", fg = "#1e1e2e" },
      }

      return {
        options = {
          icons_enabled = true,
          theme = "auto",
          globalstatus = true,
          -- stylua: ignore
          close_command = function(n) require("mini.bufremove").delete(n, false) end,
          -- stylua: ignore
          right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
          disabled_filetypes = { statusline = { "alpha", "dashboard", "alpha", "neo-tree", "terminal" } },
          --component_separators = { left = "", right = "" },
          --section_separators = { left = "", right = "" },
          --component_separators = { left = '', right = '' },
          --section_separators = { left = '', right = '' },
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },

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
            { "mode", separator = { left = "", right = "" } },
            --"mode",
            --modes,
            vim_icons,
          },
          lualine_b = {
            --"branch"
            space,
            dir,
            space,
          },
          lualine_c = {
            filename,
            filetype,
            space,
            branch,
            diff,
            --{
            --  function() return require("nvim-navic").get_location() end,
            --  cond = function() return package.loaded["nvim-navic"] and require("nvim-navic").is_available() end,
            --},
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
            -- stylua: ignore
            {
              function() return require("noice").api.status.command.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
              color = Utils.fg("Statement"),
            },
            -- stylua: ignore
            {
              function() return require("noice").api.status.mode.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
              color = Utils.fg("Constant"),
            },
            -- stylua: ignore
            {
              function() return "  " .. require("dap").status() end,
              cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
              color = Utils.fg("Debug"),
            },
            { require("lazy.status").updates, cond = require("lazy.status").has_updates, color = Utils.fg("Special") },
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
            { require("lazy.status").updates, cond = require("lazy.status").has_updates, color = Utils.fg("Special") },
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
        extensions = { "neo-tree", "lazy" },
        winbar = {
          lualine_a = {},
          lualine_b = {
            --{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            --{
            --  'filename',
            --  path = 0,
            --  cond = navic.is_available,
            --  color = { gui = 'italic,bold' },
            --  symbols = { modified = "", readonly = "", unnamed = "" },

            --},
            { navic.get_location, cond = navic.is_available },
          },
          lualine_c = {
          },
          lualine_x = {},
          lualine_y = {
            --{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            { "filetype", icon_only = true,
              separator = { left = "", right = "" },
              --separator = "",
              padding = { left = 1, right = 0 }
            },
            {
              'filename',
              path = 0,
              cond = navic.is_available,
              color = { gui = 'italic,bold' },
              symbols = { modified = "", readonly = "", unnamed = "" },
            },
          },
          lualine_z = {},
        },
        inactive_winbar = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {
          },
          lualine_x = {},
          lualine_y = {
            { "filetype", icon_only = true,
              separator = { left = "", right = "" },
              --separator = "",
              padding = { left = 1, right = 0 }
            },
            --{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            { 'filename', path = 0, cond = navic.is_available, symbols = { modified = "", readonly = "", unnamed = "" }, },
          },
          lualine_z = {}
        }
      }
    end,
  },

}
