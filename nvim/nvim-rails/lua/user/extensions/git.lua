return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("gitsigns").setup({
        signs = {
          add          = { text = "➕" },
          change       = { text = "🔁" },
          delete       = { text = "🗑️" },
          topdelete    = { text = "🗑️" },
          changedelete = { text = "▎" },
        },
        signcolumn = true,
        numhl = false,
        linehl = false,
        watch_gitdir = {
          interval = 1000,
          follow_files = true,
        },
        attach_to_untracked = true,
        current_line_blame = true,
        current_line_blame_opts = {
          delay = 500,
          virt_text_pos = "eol",
        },
      })
    end,
  }
