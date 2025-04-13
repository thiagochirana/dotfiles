-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  "tpope/vim-rails",
  "tpope/vim-endwise",
  "tpope/vim-bundler",
  "tpope/vim-rake",
  "tpope/vim-surround",
  "tpope/vim-commentary",
  "vim-ruby/vim-ruby",
  "leafgarland/typescript-vim",
  "pangloss/vim-javascript",
  "peitalin/vim-jsx-typescript",
  "mattn/emmet-vim",
  "nvim-lualine/lualine.nvim",
  "nvim-treesitter/nvim-treesitter",
  "neovim/nvim-lspconfig",
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "L3MON4D3/LuaSnip",
  "saadparwaiz1/cmp_luasnip"
})

