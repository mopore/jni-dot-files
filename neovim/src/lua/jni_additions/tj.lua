-- To run this script, use the command:
-- :luafile %
--
-- Also create a folder "plugin" inside ~/.config/nvim/
-- Files inside this folder will be sources automatically
--

local state = {
  floating = {
    buf = -1,
    win = -1,
  }
}

local function create_floating_window(opts)
  opts = opts or {}
  local width = opts.width or math.floor(vim.o.columns * 0.8)
  local height = opts.height or math.floor(vim.o.lines * 0.8)

  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  local buf = vim.api.nvim_create_buf(false, true)  -- no file, scratch buffer

  local win_config = {
    relative = "editor",
    width = width,
    height = height,
    col = col,
    row = row,
    style = "minimal", -- no extra UI elements
    border = "rounded",
  }

  local win = vim.api.nvim_open_win(buf, true, win_config)

  return {
    buf = buf,
    win = win,
  }
end

state.floating = create_floating_window()



