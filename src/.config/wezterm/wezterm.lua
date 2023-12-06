local wezterm = require("wezterm")
local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.color_scheme = "Catppuccin Mocha"
config.hide_tab_bar_if_only_one_tab = true
-- config.font = wezterm.font("Hack Nerd Font")
config.font_size = 13.0
config.window_background_opacity = 0.975
config.animation_fps = 1 -- TODO not sure
config.adjust_window_size_when_changing_font_size = false

return config
