local wezterm = require("wezterm")

wezterm.on("format-window-title", function()
  -- return "  wezterm"
  return "λ - hack!"
end)

local c = wezterm.config_builder()

-- c.enable_wayland = false -- If you want window decorations
-- c.front_end = "OpenGL"  -- Needed for Arch VM on Apple Silicon

c.font = wezterm.font("JetBrainsMono Nerd Font")
c.font_size = 18.0
c.window_close_confirmation = 'NeverPrompt'

c.window_background_opacity = 0.9
c.text_background_opacity = 1.0
c.macos_window_background_blur = 20

c.enable_tab_bar = false

c.colors = {
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

-- Fullscreen toggle with Super+Enters
c.keys = {
	{
		key = "Enter",
		mods = "CMD",
		action = wezterm.action.ToggleFullScreen,
	},
}

c.exit_behavior = "Close"

-- Use the following to launch tmux on startup
-- /bin/zsh -c "tmux attach"
c.default_prog = {"/opt/homebrew/bin/tmux", "attach"}

return c
