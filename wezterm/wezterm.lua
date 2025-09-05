local wezterm = require("wezterm")

wezterm.on("format-window-title", function()
  -- return "  wezterm"
  return "λ wezterm"
end)

local config = wezterm.config_builder()

config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 18.0
config.window_close_confirmation = 'NeverPrompt'

config.window_background_opacity = 0.9
config.text_background_opacity = 1.0
config.macos_window_background_blur = 20

config.colors = {
foreground = "#D9E0EE",
    background = "#000911",
    cursor_bg = "#D9E0EE",
    cursor_fg = "#000911",
    cursor_border = "#D9E0EE",

    ansi = {
      "#404038", -- black
      "#F28FAD", -- red
      "#ABE9B3", -- green
      "#FAE3B0", -- yellow
      "#96CDFB", -- blue
      "#DDB6F2", -- magenta
      "#89DCEB", -- cyan
      "#CDD6F4", -- white
    },

    brights = {
      "#575268", -- bright black
      "#F28FAD", -- bright red
      "#ABE9B3", -- bright green
      "#FAE3B0", -- bright yellow
      "#96CDFB", -- bright blue
      "#DDB6F2", -- bright magenta
      "#89DCEB", -- bright cyan
      "#FFFFFF", -- bright white
    },


}



config.enable_tab_bar = false
-- config.window_decorations = "RESIZE"

-- Fullscreen toggle with Super+Enters
config.keys = {
	{
		key = "Enter",
		mods = "CMD",
		action = wezterm.action.ToggleFullScreen,
	},
}

config.exit_behavior = "Close"

-- Use the following to launch tmux on startup
-- /bin/zsh -c "tmux attach"
config.default_prog = {"/opt/homebrew/bin/tmux", "attach"}



return config
