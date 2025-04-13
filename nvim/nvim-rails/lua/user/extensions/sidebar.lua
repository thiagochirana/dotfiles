return {
  "nvim-tree/nvim-tree.lua",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    local nvimtree = require("nvim-tree")

    -- recommended settings from nvim-tree documentation
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    nvimtree.setup({
      view = {
        width = 25,
        relativenumber = true,
        float = {
          enable = true,
--          open_win_config = function()
--            local screen_w = vim.opt.columns:get()
--            local screen_h = vim.opt.lines:get()
--            local w_h = 70
--            local s_h = 42
--            local center_x = (screen_w - w_h) / 2
--            local center_y = ((vim.opt.lines:get() - s_h) / 5) - vim.opt.cmdheight:get()
--            return {
--              border = "rounded",
--              relative = "editor",
--              row = center_y,
--              width = w_h,
--              height = s_h,
--            }
--          end,
        },
        side = "right",
      },
      -- change folder arrow icons
      renderer = {
        indent_markers = {
          enable = true,
        }
      },
      -- disable window_picker for
      -- explorer to work well with
      -- window splits
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
        },
      },
      filters = {
        custom = { ".DS_Store" },
      },
      git = {
        ignore = false,
      },
    })

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
    keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" }) -- toggle file explorer on current file
    keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
    keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer
  end
}