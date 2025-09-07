return {
  {
    --  _____ __  __ _   ___  __  _   _             _             _             
    -- |_   _|  \/  | | | \ \/ / | \ | | __ ___   _(_) __ _  __ _| |_ ___  _ __ 
    --   | | | |\/| | | | |\  /  |  \| |/ _` \ \ / / |/ _` |/ _` | __/ _ \| '__|
    --   | | | |  | | |_| |/  \  | |\  | (_| |\ V /| | (_| | (_| | || (_) | |   
    --   |_| |_|  |_|\___//_/\_\ |_| \_|\__,_| \_/ |_|\__, |\__,_|\__\___/|_|   
    --                                                |___/                     
    "christoomey/vim-tmux-navigator",
    enabled = true,
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
      "TmuxNavigatorProcessList",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
    -- config = function()
    --   -- To be exectute for setup
    -- end,
  },
}
