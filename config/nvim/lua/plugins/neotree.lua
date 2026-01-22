return {
  -- Neo-tree needs devicons; ensure it's enabled
  { "nvim-tree/nvim-web-devicons", enabled = true },

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    keys = {
      { "<Leader>e", "<Cmd>Neotree filesystem toggle<CR>", desc = "Explorer (Neo-tree)" },
    },
    opts = {
      close_if_last_window = true,
      filesystem = {
        follow_current_file = { enabled = true },
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false, -- ✅ show gitignored
        },
      },
    },
  },
}
