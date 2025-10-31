local group = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local yank_group = group("HighlightYank", { clear = true })
local highlight_group = group("CustomHighlights", { clear = true })

autocmd("TextYankPost", {
  group = yank_group,
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 150 })
  end,
})

autocmd("BufWritePost", {
  pattern = { "*.lua", "*.vim" },
  callback = function(args)
    vim.schedule(function()
      vim.cmd("silent! checktime " .. args.file)
    end)
  end,
})

local function apply_custom_highlights()
  vim.api.nvim_set_hl(0, "Whitespace", { link = "NonText" })
end

apply_custom_highlights()

autocmd("ColorScheme", {
  group = highlight_group,
  callback = apply_custom_highlights,
})
