local present, feline = pcall(require, "feline")

if not present then
    return
end

local fn = vim.fn

local options = {
    colors = require('base46').get_colors('base_30'),
    lsp = require "feline.providers.lsp",
    lsp_severity = vim.diagnostic.severity,
}

local icons = {
    mode_icon = "  ",
    position_icon = "  ",
    empty_file = "  Empty ",
    dir = " ",
    clock = " ",
}

-- https://github.com/FelixKratz/dotfiles/blob/master/.config/nvim/lua/custom/plugins/feline.lua
options.icon_styles = {
    default = {
        left = "",
        right = " ",
        main_icon = " ",
        vi_mode_icon = " ",
        position_icon = " ",
    },
    arrow = {
        left = "",
        right = "",
        main_icon = " ",
        vi_mode_icon = "",
        position_icon = " ",
    },

    block = {
        left = " ",
        right = " ",
        main_icon = " ",
        vi_mode_icon = "",
        position_icon = "  ",
    },

    round = {
        left = "",
        right = "",
        main_icon = " ",
        vi_mode_icon = " ",
        position_icon = " ",
    },

    slant = {
        left = " ",
        right = " ",
        main_icon = " ",
        vi_mode_icon = " ",
        position_icon = " ",
    },
}

options.mode_colors = {
    ["n"] = { "NORMAL", options.colors.nord_blue },
    ["no"] = { "N-PENDING", options.colors.red },
    ["i"] = { "INSERT", options.colors.dark_purple },
    ["ic"] = { "INSERT", options.colors.dark_purple },
    ["t"] = { "TERMINAL", options.colors.green },
    ["v"] = { "VISUAL", options.colors.cyan },
    ["V"] = { "V-LINE", options.colors.cyan },
    [""] = { "V-BLOCK", options.colors.cyan },
    ["R"] = { "REPLACE", options.colors.orange },
    ["Rv"] = { "V-REPLACE", options.colors.orange },
    ["s"] = { "SELECT", options.colors.nord_blue },
    ["S"] = { "S-LINE", options.colors.nord_blue },
    [""] = { "S-BLOCK", options.colors.nord_blue },
    ["c"] = { "COMMAND", options.colors.pink },
    ["cv"] = { "COMMAND", options.colors.pink },
    ["ce"] = { "COMMAND", options.colors.pink },
    ["r"] = { "PROMPT", options.colors.teal },
    ["rm"] = { "MORE", options.colors.teal },
    ["r?"] = { "CONFIRM", options.colors.teal },
    ["!"] = { "SHELL", options.colors.green },
}

options.separator_style = options.icon_styles["default"]

options.main_icon = {
    provider = function()
        return "  " .. options.mode_colors[vim.fn.mode()][1] .. " "
    end,

    --hl = {
    --    fg = options.colors.statusline_bg,
    --    bg = options.colors.nord_blue,
    --},

    hl = function()
        return {
            fg = options.colors.black,
            bg = options.mode_colors[fn.mode()][2],
        }
    end,

    right_sep = {
        str = options.separator_style.right,
        hl = function()
            return {
                fg = options.mode_colors[fn.mode()][2],
                bg = options.colors.grey,
            }
        end,

        --hl = {
        --    fg = options.colors.nord_blue,
        --    bg = options.colors.grey,
        --},
    },
}

options.separator_left = {
    provider = options.separator_style.right,
    hl = {
        fg = options.colors.grey,
        bg = options.colors.lightbg,
    }
}

options.dir_name = {
    provider = function()
        local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
        local filename = vim.fn.expand "%:t"
        local extension = vim.fn.expand "%:e"
        local icon = require("nvim-web-devicons").get_icon(filename, extension)
        if icon == nil then
            icon = " "
        end
        return " " .. icon .. " " .. dir_name .. " "
    end,

    hl = {
        fg = options.colors.white,
        bg = options.colors.lightbg,
    },

    right_sep = {
        str = options.separator_style.right,
        hl = { fg = options.colors.lightbg, bg = options.colors.lightbg2 },
    },
}

options.left_file_info = {
    left_sep = {
        --str = statusline_style.left,
        str = "",
        hl = {
            bg = options.colors.lightbg,
            fg = options.colors.white,
        },

    },

    -- file icon
    provider = function()
        local filename = fn.expand("%:t")
        local extension = fn.expand("%:e")

        if filename == "" then
            return icons.empty_file
        end

        local icon = require("nvim-web-devicons").get_icon(filename, extension)

        if icon == nil then
            icon = " "
        else
            icon = "" .. icon .. " "
        end

        return icon
    end,

    hl = {
        bg = options.colors.lightbg,
        fg = options.colors.white,
    },

    -- file name
    right_sep = {
        str = function()
            local filename = fn.expand("%:t")
            return "" .. fn.fnamemodify(filename, ":r") .. " "
        end,

        hl = {
            bg = options.colors.lightbg,
            fg = options.colors.white,
        },
    },
}

options.separator_left2 = {
    provider = options.separator_style.right,
    hl = {
        fg = options.colors.lightbg,
        bg = options.colors.statusline_bg,
    }
}

options.diff = {
    add = {
        provider = "git_diff_added",
        hl = {
            fg = options.colors.grey_fg2,
            bg = options.colors.statusline_bg,
        },
        icon = "  ",
    },

    change = {
        provider = "git_diff_changed",
        hl = {
            fg = options.colors.grey_fg2,
            bg = options.colors.statusline_bg,
        },
        icon = "  ",
    },

    remove = {
        provider = "git_diff_removed",
        hl = {
            fg = options.colors.grey_fg2,
            bg = options.colors.statusline_bg,
        },
        icon = "  ",
    },
}

options.git_branch = {
    provider = "git_branch",
    hl = {
        fg = options.colors.grey_fg2,
        bg = options.colors.statusline_bg,
    },
    icon = "  ",
}

options.diagnostic = {
    error = {
        provider = "diagnostic_errors",
        enabled = function()
            return options.lsp.diagnostics_exist(options.lsp_severity.ERROR)
        end,

        hl = { fg = options.colors.red },
        icon = "  ",
    },

    warning = {
        provider = "diagnostic_warnings",
        enabled = function()
            return options.lsp.diagnostics_exist(options.lsp_severity.WARN)
        end,
        hl = { fg = options.colors.yellow },
        icon = "  ",
    },

    hint = {
        provider = "diagnostic_hints",
        enabled = function()
            return options.lsp.diagnostics_exist(options.lsp_severity.HINT)
        end,
        hl = { fg = options.colors.grey_fg2 },
        icon = "  ",
    },

    info = {
        provider = "diagnostic_info",
        enabled = function()
            return options.lsp.diagnostics_exist(options.lsp_severity.INFO)
        end,
        hl = { fg = options.colors.green },
        icon = "  ",
    },
}

options.lsp_progress = {
    provider = function()
        local Lsp = vim.lsp.util.get_progress_messages()[1]

        if Lsp then
            local msg = Lsp.message or ""
            local percentage = Lsp.percentage or 0
            local title = Lsp.title or ""
            local spinners = {
                "",
                "",
                "",
            }

            local success_icon = {
                "",
                "",
                "",
            }

            local ms = vim.loop.hrtime() / 1000000
            local frame = math.floor(ms / 120) % #spinners

            if percentage >= 70 then
                return string.format(" %%<%s %s %s (%s%%%%) ", success_icon[frame + 1], title, msg, percentage)
            end

            return string.format(" %%<%s %s %s (%s%%%%) ", spinners[frame + 1], title, msg, percentage)
        end

        return ""
    end,
    hl = { fg = options.colors.green },
}
options.lsp_status = {
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
            return ("   LSP ~ " .. name .. " ") or "   LSP "
            --return content and ("%#St_LspStatus#" .. content) or ""
            --local lsp_name = vim.lsp.get_active_clients()[1].name

            --return "   LSP ~ " .. lsp_name .. " "
        else
            return ""
        end
    end,

    hl = {
        fg = options.colors.teal,
        bg = options.colors.statusline_bg,
    }
}
options.lsp_icon = {
    provider = function()
        if next(vim.lsp.buf_get_clients()) ~= nil then
            return "    LSP "
        else
            return " "
        end
    end,
    hl = { fg = options.colors.grey_fg2, bg = options.colors.statusline_bg },
}
options.cwd = {
    -- icon
    left_sep = {
        str = "" .. icons.dir,
        hl = {
            fg = options.colors.one_bg,
            bg = options.colors.red,
        }
    },

    -- dirname
    provider = function()
        local dir_name = fn.fnamemodify(fn.getcwd(), ":t")
        return " " .. dir_name .. " "
    end,

    hl = {
        fg = options.colors.white,
        bg = options.colors.lightbg,
    },
}
options.separator_right_position = {
    provider = options.separator_style.left,
    hl = {
        fg = options.colors.green,
        bg = options.colors.grey,
    }
}

options.separator_right_position2 = {
    provider = options.separator_style.left,
    hl = {
        fg = options.colors.red,
        bg = options.colors.statusline_bg,
    }
}
options.position_icon = {
    provider = options.separator_style.position_icon,
    hl = {
        fg = options.colors.black,
        bg = options.colors.green,
    }
}
options.current_line = {
    provider = function()
        local current_line = vim.fn.line(".")
        local total_line = vim.fn.line("$")

        if current_line == 1 then
            return " Top "
        elseif current_line == vim.fn.line("$") then
            return " Bot "
        end
        local result, _ = math.modf((current_line / total_line) * 100)
        return " " .. result .. "%% "
    end,
    --enabled = shortline or function(winid)
    --    return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 90
    --end,
    hl = {
        fg = options.colors.green,
        bg = options.colors.lightbg,
    },
}

local function add_table(tbl, inject)
    if inject then
        table.insert(tbl, inject)
    end
end

-- components are divided in 3 sections
options.left = {}
options.middle = {}
options.right = {}

-- left
add_table(options.left, options.main_icon)
add_table(options.left, options.separator_left)
add_table(options.left, options.left_file_info)
add_table(options.left, options.separator_left2)
add_table(options.left, options.git_branch)
add_table(options.left, options.diff.add)
add_table(options.left, options.diff.change)
add_table(options.left, options.diff.remove)

--add_table(options.middle, options.lsp_progress)

-- right
add_table(options.right, options.diagnostic.error)
add_table(options.right, options.diagnostic.warning)
add_table(options.right, options.diagnostic.hint)
add_table(options.right, options.diagnostic.info)
add_table(options.right, options.lsp_status)

add_table(options.right, options.separator_right_position2)
add_table(options.right, options.cwd)
add_table(options.right, options.separator_right_position)
add_table(options.right, options.position_icon)
add_table(options.right, options.current_line)

--add_table(options.right, options.position_icon)
--add_table(options.right, options.current_line)

-- Initialize the components table
options.components = { active = {} }

options.components.active[1] = options.left
options.components.active[2] = options.middle
options.components.active[3] = options.right

options.theme = {
    bg = options.colors.statusline_bg,
    fg = options.colors.fg,
}

feline.setup {
    theme = options.theme,
    components = options.components,
}

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
            fg = options.colors.purple,
            bg = options.colors.statusline_bg,
        },
    },
}
local winbar = {
    {
        --        winbar_components.file,
        winbar_components.gps,
    },
}
feline.winbar.setup({
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
