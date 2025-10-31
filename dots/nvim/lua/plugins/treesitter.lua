return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = { "windwp/nvim-ts-autotag" },
  opts = {
    ensure_installed = {
      "lua",
      "bash",
      "json",
      "yaml",
      "markdown",
      "python",
      "ruby",
      "html",
      "css",
      "javascript",
      "embedded_template",
    },
    highlight = { enable = true },
    indent = { enable = true },
    autotag = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
      },
    },
  },
  config = function(_, opts)
    pcall(vim.treesitter.language.register, "embedded_template", "eruby")
    require("nvim-treesitter.configs").setup(opts)
  end,
}
