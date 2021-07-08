local status_ok, gl = pcall(require, "galaxyline")
if not status_ok then
  return
end

--local gl = require("galaxyline")
local gls = gl.section
local condition = require("galaxyline.condition")
local fn = vim.fn

--gl.short_line_list = {" "}
gl.short_line_list = {"LuaTree", "vista", "dbui",'NvimTree', 'vista', 'dbui', 'packer', 'telescope'}
local colors = require("n-galaxyline/themes/" .. "tomorrow-night")

gls.left[1] = {
  FirstElement = {
    provider = function() return '▋' end,
    highlight = { colors.nord_blue, colors.nord_blue }
  },
}

gls.left[2] = {
    statusIcon = {
        provider = function()
            return "  "
        end,
        highlight = {colors.statusline_bg, colors.nord_blue},
        separator = "  ",
        separator_highlight = {colors.nord_blue, colors.lightbg}
    }
}

gls.left[3] = {
    FileIcon = {
        provider = "FileIcon",
        condition = condition.buffer_not_empty,
        highlight = {colors.white, colors.lightbg}
    }
}

gls.left[4] = {
    FileName = {
        --provider = {"FileName"},
        provider = function()
            return fn.expand("%:F")
        end,
        condition = condition.buffer_not_empty,
        highlight = {colors.white, colors.lightbg},
        separator = " ",
        separator_highlight = {colors.lightbg, colors.lightbg2}
    }
}

gls.left[5] = {
    current_dir = {
        provider = function()
            local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
            return "  " .. dir_name .. " "
        end,
        highlight = {colors.grey_fg2, colors.lightbg2},
        separator = " ",
        separator_highlight = {colors.lightbg2, colors.statusline_bg}
    }
}

local checkwidth = function()
    local squeeze_width = vim.fn.winwidth(0) / 2
    if squeeze_width > 30 then
        return true
    end
    return false
end

gls.left[6] = {
    DiffAdd = {
        provider = "DiffAdd",
        condition = checkwidth,
        icon = "  ",
        highlight = {colors.white, colors.statusline_bg}
    }
}

gls.left[7] = {
    DiffModified = {
        provider = "DiffModified",
        condition = checkwidth,
        icon = "   ",
        highlight = {colors.grey_fg2, colors.statusline_bg}
    }
}

gls.left[8] = {
    DiffRemove = {
        provider = "DiffRemove",
        condition = checkwidth,
        icon = "  ",
        highlight = {colors.grey_fg2, colors.statusline_bg}
    }
}

gls.left[9] = {
    DiagnosticError = {
        provider = "DiagnosticError",
        icon = "  ",
        highlight = {colors.red, colors.statusline_bg}
    }
}

gls.left[10] = {
    DiagnosticWarn = {
        provider = "DiagnosticWarn",
        icon = "  ",
        highlight = {colors.yellow, colors.statusline_bg}
    }
}

gls.right[1] = {
    lsp_status = {
        provider = function()
            local clients = vim.lsp.get_active_clients()
            if next(clients) ~= nil then
                return " " .. "  " .. " LSP "
            else
                return ""
            end
        end,
        highlight = {colors.grey_fg2, colors.statusline_bg}
    }
}

gls.right[2] = {
    GitIcon = {
        provider = function()
            return " "
        end,
        condition = require("galaxyline.condition").check_git_workspace,
        highlight = {colors.grey_fg2, colors.lightbg},
        separator = "",
        separator_highlight = {colors.lightbg, colors.statusline_bg}
    }
}

gls.right[3] = {
    GitBranch = {
        provider = "GitBranch",
        condition = require("galaxyline.condition").check_git_workspace,
        highlight = {colors.grey_fg2, colors.lightbg}
    }
}

gls.right[4] = {
    viMode_icon = {
        provider = function()
            return " "
        end,
        highlight = {colors.statusline_bg, colors.red},
        separator = " ",
        separator_highlight = {colors.red, colors.lightbg}
    }
}

gls.right[5] = {
    ViMode = {
        provider = function()
            local alias = {
                n = "Normal",
                i = "Insert",
                c = "Command",
                V = "Visual",
                [""] = "Visual",
                v = "Visual",
                R = "Replace"
            }
            local current_Mode = alias[vim.fn.mode()]

            if current_Mode == nil then
                return "  Terminal "
            else
                return "  " .. current_Mode .. " "
            end
        end,
        highlight = {colors.red, colors.lightbg}
    }
}

gls.right[6] = {
    some_icon = {
        provider = function()
            return " "
        end,
        separator = "",
        separator_highlight = {colors.green, colors.lightbg},
        highlight = {colors.lightbg, colors.green}
    }
}

gls.right[7] = {
    line_percentage = {
        provider = function()
            local current_line = vim.fn.line(".")
            local total_line = vim.fn.line("$")

            if current_line == 1 then
                return "  Top "
            elseif current_line == vim.fn.line("$") then
                return "  Bot "
            end
            local result, _ = math.modf((current_line / total_line) * 100)
            return "  " .. result .. "% "
        end,
        highlight = {colors.green, colors.lightbg}
    }
}


--local gl = require("galaxyline")
--local gls = gl.section
--local condition = require('galaxyline.condition')
--local fn = vim.fn
--
--gl.short_line_list = {"LuaTree", "vista", "dbui",'NvimTree', 'vista', 'dbui', 'packer'}
--
--local colors = {
--    bg = "#1e222a",
--    line_bg = "#1e222a",
--    fg = "#D8DEE9",
--    fg_green = "#65a380",
--    yellow = "#A3BE8C",
--    cyan = "#22262C",
--    darkblue = "#61afef",
--    green = "#BBE67E",
--    orange = "#FF8800",
--    purple = "#252930",
--    magenta = "#c678dd",
--    blue = "#22262C",
--    red = "#DF8890",
--    lightbg = "#282c34",
--    nord = "#81A1C1",
--    greenYel = "#EBCB8B"
--}
--
--gls.left[1] = {
--    leftRounded = {
--        provider = function()
--            return ""
--        end,
--        highlight = {colors.nord, colors.bg}
--    }
--}
--
--gls.left[2] = {
--    ViMode = {
--        provider = function()
--            return "   "
--        end,
--        highlight = {colors.bg, colors.nord},
--        separator = " ",
--        separator_highlight = {colors.lightbg, colors.lightbg}
--    }
--}
--
--gls.left[3] = {
--    FileIcon = {
--        provider = "FileIcon",
--        condition = condition.buffer_not_empty,
--        highlight = {require("galaxyline.provider_fileinfo").get_file_icon_color, colors.lightbg}
--    }
--}
--
--gls.left[4] = {
--    FileName = {
--        --provider = {"FileName", "FileSize"},
--        provider = function()
--            return fn.expand("%:F")
--        end,
--        condition = condition.buffer_not_empty,
--        highlight = {colors.fg, colors.lightbg}
--    }
--}
--
--gls.left[5] = {
--    teech = {
--        provider = function()
--            return ""
--        end,
--        separator = " ",
--        highlight = {colors.lightbg, colors.line_bg}
--    }
--}
--
--local checkwidth = function()
--    local squeeze_width = vim.fn.winwidth(0) / 2
--    if squeeze_width > 40 then
--        return true
--    end
--    return false
--end
--
--gls.left[6] = {
--    DiffAdd = {
--        provider = "DiffAdd",
--        condition = checkwidth,
--        icon = "   ",
--        highlight = {colors.greenYel, colors.line_bg}
--    }
--}
--
--gls.left[7] = {
--    DiffModified = {
--        provider = "DiffModified",
--        condition = checkwidth,
--        icon = " ",
--        highlight = {colors.orange, colors.line_bg}
--    }
--}
--
--gls.left[8] = {
--    DiffRemove = {
--        provider = "DiffRemove",
--        condition = checkwidth,
--        icon = " ",
--        highlight = {colors.red, colors.line_bg}
--    }
--}
--
--gls.left[9] = {
--    LeftEnd = {
--        provider = function()
--            return " "
--        end,
--        separator = " ",
--        separator_highlight = {colors.line_bg, colors.line_bg},
--        highlight = {colors.line_bg, colors.line_bg}
--    }
--}
--
--gls.left[10] = {
--    DiagnosticError = {
--        provider = "DiagnosticError",
--        icon = "  ",
--        highlight = {colors.red, colors.bg}
--    }
--}
--
--gls.left[11] = {
--    Space = {
--        provider = function()
--            return " "
--        end,
--        highlight = {colors.line_bg, colors.line_bg}
--    }
--}
--
--gls.left[12] = {
--    DiagnosticWarn = {
--        provider = "DiagnosticWarn",
--        icon = "  ",
--        highlight = {colors.blue, colors.bg}
--    }
--}
--
----gls.mid[1] = {
----    ShowLspClient = {
----      provider = 'GetLspClient',
----      condition = function ()
----        local tbl = {['dashboard'] = true,['']=true}
----        if tbl[vim.bo.filetype] then
----          return false
----        end
----        return true
----      end,
----      icon = ' LSP:',
----      highlight = {colors.yellow, colors.bg}
----    }
----}
--
--gls.right[1] = {
--  FileEncode = {
--    provider = 'FileEncode',
--    condition = condition.hide_in_width,
--    separator = ' ',
--    separator_highlight = {'NONE',colors.bg},
--    --highlight = {colors.green,colors.bg,'bold'}
--    highlight = {colors.fg, colors.bg,'bold'}
--  }
--}
--
--gls.right[2] = {
--  FileFormat = {
--    provider = 'FileFormat',
--    condition = condition.hide_in_width,
--    separator = ' ',
--    separator_highlight = {'NONE',colors.bg},
--    --highlight = {colors.green,colors.bg,'bold'}
--    highlight = {colors.fg, colors.bg,'bold'}
--  }
--}
--
--gls.right[4] = {
--    GitIcon = {
--        provider = function()
--            return "   "
--        end,
--        condition = require("galaxyline.provider_vcs").check_git_workspace,
--
--        separator = ' ',
--        separator_highlight = {'NONE',colors.bg},
--        highlight = {colors.green, colors.line_bg}
--    }
--}
--
--gls.right[5] = {
--    GitBranch = {
--        provider = "GitBranch",
--        condition = require("galaxyline.provider_vcs").check_git_workspace,
--        highlight = {colors.green, colors.line_bg}
--    }
--}
--
--gls.right[6] = {
--    TreesitterIcon = {
--        provider = function()
--            if next(vim.treesitter.highlighter.active) ~= nil then return ' ' end
--            return ''
--        end,
--        separator = ' ',
--        separator_highlight = {'NONE', colors.bg},
--        highlight = {colors.green, colors.bg}
--    }
--}
--
--gls.right[7] = {
--    right_LeftRounded = {
--        provider = function()
--            return ""
--        end,
--        separator = " ",
--        separator_highlight = {colors.bg, colors.bg},
--        highlight = {colors.red, colors.bg}
--    }
--}
--
--gls.right[8] = {
--    SiMode = {
--        provider = function()
--            local alias = {
--                n = "NORMAL",
--                i = "INSERT",
--                c = "COMMAND",
--                V = "VISUAL",
--                [""] = "VISUAL",
--                v = "VISUAL",
--                R = "REPLACE"
--            }
--            return alias[vim.fn.mode()]
--        end,
--        highlight = {colors.bg, colors.red}
--    }
--}
--
--gls.right[9] = {
--    PerCent = {
--        provider = "LinePercent",
--        separator = " ",
--        separator_highlight = {colors.red, colors.red},
--        highlight = {colors.bg, colors.fg}
--    }
--}
--
--gls.right[10] = {
--    rightRounded = {
--        provider = function()
--            return ""
--        end,
--        highlight = {colors.fg, colors.bg}
--    }
--}
--
--gls.short_line_left[1] = {
--  BufferType = {
--    provider = 'FileTypeName',
--    separator = ' ',
--    separator_highlight = {'NONE',colors.bg},
--    highlight = {colors.blue,colors.bg,'bold'}
--  }
--}
--
--gls.short_line_left[2] = {
--  SFileName = {
--    --provider =  'SFileName',
--   provider = function()
--        local fileinfo = require("galaxyline.provider_fileinfo")
--        local fname = fileinfo.get_current_file_name()
--        for _, v in ipairs(gl.short_line_list) do
--          if v == vim.bo.filetype then
--            return ""
--          end
--        end
--        return fname
--      end,
--    condition = condition.buffer_not_empty,
--    highlight = {colors.fg,colors.bg,'bold'}
--  }
--}
--
--gls.short_line_right[1] = {
--  BufferIcon = {
--    provider= 'BufferIcon',
--    highlight = {colors.fg,colors.bg}
--  }
--}
--
----local gl = require('galaxyline')
----local colors = require('galaxyline.theme').default
----local condition = require('galaxyline.condition')
----local gls = gl.section
----
----gl.short_line_list = {'NvimTree','vista','dbui','packer'}
----
----gls.left[1] = {
----  RainbowRed = {
----    provider = function() return '▊ ' end,
----    highlight = {colors.blue,colors.bg}
----  },
----}
----gls.left[2] = {
----  ViMode = {
----    provider = function()
----      -- auto change color according the vim mode
----      local mode_color = {n = colors.red, i = colors.green,v=colors.blue,
----                          [''] = colors.blue,V=colors.blue,
----                          c = colors.magenta,no = colors.red,s = colors.orange,
----                          S=colors.orange,[''] = colors.orange,
----                          ic = colors.yellow,R = colors.violet,Rv = colors.violet,
----                          cv = colors.red,ce=colors.red, r = colors.cyan,
----                          rm = colors.cyan, ['r?'] = colors.cyan,
----                          ['!']  = colors.red,t = colors.red}
----      vim.api.nvim_command('hi GalaxyViMode guifg='..mode_color[vim.fn.mode()])
----      return '  '
----    end,
----    highlight = {colors.red,colors.bg,'bold'},
----  },
----}
----gls.left[3] = {
----  FileSize = {
----    provider = 'FileSize',
----    condition = condition.buffer_not_empty,
----    highlight = {colors.fg,colors.bg}
----  }
----}
----gls.left[4] ={
----  FileIcon = {
----    provider = 'FileIcon',
----    condition = condition.buffer_not_empty,
----    highlight = {require('galaxyline.provider_fileinfo').get_file_icon_color,colors.bg},
----  },
----}
----
----gls.left[5] = {
----  FileName = {
----    provider = 'FileName',
----    condition = condition.buffer_not_empty,
----    highlight = {colors.fg,colors.bg,'bold'}
----  }
----}
----
----gls.left[6] = {
----  LineInfo = {
----    provider = 'LineColumn',
----    separator = ' ',
----    separator_highlight = {'NONE',colors.bg},
----    highlight = {colors.fg,colors.bg},
----  },
----}
----
----gls.left[7] = {
----  PerCent = {
----    provider = 'LinePercent',
----    separator = ' ',
----    separator_highlight = {'NONE',colors.bg},
----    highlight = {colors.fg,colors.bg,'bold'},
----  }
----}
----
----gls.left[8] = {
----  DiagnosticError = {
----    provider = 'DiagnosticError',
----    icon = '  ',
----    highlight = {colors.red,colors.bg}
----  }
----}
----gls.left[9] = {
----  DiagnosticWarn = {
----    provider = 'DiagnosticWarn',
----    icon = '  ',
----    highlight = {colors.yellow,colors.bg},
----  }
----}
----
----gls.left[10] = {
----  DiagnosticHint = {
----    provider = 'DiagnosticHint',
----    icon = '  ',
----    highlight = {colors.cyan,colors.bg},
----  }
----}
----
----gls.left[11] = {
----  DiagnosticInfo = {
----    provider = 'DiagnosticInfo',
----    icon = '  ',
----    highlight = {colors.blue,colors.bg},
----  }
----}
----
----gls.mid[1] = {
----  ShowLspClient = {
----    provider = 'GetLspClient',
----    condition = function ()
----      local tbl = {['dashboard'] = true,['']=true}
----      if tbl[vim.bo.filetype] then
----        return false
----      end
----      return true
----    end,
----    icon = ' LSP:',
----    highlight = {colors.yellow,colors.bg,'bold'}
----  }
----}
----
----gls.right[1] = {
----  FileEncode = {
----    provider = 'FileEncode',
----    condition = condition.hide_in_width,
----    separator = ' ',
----    separator_highlight = {'NONE',colors.bg},
----    highlight = {colors.green,colors.bg,'bold'}
----  }
----}
----
----gls.right[2] = {
----  FileFormat = {
----    provider = 'FileFormat',
----    condition = condition.hide_in_width,
----    separator = ' ',
----    separator_highlight = {'NONE',colors.bg},
----    highlight = {colors.green,colors.bg,'bold'}
----  }
----}
----
----gls.right[3] = {
----  GitIcon = {
----    provider = function() return '  ' end,
----    condition = condition.check_git_workspace,
----    separator = ' ',
----    separator_highlight = {'NONE',colors.bg},
----    highlight = {colors.violet,colors.bg,'bold'},
----  }
----}
----
----gls.right[4] = {
----  GitBranch = {
----    provider = 'GitBranch',
----    condition = condition.check_git_workspace,
----    highlight = {colors.violet,colors.bg,'bold'},
----  }
----}
----
----gls.right[5] = {
----  DiffAdd = {
----    provider = 'DiffAdd',
----    condition = condition.hide_in_width,
----    icon = '  ',
----    highlight = {colors.green,colors.bg},
----  }
----}
----gls.right[6] = {
----  DiffModified = {
----    provider = 'DiffModified',
----    condition = condition.hide_in_width,
----    icon = ' 柳',
----    highlight = {colors.orange,colors.bg},
----  }
----}
----gls.right[7] = {
----  DiffRemove = {
----    provider = 'DiffRemove',
----    condition = condition.hide_in_width,
----    icon = '  ',
----    highlight = {colors.red,colors.bg},
----  }
----}
----
----gls.right[8] = {
----  RainbowBlue = {
----    provider = function() return ' ▊' end,
----    highlight = {colors.blue,colors.bg}
----  },
----}
----
----gls.short_line_left[1] = {
----  BufferType = {
----    provider = 'FileTypeName',
----    separator = ' ',
----    separator_highlight = {'NONE',colors.bg},
----    highlight = {colors.blue,colors.bg,'bold'}
----  }
----}
----
----gls.short_line_left[2] = {
----  SFileName = {
----    provider =  'SFileName',
----    condition = condition.buffer_not_empty,
----    highlight = {colors.fg,colors.bg,'bold'}
----  }
----}
----
----gls.short_line_right[1] = {
----  BufferIcon = {
----    provider= 'BufferIcon',
----    highlight = {colors.fg,colors.bg}
----  }
----}
-- 
