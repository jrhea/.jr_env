-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

local function find_win(pred)
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if pred(buf, win) then return win end
  end
end

local function resize_win_width(win, delta)
  if not win or not vim.api.nvim_win_is_valid(win) then return end
  local w = vim.api.nvim_win_get_width(win)
  vim.api.nvim_win_set_width(win, math.max(1, w + delta))
end

local function resize_win_height(win, delta)
  if not win or not vim.api.nvim_win_is_valid(win) then return end
  local h = vim.api.nvim_win_get_height(win)
  vim.api.nvim_win_set_height(win, math.max(1, h + delta))
end

local function neotree_win()
  return find_win(function(buf)
    return vim.bo[buf].filetype == "neo-tree"
  end)
end

local function terminal_win()
  return find_win(function(buf)
    return vim.bo[buf].buftype == "terminal"
  end)
end

local function resize_neotree(delta)
  local win = neotree_win()
  if win then resize_win_width(win, delta) end
end

local function resize_terminal(delta)
  local win = terminal_win()
  if win then resize_win_height(win, delta) end
end


---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics = { virtual_text = true, virtual_lines = false }, -- diagnostic settings on startup
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- passed to `vim.filetype.add`
    filetypes = {
      -- see `:h vim.filetype.add` for usage
      extension = {
        foo = "fooscript",
      },
      filename = {
        [".foorc"] = "fooscript",
      },
      pattern = {
        [".*/etc/foo/.*"] = "fooscript",
      },
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "yes", -- sets vim.opt.signcolumn to yes
        wrap = false, -- sets vim.opt.wrap

        expandtab = true,
        shiftwidth = 2,
        tabstop = 2,
        softtabstop = 2,
        textwidth = 80,
        linebreak = true,
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map

        -- Buffers
        ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },
        -- mappings seen under group name "Buffer"
        ["<Leader>bd"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Close buffer from tabline",
        },

        -- navigation
        ["<C-Left>"] = { "<C-o>", desc = "Jump back" },
        ["<C-Right>"] = { "<C-i>", desc = "Jump forward" },
        ["<M-Down>"] = { "<C-d>zz", desc = "Scroll down half page (centered)" },
        ["<M-Up>"]   = { "<C-u>zz", desc = "Scroll up half page (centered)" },
        ["<Down>"] = { "jzz", desc = "Move down (centered)" },
        ["<Up>"]   = { "kzz", desc = "Move up (centered)" },

        -- pane resizing
        ["<Leader><Left>"]  = { function() resize_neotree(-2) end, desc = "Neo-tree narrower" },
        ["<Leader><Right>"] = { function() resize_neotree( 2) end, desc = "Neo-tree wider" },
        ["<Leader><Up>"]    = { function() resize_terminal( 2) end, desc = "Terminal taller" },
        ["<Leader><Down>"]  = { function() resize_terminal(-2) end, desc = "Terminal shorter" },

        -- LSP
        ["<Leader>la"] = { function() vim.lsp.buf.code_action() end, desc = "List actions" },
        ["gr"] = { 
          function()
            require("snacks").picker.lsp_references { auto_confirm = false }
          end,
          desc = "Find references (list)",
        },
        ["gd"] = {
          function()
            vim.lsp.buf.definition()
          end,
          desc = "Go to definition",
        },
        ["<Leader>rn"] = { function() vim.lsp.buf.rename() end, desc = "Rename symbol" },

        -- LLM
        ["<Leader>ac"] = { "<cmd>AvanteChat<cr>", desc = "Chat (right pane)" },
        ["<Leader>ap"] = {
          function()
            local providers = {
                { label = "codex (OAuth via ACP)", value = "codex" },
                { label = "claude-code (ACP)",     value = "claude-code" },
              }

              vim.ui.select(providers, {
                prompt = "Avante provider",
                format_item = function(item) return item.label end,
              }, function(choice)
                if not choice then return end
                vim.cmd("AvanteSwitchProvider " .. choice.value)
              end)
            end,
            desc = "Switch LLM Provider",
          },
        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        -- ["<Leader>b"] = { desc = "Buffers" },

        -- setting a mapping to false will disable it
        -- ["<C-S>"] = false,
      },
      t = {
        ["<Leader><Left>"]  = { function() resize_neotree(-2) end, desc = "Neo-tree narrower" },
        ["<Leader><Right>"] = { function() resize_neotree( 2) end, desc = "Neo-tree wider" },

        ["<Leader><Up>"]    = { function() resize_terminal( 2) end, desc = "Terminal taller" },
        ["<Leader><Down>"]  = { function() resize_terminal(-2) end, desc = "Terminal shorter" },
      },
      i = {
        ["jk"] = { "<Esc>", desc = "Escape insert mode" },
      },
    },
  },
}
