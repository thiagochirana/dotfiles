return {
  "themaxmarchuk/tailwindcss-colors.nvim",
  ft = { "html", "eruby", "htmldjango", "javascriptreact", "typescriptreact", "vue", "svelte" },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("tailwindcss-colors").setup({
      enable_background = false,
      enable_foreground = true,
      enable_virtual_text = true,
    })
  end,
}
