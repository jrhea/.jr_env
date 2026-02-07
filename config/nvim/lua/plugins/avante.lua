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

      ---------------------------------------------------------------------------
      -- OPTION A: Use OpenAI API directly (no ACP / no Codex CLI needed)
      ---------------------------------------------------------------------------
      provider = "codex",
      providers = {
        openai = {
          endpoint = "https://api.openai.com/v1",
          -- Pick a coding-oriented model name you actually have access to.
          -- Safe defaults if you're unsure:
          model = "gpt-5-code",
          timeout = 60000,

          -- Request-body knobs MUST go under extra_request_body on newer Avante.
          extra_request_body = {
            temperature = 0,
            -- If you use long generations, bump this.
            max_completion_tokens = 4096,
          },
        },
      },
      acp_providers = {
        codex = {
          command = "npx",
           args = { "@zed-industries/codex-acp" },
        },
      },
    },
  },
}
