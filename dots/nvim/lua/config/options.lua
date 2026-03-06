local opt = vim.opt

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

opt.termguicolors = true
opt.number = true
opt.relativenumber = true
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.completeopt = { "menu", "menuone", "noselect" }
opt.breakindent = true
opt.smartindent = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftround = true
opt.expandtab = true
opt.list = true
opt.listchars = {
  tab = "> ",
  trail = "~",
  extends = ">",
  precedes = "<",
  nbsp = "+",
  space = ".",
}
opt.fillchars:append({ eob = " " })
opt.signcolumn = "yes"
opt.ignorecase = true
opt.smartcase = true
opt.updatetime = 200
opt.timeoutlen = 400
opt.splitright = true
opt.splitbelow = true
opt.scrolloff = 6

-- Guarantee classic syntax + filetype detection (Treesitter still used).
vim.cmd("filetype plugin indent on")
vim.cmd("syntax enable")
