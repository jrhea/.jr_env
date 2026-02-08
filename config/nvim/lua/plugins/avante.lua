return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",

    -- If you already have these elsewhere, you can remove duplicates.
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      -- Optional but strongly recommended for a nicer API-key / prompt UI:
      { "folke/snacks.nvim", opts = { input = { enabled = true } } },
    },

    opts = {
      ---------------------------------------------------------------------------
      -- UI: right-side pane like Cursor
      ---------------------------------------------------------------------------
      windows = {
        position = "right",
        width = 25,
      },

      -- Better prompt UI (optional)
      input = {
        provider = "snacks", -- per Avante docs this is a supported input provider
        provider_opts = {
          title = "Avante",
          icon = " ",
        },
      },

      provider = "codex",
      acp_providers = {
        codex = {
          command = "npx",
          args = { "@zed-industries/codex-acp" },
        },
        ["claude-code"] = {
          command = "npx",
          args = { "@zed-industries/claude-code-acp" },

        }
      },
    },
  },
}
