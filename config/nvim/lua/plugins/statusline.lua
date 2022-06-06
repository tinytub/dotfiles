--local colors = require("colors").get()
local lsp = require("feline.providers.lsp")
local lsp_severity = vim.diagnostic.severity
--nvim_gps.setup({
--	separator = "  ",
--})

local fn = vim.fn
local function get_color(group, attr)
	return fn.synIDattr(fn.synIDtrans(fn.hlID(group)), attr)
end

local shortline = true

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
		vi_mode_icon = "  ",
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

local icons = {
	mode_icon = "  ",
	position_icon = " ",
	empty_file = " Empty ",
	dir = " ",
	clock = " ",
}

--local user_statusline_style = require("core.utils").load_config().ui.plugin.statusline.style
--local statusline_style = icon_styles[user_statusline_style]
--local statusline_style = icon_styles["round"]
local statusline_style = icon_styles["default"]

-- Initialize the components table
local components = {
	active = {},
}

local diff = {
	add = {
		provider = "git_diff_added",
		hl = "Feline_diffIcons",
		icon = " ",
	},

	change = {
		provider = "git_diff_changed",
		hl = "Feline_diffIcons",
		icon = "  ",
	},

	remove = {
		provider = "git_diff_removed",
		hl = "Feline_diffIcons",
		icon = "  ",
	},
}

local git_branch = {
	provider = "git_branch",
	enabled = shortline or function(winid)
		return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 70
	end,
	hl = "Feline_diffIcons",
	icon = "  ",
}

local file_info = {
	left_sep = {
		str = statusline_style.left,
		hl = "Feline_file_info_sep",
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
			icon = icon .. " "
		end

		return icon
	end,

	hl = "Feline_file_info",

	-- file name
	right_sep = {
		str = function()
			local filename = fn.expand("%:t")
			return " " .. fn.fnamemodify(filename, ":r") .. " "
		end,

		hl = function()
			return {
				fg = get_color("Feline_file_info", "bg#"),
				bg = get_color("Feline_file_info", "fg#"),
			}
		end,
	},
}

local diagnostic = {
	error = {
		provider = "diagnostic_errors",
		enabled = function()
			return lsp.diagnostics_exist(lsp_severity.ERROR)
		end,

		hl = "Feline_lspError",
		icon = "  ",
	},

	warning = {
		provider = "diagnostic_warnings",
		enabled = function()
			return lsp.diagnostics_exist(lsp_severity.WARN)
		end,
		hl = "Feline_lspWarning",
		icon = "  ",
	},

	hint = {
		provider = "diagnostic_hints",
		enabled = function()
			return lsp.diagnostics_exist(lsp_severity.HINT)
		end,
		hl = "Feline_LspHints",
		icon = "  ",
	},

	info = {
		provider = "diagnostic_info",
		enabled = function()
			return lsp.diagnostics_exist(lsp_severity.INFO)
		end,
		hl = "Feline_LspInfo",
		icon = "  ",
	},
}

local lsp_status = {
	provider = function()
		if next(vim.lsp.buf_get_clients()) ~= nil then
			local lsp_name = vim.lsp.get_active_clients()[1].name

			return "   LSP ~ " .. lsp_name .. " "
		else
			return ""
		end
	end,

	hl = "Feline_LspIcon",
}

local lsp_progress = {
	provider = function()
		local Lsp = vim.lsp.util.get_progress_messages()[1]

		if Lsp then
			local msg = Lsp.message or ""
			local percentage = Lsp.percentage or 0
			local title = Lsp.title or ""
			local spinners = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }

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
	hl = "Feline_LspProgress",
}

-- MODES
local mode_hlgroups = {
	["n"] = { "NORMAL", "Feline_NormalMode" },
	["no"] = { "N-PENDING", "Feline_NormalMode" },
	["i"] = { "INSERT", "Feline_InsertMode" },
	["ic"] = { "INSERT", "Feline_InsertMode" },
	["t"] = { "TERMINAL", "Feline_TerminalMode" },
	["v"] = { "VISUAL", "Feline_VisualMode" },
	["V"] = { "V-LINE", "Feline_VisualMode" },
	[""] = { "V-BLOCK", "Feline_VisualMode" },
	["R"] = { "REPLACE", "Feline_ReplaceMode" },
	["Rv"] = { "V-REPLACE", "Feline_ReplaceMode" },
	["s"] = { "SELECT", "Feline_SelectMode" },
	["S"] = { "S-LINE", "Feline_SelectMode" },
	[""] = { "S-BLOCK", "Feline_SelectMode" },
	["c"] = { "COMMAND", "Feline_CommandMode" },
	["cv"] = { "COMMAND", "Feline_CommandMode" },
	["ce"] = { "COMMAND", "Feline_CommandMode" },
	["r"] = { "PROMPT", "Feline_ConfirmMode" },
	["rm"] = { "MORE", "Feline_ConfirmMode" },
	["r?"] = { "CONFIRM", "Feline_ConfirmMode" },
	["!"] = { "SHELL", "Feline_TerminalMode" },
}

local vi_mode = {
	provider = function()
		return " " .. mode_hlgroups[fn.mode()][1] .. " "
	end,

	hl = function()
		return mode_hlgroups[fn.mode()][2]
	end,

	right_sep = {
		str = statusline_style.right,
		hl = function()
			return {
				fg = get_color("Feline_EmptySpace", "bg#"),
				bg = get_color("Feline_nvim_gps", "bg#"),
			}
		end,
	},
}

local cwd = {
	-- icon
	left_sep = {
		str = " " .. icons.dir,
		hl = "FelineCwd",
	},

	-- dirname
	provider = function()
		local dir_name = fn.fnamemodify(fn.getcwd(), ":t")
		return " " .. dir_name .. " "
	end,

	hl = "FelineCwd",
}

local mode_icon = {
	provider = icons.mode_icon,

	hl = function()
		return {
			fg = get_color("Feline", "bg#"),
			bg = get_color(mode_hlgroups[fn.mode()][2], "fg#"),
		}
	end,

	right_sep = {
		str = statusline_style.right,
		hl = function()
			return {
				fg = get_color(mode_hlgroups[fn.mode()][2], "fg#"),
				bg = get_color("Feline_EmptySpace", "fg#"),
			}
		end,
	},
}

local separator_left = {
	provider = statusline_style.right,
	hl = "Feline_EmptySpace",
}

local separator_right = {
	provider = statusline_style.left,
	--enabled = shortline or function(winid)
	--	return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 90
	--end,
	hl = "Feline_EmptySpace",
}

local separator_right_position = {
	provider = statusline_style.left,
	hl = "Feline_PositionSeparator",
}

local separator_right_file = {
	provider = statusline_style.left,
	hl = "Feline_EmptySpace_git",
	--hl = function()
	--	return {
	--		fg = get_color("Feline_EmptySpace", "fg#"),
	--		bg = get_color("Feline_nvim_gps", "bg#"),
	--	}
	--end,
}

local position_icon = {
	provider = statusline_style.position_icon,
	hl = "Feline_PositionIcon",
}
local current_line = {
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

	enabled = shortline or function(winid)
		return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 90
	end,
	hl = "Feline_CurrentLine",
}

local function add_table(a, b)
	table.insert(a, b)
end

-- components are divided in 3 sections
local left = {}
local middle = {}
local right = {}

-- left
add_table(left, mode_icon)
add_table(left, separator_left)
add_table(left, vi_mode)
add_table(left, cwd)

-- lsp
add_table(left, lsp_status)
add_table(left, diagnostic.error)
add_table(left, diagnostic.warning)
add_table(left, diagnostic.hint)
add_table(left, diagnostic.info)

--add_table(middle, lsp_progress)
--add_table(middle, nvim_gps)

-- git diffs
add_table(right, diff.add)
add_table(right, diff.change)
add_table(right, diff.remove)
add_table(right, git_branch)

add_table(right, separator_right_file)
add_table(right, file_info)

--add_table(right, separator_right)
add_table(right, separator_right_position)
add_table(right, position_icon)
add_table(right, current_line)

components.active[1] = left
components.active[2] = middle
components.active[3] = right
require("feline").setup({
	theme = {
		fg = get_color("Feline", "fg#"),
		bg = get_color("Feline", "bg#"),
	},
	components = components,
})

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
			local gps_loaded, gps = pcall(require, "nvim-gps")
			if not gps_loaded then
				return
			end

			local location = gps.get_location()
			return location == "" and "" or "  " .. location
		end,
		enabled = function()
			local gps_loaded, gps = pcall(require, "nvim-gps")

			if not gps_loaded then
				return false
			end
			return gps.is_available()
		end,
		--    hl = { fg = '#eeeeee', bg = '#1c1c1c' },
		hl = "Feline_nvim_gps",
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
		},
	},
})
