return {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = {
      options = {
        mode = "tabs", -- ou "buffers" se preferir
        separator_style = "slant", -- ou "thick", "thin", "padded_slant", etc
        show_buffer_close_icons = false,
        show_close_icon = false,
        enforce_regular_tabs = true,
        always_show_bufferline = true,
        diagnostics = "nvim_lsp", -- mostra erros direto na tab se quiser
      },
    },
  }
