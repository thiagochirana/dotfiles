return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = false
    end,
    opts = { },
  }