local wezterm = require("wezterm")
local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.color_scheme = "Tangoesque (terminal.sexy)"
config.hide_tab_bar_if_only_one_tab = true
config.font = wezterm.font("Hack Nerd Font")
config.font_size = 14.0
config.window_background_opacity = 0.90
config.animation_fps = 1
config.adjust_window_size_when_changing_font_size = false

local keys = {}

-- Shortcuts for CMD+1,2,3
for i = 0, 9, 1 do
	table.insert(keys, {
		key = tostring(i),
		mods = "CMD",
		action = wezterm.action.SendKey({ key = tostring(i), mods = "META" }),
	})
end

local hotkeys = { "f", "b", "h", "j", "k", "l", "p" }

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
