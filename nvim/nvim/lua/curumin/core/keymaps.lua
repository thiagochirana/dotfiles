vim.g.mapleader = " "

local km = vim.keymap

km.set("i", "jk", "<ESC>", { desc = "Exit INSERT MODE with jk"} )

km.set("n", "<leader>nh", ":nohl<CR>", {desc = "Clear search highlights"})


km.set("n", "<leader>sv", "<C-w>v", {desc = "Split window vertically" })
km.set("n", "<leader>sh", "<C-w>s", {desc = "Split window horizontally" })
km.set("n", "<leader>se", "<C-w>=", {desc = "Make splits equals" })
km.set("n", "<leader>sc", "<cmd>close<CR>", {desc = "Close current split" })



km.set("n", "<leader>tn", "<cmd>tabnew<CR>", {desc = "Open new tab" })
km.set("n", "<leader>tc", "<cmd>tabclose<CR>", {desc = "Close current tab" })
km.set("n", "<leader>ta", "<cmd>tabn<CR>", {desc = "Go to next tab" })
km.set("n", "<leader>td", "<cmd>tabp<CR>", {desc = "Go to previous tab" })
km.set("n", "<leader>tf", "<cmd>tabnew %<CR>", {desc = "Duplicate tab" })
