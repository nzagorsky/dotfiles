local wezterm = require("wezterm")

local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- config.font = wezterm.font("Hack Nerd Font")
config.font = wezterm.font("JetBrains Mono")
config.font_size = 14.0

local custom = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]
custom.background = "#181818"
config.color_schemes = { ["PatchedMocha"] = custom }
config.color_scheme = "PatchedMocha"

config.hide_tab_bar_if_only_one_tab = true
config.window_background_opacity = 1

config.check_for_updates = false
config.animation_fps = 1
config.adjust_window_size_when_changing_font_size = false
config.check_for_updates = false
config.window_decorations = "RESIZE"
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false

config.colors = {
	tab_bar = {
		background = "rgba(0,0,0,0)",
		inactive_tab = {
			bg_color = "rgba(0,0,0,0)",
			fg_color = "#808080",
		},
		new_tab = {
			bg_color = "rgba(0,0,0,0)",
			fg_color = "#1b1032",
		},
	},
}

local keys = {}
local hotkeys = { "f", "b", "h", "j", "k", "l", "p", "t", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0" }

for _, v in pairs(hotkeys) do
	print(v)
	table.insert(keys, {
		key = v,
		mods = "CMD",
		action = wezterm.action.SendKey({ key = v, mods = "META" }),
	})
end

config.keys = keys

return config
