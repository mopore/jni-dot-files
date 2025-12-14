local wezterm = require("wezterm")
local BG_OPACITY = 0.95

wezterm.on("format-window-title", function()
  -- return "  wezterm"
  return "λ - hack!"
end)


-- Track fullscreen state
wezterm.on("window-resized", function(window, _)
  local overrides = window:get_config_overrides() or {}
  if window:get_dimensions().is_full_screen then
    overrides.window_background_opacity = 1.0
    overrides.macos_window_background_blur = nil
  else
    overrides.window_background_opacity = BG_OPACITY
    overrides.macos_window_background_blur = 20
  end
  window:set_config_overrides(overrides)
end)


-- -- Place and size the window on startup
-- wezterm.on("gui-startup", function(cmd)
--   local _, _, window = wezterm.mux.spawn_window(cmd or {})
--   local screen_w = 3440
--   local screen_h = 1440
--   local win_w = 1219
--   local win_h = 1295
--   local pos_x = math.floor((screen_w - win_w) / 2)
--   local pos_y = math.floor((screen_h - win_h) / 2) + 45
--
--   window:gui_window():set_position(pos_x, pos_y)
--   window:gui_window():set_inner_size(win_w, win_h)
-- end)


local c = wezterm.config_builder()

-- Check before setting
-- c.max_fps = 120

-- c.enable_wayland = false -- If you want window decorations on Wayland (switch to X11)
-- c.front_end = "OpenGL"  -- Needed for Arch VM on Apple Silicon

c.initial_rows = 40
c.initial_cols = 120

c.font = wezterm.font("JetBrainsMono Nerd Font")
c.font_size = 18.0  -- Highly dependent on your monitor DPI
c.window_close_confirmation = 'NeverPrompt'

c.window_background_opacity = BG_OPACITY
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

-- Fullscreen toggle with Super+Enters
c.keys = {
	{
		key = "Enter",
		mods = "CMD",
		action = wezterm.action.ToggleFullScreen,
	},
}

c.exit_behavior = "CloseOnCleanExit" -- Avoid confirmation dialog on window close
c.exit_behavior_messaging = "Verbose"

-- Use the following to launch tmux on startup
-- Attach to existing tmux session if existing otherwise create a new one
c.default_prog = {"/usr/bin/tmux", "new", "-A", "-s", "main"}

-- -- For MacOS, tmux installed via brew is in /opt/homebrew/bin/tmux
-- -- and zsh in /opt/homebrew/bin/zsh
-- -- Attach to existing tmux session if existing otherwise create a new one.
-- -- Should tmux need new permissions wezterm can still be used with zsh.
-- c.default_prog = {
--   "/opt/homebrew/bin/zsh",
--   "-l",  -- login shell, if you want your usual env
--   "-c",  -- run the following command
--   [[
--     /opt/homebrew/bin/tmux new -A -s main || {
--       echo "[wezterm] tmux failed, falling back to zsh..." >&2
--       exec /opt/homebrew/bin/zsh -l
--     }
--   ]],
-- }


--[[
-- Example for using general lua code
local time = os.date("%Y-%m-%d %H:%M:%S")
local file = io.open("/home/jni/time.txt", "w")

if not file then
  print("Could not get file handle")
else
  file:write("Current time: " .. time .. "\n")
  file:close()
end
--]]

return c
