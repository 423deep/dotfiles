return {
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    keys = {
      { "<C-h>", "<cmd>TmuxNavigateLeft<cr>", mode = { "n", "v" } },
      { "<C-j>", "<cmd>TmuxNavigateDown<cr>", mode = { "n", "v" } },
      { "<C-k>", "<cmd>TmuxNavigateUp<cr>", mode = { "n", "v" } },
      { "<C-l>", "<cmd>TmuxNavigateRight<cr>", mode = { "n", "v" } },
      { "<C-\\>", "<cmd>TmuxNavigatePrevious<cr>", mode = { "n", "v" } },
    },
  },
}
