local highlight = {
  "RainbowRed",
  "RainbowYellow",
  "RainbowBlue",
  "RainbowOrange",
  "RainbowGreen",
  "RainbowViolet",
  "RainbowCyan",
}

return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    indent = {
      char = "│",
      highlight = highlight,
    },
    scope = {
      enabled = true,
      show_start = false,
      show_end = false,
      highlight = "IblScope",
      exclude = { language = { "help", "markdown" } },
    },
    exclude = {
      filetypes = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy" },
      buftypes = { "terminal", "nofile" },
    },
  },
  config = function(_, opts)
    local hooks = require("ibl.hooks")

    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
      vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
      vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
      vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
      vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
      vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
      vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
      vim.api.nvim_set_hl(0, "IblIndent", { fg = "#3b3f52" })
      vim.api.nvim_set_hl(0, "IblScope", { fg = "#9d7cd8", bold = true })
    end)

    opts.indent.highlight = highlight
    require("ibl").setup(opts)
  end,
}
