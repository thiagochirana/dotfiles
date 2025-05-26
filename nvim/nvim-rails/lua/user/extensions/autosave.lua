return {
    "pocco81/auto-save.nvim",
    config = function()
      require("auto-save").setup({
        enabled = false,
        execution_message = {
          message = function()
            return ("💾 autosave at " .. vim.fn.strftime("%H:%M:%S"))
          end,
          dim = 0.18,
          cleaning_interval = 1250,
        },
        events = { "InsertLeave", "TextChanged" },
        conditions = {
          exists = true,
          filename_is_not = {},
          filetype_is_not = {},
          modifiable = true,
        },
        write_all_buffers = false,
      })

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>as", ":ASToggle<CR>", {}) -- toggle autosafe
    end,
  }
