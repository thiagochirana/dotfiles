return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    indent = {
      char = "│",
      highlight = "IblIndent",
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
    local ibl = require("ibl")
    ibl.setup(opts)
    local hooks = require("ibl.hooks")

    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, "IblIndent", { fg = "#3b3f52" })
      vim.api.nvim_set_hl(0, "IblScope", { fg = "#9d7cd8", bold = true })
    end)
  end,
}
