-- fork from: https://github.com/b0o/wezterm-conf
-- https://github.com/kenchou/wezterm-config/blob/main/wezterm.lua

local wezterm = require("wezterm")
local utils = require("lib.utils")
local wezterm_action = wezterm.action
--local wezterm_nerdfonts = wezterm.nerdfonts
--local wezterm_mux = wezterm.mux

wezterm.log_info("reloading")
local FONTS = {
	"JetBrainsMonoNL Nerd Font Mono",
	"Anonymice Nerd Font", -- v2.3.3, 适配老图标
	"Hack Nerd Font Mono",
	--"IosevkaTerm Nerd Font Mono",
	"NotoMono Nerd Font Mono",
	"Symbols Nerd Font Mono",
	--"Monaco",
	-- MacOS 默认的黑体。或者使用 'Noto Sans CJK SC' 也不错
	"Heiti SC",

	--
	--"PingFang SC",
	--"PingFang TC",
	--"Monaco Nerd Font Mono",
	--"CodeNewRoman Nerd Font Mono",
	--"SaurceCodePro Nerd Font Mono",
	--"Noto Nerd Font Mono",
	--"Hack Nerd Font Mono",
}

local FONT_SIZE = 13.0

local config = {
	colors = {},
}

config.adjust_window_size_when_changing_font_size = false

--config.front_end = "WebGpu"
--config.front_end = "OpenGL"
config.webgpu_power_preference = "HighPerformance"
config.enable_wayland = false

config.inactive_pane_hsb = {
	saturation = 0.9,
	brightness = 0.8,
}

--config.window_decorations = "RESIZE|MACOS_FORCE_DISABLE_SHADOW"
-- config.window_decorations = "INTEGRATED_BUTTONS | RESIZE"
config.window_decorations = "RESIZE"

config.native_macos_fullscreen_mode = true
config.audible_bell = "Disabled"
config.scrollback_lines = 5000
config.set_environment_variables = {
	EDITOR = "nvim",
}

config.freetype_load_flags = "NO_HINTING"
config.use_ime = true -- 如果关闭会导致中文输入法无法使用

-- ui.lua {

config.font = wezterm.font_with_fallback(FONTS)
config.font_size = FONT_SIZE

--config.font_rules = { { intensity = "Bold", font = FONTS }, { intensity = "Normal", font = FONTS } }

config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }

config.enable_scroll_bar = false -- 渲染会有问题
config.min_scroll_bar_height = "2cell"
config.colors.scrollbar_thumb = "#A872FB"

-- Remove all padding
config.window_padding = {
	left = 5,
	right = 5,
	top = 0,
	bottom = 0,
}

config.status_update_interval = 1000

--wezterm.on("gui-startup", function()
--	local tab, pane, window = wezterm_mux.spawn_window({})
--	window:gui_window():maximize()
--end)

config.initial_cols = 140
config.initial_rows = 40
config.window_background_opacity = 0.95
config.macos_window_background_blur = 10

-- CURSOR
config.cursor_blink_ease_in = "Linear"
config.cursor_blink_ease_out = "Linear"
config.hide_mouse_cursor_when_typing = true
config.animation_fps = 60
config.max_fps = 120
-- ui.lua }

-- key-mappings.lua }

-- shell.lua {

config.color_scheme = "Catppuccin Mocha"
config.color_scheme = "Tokyo Night Night"
config.color_scheme = "Tokyo Night Storm"
-- require("tabs").setup(config)

-- Tabs
--local transparent_bg = "rgba(22, 24, 26, " .. opacity .. ")"
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.show_tab_index_in_tab_bar = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true

--wezterm.plugin.require("https://github.com/nekowinston/wezterm-bar").apply_to_config(config)
--local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")
--bar.apply_to_config(config, {
--	enabled_modules = {
--		username = false,
--		clock = false,
--	},
--})

--local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
--tabline.setup({
--	options = {
--		section_separators = "",
--		--component_separators = '',
--		tab_separators = "",
--		--theme = "Tokyo Night Storm",
--		theme = "Poimandres",
--	},
--})
--
--https://github.com/fisenkodv/dotfiles/blob/6a9db6549d31f486c62cc65ac162620774db9c56/config/wezterm/cfg_appearance.lua
wezterm.on("update-right-status", function(window, pane)
	local date = wezterm.strftime("%a %b %-d %I:%M %p")
	window:set_right_status(wezterm.format({
		{ Text = wezterm.nerdfonts.md_calendar_clock .. " " .. date },
		{ Text = " | " },
		{ Text = wezterm.nerdfonts.oct_person .. " " .. wezterm.hostname() },
	}))
end)

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local position = tab.tab_index + 1
	local process_icon = utils.get_process(tab)
	-- ensure that the titles fit in the available space
	local tab_text = wezterm.truncate_right(utils.tab_title(tab), max_width - 2)
	local tab_title = string.format(" ⌘%d %s %s ", position, process_icon, tab_text)
	return {
		{ Text = tab_title },
	}
end)

--config.background = {
--	{
--		source = {
--			File = "/Users/zhaopeng18/.dotfiles/config/wezterm/bg-monterey.png",
--		},
--		hsb = {
--			hue = 1.0,
--			saturation = 1.02,
--			brightness = 0.25,
--		},
--		width = "100%",
--		height = "100%",
--	},
--	{
--		source = {
--			Color = "#282c35",
--		},
--		width = "100%",
--		height = "100%",
--		opacity = 0.55,
--	},
--}

-- from: https://akos.ma/blog/adopting-wezterm/
-- URLs in Markdown files are not handled properly by default
-- Source: https://github.com/wez/wezterm/issues/3803#issuecomment-1608954312
config.hyperlink_rules = {
	-- Matches: a URL in parens: (URL)
	{
		regex = "\\((\\w+://\\S+)\\)",
		format = "$1",
		highlight = 1,
	},
	-- Matches: a URL in brackets: [URL]
	{
		regex = "\\[(\\w+://\\S+)\\]",
		format = "$1",
		highlight = 1,
	},
	-- Matches: a URL in curly braces: {URL}
	{
		regex = "\\{(\\w+://\\S+)\\}",
		format = "$1",
		highlight = 1,
	},
	-- Matches: a URL in angle brackets: <URL>
	{
		regex = "<(\\w+://\\S+)>",
		format = "$1",
		highlight = 1,
	},
	-- Then handle URLs not wrapped in brackets
	{
		-- Before
		--regex = '\\b\\w+://\\S+[)/a-zA-Z0-9-]+',
		--format = '$0',
		-- After
		regex = "[^(]\\b(\\w+://\\S+[)/a-zA-Z0-9-]+)",
		format = "$1",
		highlight = 1,
	},
	-- implicit mailto link
	{
		regex = "\\b\\w+@[\\w-]+(\\.[\\w-]+)+\\b",
		format = "mailto:$0",
	},
}

local act = wezterm.action
config.keys = {
	-- ⌘+d, ⌘+⇧+D split pane -- 水平/垂直分割窗格
	{ key = "d", mods = "CMD", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "D", mods = "CMD|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "RightArrow", mods = "CMD", action = act.ActivatePaneDirection("Right") },
	{ key = "LeftArrow", mods = "CMD", action = act.ActivatePaneDirection("Left") },
	{ key = "UpArrow", mods = "CMD", action = act.ActivatePaneDirection("Up") },
	{ key = "DownArrow", mods = "CMD", action = act.ActivatePaneDirection("Down") },
	{ key = "]", mods = "CMD", action = act.ActivatePaneDirection("Next") },
	{ key = "[", mods = "CMD", action = act.ActivatePaneDirection("Next") },
	-- toggle fullscreen -- 全屏模式
	{ mods = "CMD", key = "Enter", action = wezterm_action.ToggleFullScreen },
	-- ^+w clear pattern in search mode -- 搜索模式快速删除搜索词
	{ key = "Backspace", mods = "ALT", action = act.CopyMode("ClearPattern") },
}
---- key-mappings.lua {
--config.keys = {}
--table.insert(config.keys, { key = "LeftArrow", mods = "SHIFT|SUPER", action = wezterm_action.ActivateTabRelative(-1) })
--table.insert(config.keys, { key = "RightArrow", mods = "SHIFT|SUPER", action = wezterm_action.ActivateTabRelative(1) })
--if IS_MACOS then
--	table.insert(
--		config.keys,
--		{ key = "ApplicationLeftArrow", mods = "CMD|SHIFT", action = wezterm_action.ActivateTabRelative(-1) }
--	)
--	table.insert(
--		config.keys,
--		{ key = "ApplicationRightArrow", mods = "CMD|SHIFT", action = wezterm_action.ActivateTabRelative(1) }
--	)
--	table.insert(config.keys, { mods = "ALT", key = "Enter", action = wezterm_action.DisableDefaultAssignment })
--	table.insert(config.keys, { mods = "CMD", key = "Enter", action = wezterm_action.ToggleFullScreen })
--end

config.mouse_bindings = {
	-- Change the default click behavior so that it only selects
	-- text and doesn't open hyperlinks
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "NONE",
		action = act.CompleteSelection("ClipboardAndPrimarySelection"),
	},

	-- and make CTRL-Click open hyperlinks
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CMD",
		action = act.OpenLinkAtMouseCursor,
	},
	-- NOTE that binding only the 'Up' event can give unexpected behaviors.
	-- Read more below on the gotcha of binding an 'Up' event only.

	-- Disable the 'Down' event of CTRL-Click to avoid weird program behaviors
	{
		event = { Down = { streak = 1, button = "Left" } },
		mods = "CMD",
		action = act.Nop,
	},
}

-- shell.lua }

return config
