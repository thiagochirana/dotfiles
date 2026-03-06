return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  lazy = false,
  dependencies = { "windwp/nvim-ts-autotag" },
  config = function()
    local langs = {
      "lua",
      "bash",
      "json",
      "yaml",
      "markdown",
      "python",
      -- Ruby / Rails
      "ruby",
      "embedded_template", -- ERB
      "html",
      "css",
      "javascript",
      "typescript",
      "tsx",
    }

    -- Rails templates (.erb) usually use the 'eruby' filetype.
    local ok_register = pcall(vim.treesitter.language.register, "embedded_template", { "eruby" })
    if not ok_register then
      pcall(vim.treesitter.language.register, "embedded_template", "eruby")
    end

    -- NOTE: this repo uses the newer nvim-treesitter API where parser management
    -- lives in `require("nvim-treesitter")` and highlighting is started via
    -- `vim.treesitter.start()`.
    local ts = require("nvim-treesitter")
    ts.setup({
      install_dir = vim.fn.stdpath("data") .. "/site",
    })

    pcall(function()
      ts.install(langs)
    end)

    pcall(function()
      require("nvim-ts-autotag").setup()
    end)

    local group = vim.api.nvim_create_augroup("TreesitterStart", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      pattern = {
        "lua",
        "bash",
        "json",
        "yaml",
        "markdown",
        "python",
        "ruby",
        "rake",
        "html",
        "css",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "eruby",
      },
      callback = function()
        pcall(vim.treesitter.start)
      end,
    })
  end,
}
