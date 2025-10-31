return {
  "numToStr/Comment.nvim",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    padding = true,
    sticky = true,
  },
  config = function(_, opts)
    require("Comment").setup(opts)
  end,
}
