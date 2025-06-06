return {
    "nvimtools/none-ls.nvim",
    config = function()
      local null_ls = require("null-ls")

      null_ls.setup({
        sources = {
          null_ls.builtins.diagnostics.rubocop,
          null_ls.builtins.formatting.rubocop,
        },
      })
    end,
  }
