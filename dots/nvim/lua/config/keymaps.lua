local M = {}

local default_opts = { silent = true, remap = false, noremap = true }

local mappings = {
  { mode = { "n", "v" }, lhs = "<Space>", rhs = "<Nop>", desc = "Leader key placeholder", opts = { silent = true } },
  { mode = "n", lhs = "<leader>q", rhs = vim.cmd.quit, desc = "Quit window" },
  { mode = "n", lhs = "<leader>w", rhs = vim.cmd.write, desc = "Save file" },
  { mode = "n", lhs = "<leader>h", rhs = "<C-w>h", desc = "Focus left window" },
  { mode = "n", lhs = "<leader>j", rhs = "<C-w>j", desc = "Focus lower window" },
  { mode = "n", lhs = "<leader>k", rhs = "<C-w>k", desc = "Focus upper window" },
  { mode = "n", lhs = "<leader>l", rhs = "<C-w>l", desc = "Focus right window" },
  { mode = "n", lhs = "<leader>sh", rhs = ":split<CR>", desc = "Split window horizontally" },
  { mode = "n", lhs = "<leader>sv", rhs = ":vsplit<CR>", desc = "Split window vertically" },
  {
    mode = "n",
    lhs = "<leader>e",
    rhs = function()
      if not package.loaded["nvim-tree"] then
        require("lazy").load({ plugins = { "nvim-tree.lua" } })
      end
      local api = require("nvim-tree.api")
      if api.tree.is_visible() then
        api.tree.close()
      else
        api.tree.open({ find_file = true, focus = true })
      end
    end,
    desc = "Toggle file explorer",
  },
  { mode = "n", lhs = "<leader>rn", rhs = vim.lsp.buf.rename, desc = "Rename symbol" },
  { mode = "n", lhs = "<leader>ca", rhs = vim.lsp.buf.code_action, desc = "Code actions" },
  {
    mode = "n",
    lhs = "<leader>cf",
    rhs = function()
      vim.lsp.buf.format({ async = true })
    end,
    desc = "Format buffer",
  },
  {
    mode = "n",
    lhs = "<leader>fs",
    rhs = function()
      require("telescope.builtin").live_grep()
    end,
    desc = "Search text in files",
  },
  { mode = "n", lhs = "gd", rhs = vim.lsp.buf.definition, desc = "Go to definition" },
  { mode = "n", lhs = "K", rhs = vim.lsp.buf.hover, desc = "Hover documentation" },
  { mode = "n", lhs = "<leader>cr", rhs = vim.lsp.buf.references, desc = "List references" },
}

M.spec = {
  { "<leader>c", group = "code" },
  { "<leader>f", group = "find" },
  { "<leader>g", group = "git" },
  { "<leader>s", group = "splits" },
  { "<leader>fs", desc = "Search text in files" },
}

function M.setup()
  for _, map in ipairs(mappings) do
    local opts = vim.tbl_extend("force", {}, default_opts)
    if map.opts then
      opts = vim.tbl_extend("force", opts, map.opts)
    end
    opts.desc = map.desc
    vim.keymap.set(map.mode, map.lhs, map.rhs, opts)
  end
end

return M
