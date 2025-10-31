return {
  "stevearc/dressing.nvim",
  event = "VeryLazy",
  opts = {
    input = {
      enabled = true,
      default_prompt = "➤ ",
      win_options = {
        winblend = 0,
      },
      border = "rounded",
      mappings = {
        n = {
          ["q"] = "Close",
          ["<Esc>"] = "Cancel",
        },
      },
    },
    select = {
      enabled = true,
      backend = { "telescope", "fzf_lua", "builtin" },
      builtin = {
        border = "rounded",
        win_options = {
          winblend = 0,
        },
      },
    },
  },
}
