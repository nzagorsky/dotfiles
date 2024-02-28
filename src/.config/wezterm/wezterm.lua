local wezterm = require("wezterm")

local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.color_scheme = "catppuccin-mocha"
config.hide_tab_bar_if_only_one_tab = true
-- config.font = wezterm.font("JetBrains Mono")
config.font_size = 15.0
config.check_for_updates = false
config.show_update_window = false
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
