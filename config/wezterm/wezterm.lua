-- fork from: https://github.com/b0o/wezterm-conf
-- https://github.com/kenchou/wezterm-config/blob/main/wezterm.lua

local wezterm = require("wezterm")
local wezterm_action = wezterm.action
--local wezterm_nerdfonts = wezterm.nerdfonts
--local wezterm_mux = wezterm.mux

wezterm.log_info("reloading")

local function _execute(cmd)
	local f = assert(io.popen(cmd, "r"))
	local s = assert(f:read("*a"))
	f:close()
	s = string.gsub(s, "^%s+", "")
	s = string.gsub(s, "%s+$", "")
	s = string.gsub(s, "[\n\r]+", "")
	return s
end

local function _extract_path(p)
	local dirname, filename = p:match("^(.*/)([^/]-)$")
	return dirname, filename
end

--- @param s string
--- @param t string
--- @param rstart integer?  by default rstart=#s
--- @return integer?
local function string_rfind(s, t, rstart)
	rstart = rstart or #s
	for i = rstart, 1, -1 do
		local match = true
		for j = 1, #t do
			if i + j - 1 > #s then
				match = false
				break
			end
			local a = string.byte(s, i + j - 1)
			local b = string.byte(t, j)
			if a ~= b then
				match = false
				break
			end
		end
		if match then
			return i
		end
	end
	return nil
end

local IS_WINDOWS = package.config:sub(1, 1) == "\\"
local IS_LINUX = false
local IS_MACOS = false
if not IS_WINDOWS then
	local os_name = _execute("uname")
	IS_LINUX = os_name ~= "Darwin"
	IS_MACOS = os_name == "Darwin"
end
local SHELL = nil
if IS_WINDOWS then
	SHELL = "pwsh"
end
if IS_MACOS or IS_LINUX then
	local shellname = _execute("echo $SHELL")
	local _, shortname = _extract_path(shellname)
	SHELL = shortname
end

-- Ran into an issue in nightly build where Alt-` stopped working.
-- It should be fixed now, but if it ever doesn't work, then
-- `use_dead_keys = true` should fix it.

local FONTS = {
	"JetBrainsMonoNL Nerd Font Mono",
	"Hack Nerd Font Mono",
	--"IosevkaTerm Nerd Font Mono",
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
local FONT_SIZE = 12.0
if not IS_MACOS then
	FONT_SIZE = 11.0
end

local config = {
	colors = {},
}

if IS_WINDOWS or IS_MACOS then
	--config.front_end = "WebGpu"
	--config.front_end = "OpenGL"
	config.webgpu_power_preference = "HighPerformance"
	config.enable_wayland = false
end

config.inactive_pane_hsb = {
	saturation = 0.8,
	brightness = 0.6,
}

--config.window_decorations = "RESIZE|MACOS_FORCE_DISABLE_SHADOW"
config.window_decorations = "INTEGRATED_BUTTONS | RESIZE"

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
	left = 0,
	right = 0,
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
config.window_background_opacity = 0.92
config.macos_window_background_blur = 6

-- CURSOR
config.cursor_blink_ease_in = "Linear"
config.cursor_blink_ease_out = "Linear"
config.hide_mouse_cursor_when_typing = true
config.animation_fps = 60
-- ui.lua }

-- key-mappings.lua }

-- shell.lua {
-- config.default_prog = { "/usr/bin/zsh" }
if IS_WINDOWS then
	config.default_prog = { "pwsh.exe" }
end

config.color_scheme = "Catppuccin Mocha"
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

local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
tabline.setup({
	options = {
		section_separators = "",
		--component_separators = '',
		tab_separators = "",
		--theme = "Tokyo Night Storm",
		theme = "Poimandres",
	},
})

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
