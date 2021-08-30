local colors = require("themes/" .. "tomorrow-night")

local present1, gl = pcall(require, "galaxyline")
local present2, condition = pcall(require, "galaxyline.condition")
if not (present1 or present2) then
   return
end

local gls = gl.section

gl.short_line_list = { " " }

local icon_styles = {
   default = {
      left = "",
      right = " ",
      main_icon = "  ",
      vi_mode_icon = " ",
      position_icon = " ",
   },

   arrow = {
      left = "",
      right = "",
      main_icon = "  ",
      vi_mode_icon = " ",
      position_icon = " ",
   },

   block = {
      left = " ",
      right = " ",
      main_icon = "   ",
      vi_mode_icon = "   ",
      position_icon = "  ",
   },

   round = {
      left = "",
      right = "",
      main_icon = "  ",
      vi_mode_icon = " ",
      position_icon = " ",
   },

   slant = {
      left = " ",
      right = " ",
      main_icon = "  ",
      vi_mode_icon = " ",
      position_icon = " ",
   },
}

--local user_statusline_style = require("core.utils").load_config().ui.plugin.statusline.style
local statusline_style = icon_styles["default"]

local left_separator = statusline_style.left
local right_separator = statusline_style.right

gls.left[1] = {
   FirstElement = {
      provider = function()
         return "▋"
      end,
      highlight = { colors.nord_blue, colors.nord_blue },
   },
}

gls.left[2] = {
   statusIcon = {
      provider = function()
         return statusline_style.main_icon
      end,
      highlight = { colors.statusline_bg, colors.nord_blue },
      separator = right_separator,
      separator_highlight = { colors.nord_blue, colors.one_bg2 },
   },
}

gls.left[3] = {
   left_arow2 = {
      provider = function() end,
      separator = right_separator .. " ",
      separator_highlight = { colors.one_bg2, colors.lightbg },
   },
}

gls.left[4] = {
   FileIcon = {
      provider = "FileIcon",
      condition = condition.buffer_not_empty,
      highlight = { colors.white, colors.lightbg },
   },
}

gls.left[5] = {
   FileName = {
      provider = function()
         local fileinfo = require "galaxyline.provider_fileinfo"

         if vim.api.nvim_buf_get_name(0):len() == 0 then
            return ""
         end

         return fileinfo.get_current_file_name("", "")
      end,
      highlight = { colors.white, colors.lightbg },
      separator = right_separator,
      separator_highlight = { colors.lightbg, colors.lightbg2 },
   },
}

gls.left[6] = {
   current_dir = {
      provider = function()
         local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
         return "  " .. dir_name .. " "
      end,
      highlight = { colors.grey_fg2, colors.lightbg2 },
      separator = right_separator,
      separator_highlight = { colors.lightbg2, colors.statusline_bg },
   },
}

local checkwidth = function()
   local squeeze_width = vim.fn.winwidth(0) / 2
   if squeeze_width > 30 then
      return true
   end
   return false
end

gls.left[7] = {
   DiffAdd = {
      provider = "DiffAdd",
      condition = checkwidth,
      icon = "  ",
      highlight = { colors.white, colors.statusline_bg },
   },
}

gls.left[8] = {
   DiffModified = {
      provider = "DiffModified",
      condition = checkwidth,
      icon = "   ",
      highlight = { colors.grey_fg2, colors.statusline_bg },
   },
}

gls.left[9] = {
   DiffRemove = {
      provider = "DiffRemove",
      condition = checkwidth,
      icon = "  ",
      highlight = { colors.grey_fg2, colors.statusline_bg },
   },
}

gls.left[10] = {
   DiagnosticError = {
      provider = "DiagnosticError",
      icon = "  ",
      highlight = { colors.red, colors.statusline_bg },
   },
}

gls.left[11] = {
   DiagnosticWarn = {
      provider = "DiagnosticWarn",
      icon = "  ",
      highlight = { colors.yellow, colors.statusline_bg },
   },
}

--gls.mid[1] = {
--   provider = function()
--      local Lsp = vim.lsp.util.get_progress_messages()[1]
--      if Lsp then
--         local msg = Lsp.message or ""
--         local percentage = Lsp.percentage or 0
--         local title = Lsp.title or ""
--         local spinners = {
--            "󰝦",
--            "󰪞",
--            "󰪟",
--            "󰪠",
--            "󰪡",
--            "󰪢",
--            "󰪣",
--            "󰪤",
--            "󰪥",
--         }
--
--         local ms = vim.loop.hrtime() / 1000000
--         local frame = math.floor(ms / 120) % #spinners
--         return string.format(" %%<%s %s %s (%s%%%%) ", spinners[frame + 1], title, msg, percentage)
--      end
--      return ""
--   end,
--   hl = { fg = colors.green },
--}

gls.right[1] = {
   lsp_status = {
      provider = function()
         local clients = vim.lsp.get_active_clients()
         if next(clients) ~= nil then
            local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
            for _, client in ipairs(clients) do
               local filetypes = client.config.filetypes
               if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                  return "   LSP "
              else
                  return ""
               end
            end
            return ""
         else
            return ""
         end
      end,
      highlight = { colors.grey_fg2, colors.statusline_bg },
   },
}

gls.right[2] = {
   GitIcon = {
      provider = function()
         return " "
      end,
      condition = require("galaxyline.condition").check_git_workspace,
      highlight = { colors.grey_fg2, colors.statusline_bg },
      separator = " ",
      separator_highlight = { colors.statusline_bg, colors.statusline_bg },
   },
}

gls.right[3] = {
   GitBranch = {
      provider = function()
         local git_branch = ""
         -- first try with gitsigns
         local gs_dict = vim.b.gitsigns_status_dict
         if gs_dict then
            git_branch = (gs_dict.head and #gs_dict.head > 0 and gs_dict.head) or git_branch
         else
            -- path seperator
            local branch_sep = package.config:sub(1, 1)
            -- get file dir so we can search from that dir
            local file_dir = vim.fn.expand "%:p:h" .. ";"
            -- find .git/ folder genaral case
            local git_dir = vim.fn.finddir(".git", file_dir)
            -- find .git file in case of submodules or any other case git dir is in
            -- any other place than .git/
            local git_file = vim.fn.findfile(".git", file_dir)
            -- for some weird reason findfile gives relative path so expand it to fullpath
            if #git_file > 0 then
               git_file = vim.fn.fnamemodify(git_file, ":p")
            end
            if #git_file > #git_dir then
               -- separate git-dir or submodule is used
               local file = io.open(git_file)
               git_dir = file:read()
               git_dir = git_dir:match "gitdir: (.+)$"
               file:close()
               -- submodule / relative file path
               if git_dir:sub(1, 1) ~= branch_sep and not git_dir:match "^%a:.*$" then
                  git_dir = git_file:match "(.*).git" .. git_dir
               end
            end
   
            if #git_dir > 0 then
               local head_file = git_dir .. branch_sep .. "HEAD"
               local f_head = io.open(head_file)
               if f_head then
                  local HEAD = f_head:read()
                  f_head:close()
                  local branch = HEAD:match "ref: refs/heads/(.+)$"
                  if branch then
                     git_branch = branch
                  else
                     git_branch = HEAD:sub(1, 6)
                  end
               end
            end
         end
         return (git_branch ~= "" and "  " .. git_branch) or git_branch
      end,

      highlight = { colors.grey_fg2, colors.statusline_bg },
      --provider = "GitBranch",
      --condition = require("galaxyline.condition").check_git_workspace,
      --highlight = { colors.grey_fg2, colors.statusline_bg },
   },
}

local mode_colors = {
   ['n'] = { "NORMAL", colors.red },
   ['no'] = { "N-PENDING", colors.red },
   ['i'] = { "INSERT", colors.dark_purple },
   ['ic'] = { "INSERT", colors.dark_purple },
   ['t'] = { "TERMINAL", colors.green },
   ['v'] = { "VISUAL", colors.cyan },
   ['V'] = { "V-LINE", colors.cyan },
   [''] = { "V-BLOCK", colors.cyan },
   ['R'] = { "REPLACE", colors.orange },
   ['Rv'] = { "V-REPLACE", colors.orange },
   ['s'] = { "SELECT", colors.nord_blue },
   ['S'] = { "S-LINE", colors.nord_blue },
   [''] = { "S-BLOCK", colors.nord_blue },
   ['c'] = { "COMMAND", colors.pink },
   ['cv'] = { "COMMAND", colors.pink },
   ['ce'] = { "COMMAND", colors.pink },
   ['r'] = { "PROMPT", colors.teal },
   ['rm'] = { "MORE", colors.teal },
   ['r?'] = { "CONFIRM", colors.teal },
   ['!'] = { "SHELL", colors.green },
}

local mode = function(n)
   return mode_colors[vim.fn.mode()][n]
end

gls.right[4] = {
   left_arrow = {
      provider = function() end,
      separator = " " .. left_separator,
      separator_highlight = { colors.one_bg2, colors.statusline_bg },
   },
}

gls.right[5] = {
   left_round = {
      provider = function()
         vim.cmd("hi Galaxyleft_round guifg=" .. mode(2))
         return left_separator
      end,
      highlight = { "GalaxyViMode", colors.one_bg2 },
   },
}

gls.right[6] = {
   viMode_icon = {
      provider = function()
         vim.cmd("hi GalaxyviMode_icon guibg=" .. mode(2))
         return statusline_style.vi_mode_icon
      end,
      highlight = { colors.statusline_bg, colors.red },
   },
}

gls.right[7] = {
   ViMode = {
      provider = function()
         vim.cmd("hi GalaxyViMode guifg=" .. mode(2))
         return "  " .. mode(1) .. " "
      end,
      highlight = { "GalaxyViMode", colors.lightbg },
   },
}

gls.right[8] = {
   left_arrow2 = {
      provider = function() end,
      separator = left_separator,
      separator_highlight = { colors.grey, colors.lightbg },
   },
}

gls.right[9] = {
   some_RoundIcon = {
      provider = function()
         return statusline_style.position_icon
      end,
      separator = left_separator,
      separator_highlight = { colors.green, colors.grey },
      highlight = { colors.lightbg, colors.green },
   },
}

gls.right[10] = {
   line_percentage = {
      provider = function()
         local current_line = vim.fn.line "."
         local total_line = vim.fn.line "$"

         if current_line == 1 then
            return "  Top "
         elseif current_line == vim.fn.line "$" then
            return "  Bot "
         end
         local result, _ = math.modf((current_line / total_line) * 100)
         return "  " .. result .. "% "
      end,
      highlight = { colors.green, colors.lightbg },
   },
}
