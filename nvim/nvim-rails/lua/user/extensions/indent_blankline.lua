return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      indent = {
        char = "│",
      },
      scope = {
        enabled = true,
        show_start = false,
        show_end = false,
        highlight = {
          "RainbowYellow",
          "RainbowRed",
          "RainbowOrange",
          "RainbowBlue",
          "RainbowGreen",
          "RainbowViolet",
          "RainbowCyan",
        },
      },
    },
    config = function(_, opts)
      -- Define as cores
      vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
      vim.api.nvim_set_hl(0, "RainbowRed",    { fg = "#E06C75" })
      vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
      vim.api.nvim_set_hl(0, "RainbowBlue",   { fg = "#61AFEF" })
      vim.api.nvim_set_hl(0, "RainbowGreen",  { fg = "#98C379" })
      vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
      vim.api.nvim_set_hl(0, "RainbowCyan",   { fg = "#56B6C2" })

      require("ibl").setup(opts)
    end,
  }
