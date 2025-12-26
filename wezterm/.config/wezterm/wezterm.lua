local wezterm = require("wezterm")
return {
	-- color_scheme = 'termnial.sexy',
	color_scheme = "Catppuccin Mocha",
	enable_tab_bar = false,
	font_size = 14.0,
	font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Regular", italic = false }),
	max_fps = 120,
	window_close_confirmation = "NeverPrompt",
	-- macos_window_background_blur = 40,
	macos_window_background_blur = 30,
	-- window_background_image_hsb = {
	-- 	brightness = 0.01,
	-- 	hue = 1.0,
	-- 	saturation = 0.5,
	-- },
	-- window_background_opacity = 0.92,
	window_background_opacity = 1.0,
	-- window_background_opacity = 0.78,
	-- window_background_opacity = 0.20,
	window_decorations = "RESIZE",
  keys = {
    {key="Enter", mods="SHIFT", action=wezterm.action{SendString="\x1b\r"}},
  },
	mouse_bindings = {
		-- Ctrl-click will open the link under the mouse cursor
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "CTRL",
			action = wezterm.action.OpenLinkAtMouseCursor,
		},
	},
}
