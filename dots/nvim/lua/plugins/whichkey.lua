return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    plugins = {
      spelling = { enabled = true },
    },
    win = {
      border = "rounded",
      padding = { 1, 2 },
      title = true,
      title_pos = "center",
      zindex = 60,
      wo = {
        winblend = 0,
      },
    },
    layout = {
      width = { min = 20, max = 50 },
      spacing = 4,
      align = "left",
    },
    icons = {
      breadcrumb = "»",
      separator = "➜",
      group = "●",
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    local keymaps = require("config.keymaps")
    wk.setup(opts)
    wk.add(keymaps.spec)
  end,
}
