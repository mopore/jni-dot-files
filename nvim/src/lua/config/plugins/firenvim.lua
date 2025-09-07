return {
  {
    --- Plugin to spawn a neovim iframe for a text field
    ---
    --  _____ _                     _
    -- |  ___(_)_ __ ___ _ ____   _(_)_ __ ___
    -- | |_  | | '__/ _ \ '_ \ \ / / | '_ ` _ \
    -- |  _| | | | |  __/ | | \ V /| | | | | | |
    -- |_|   |_|_|  \___|_| |_|\_/ |_|_| |_| |_|
    --
    ---
    'glacambre/firenvim',
    enabled = true,
    build = ":call firenvim#install(0)"
    -- config = function()
    --   -- To be exectute for setup
    -- end,
  },
}
