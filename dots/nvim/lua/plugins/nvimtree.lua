return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = {
    "NvimTreeToggle",
    "NvimTreeFindFile",
    "NvimTreeFocus",
  },
  init = function()
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function(data)
        if vim.fn.isdirectory(data.file) == 1 then
          require("nvim-tree.api").tree.open()
        end
      end,
    })
  end,
  opts = {
    sort_by = "case_sensitive",
    view = {
      width = 32,
      side = "right",
    },
    renderer = {
      highlight_git = true,
      root_folder_label = false,
      indent_markers = { enable = true },
    },
    update_focused_file = {
      enable = true,
      update_root = true,
      ignore_list = {},
    },
    actions = {
      open_file = {
        quit_on_open = false,
        resize_window = true,
      },
      file_popup = {
        open_win_config = {
          border = "rounded",
        },
      },
    },
    trash = {
      cmd = "gio trash",
    },
    on_attach = function(bufnr)
      local api = require("nvim-tree.api")
      api.config.mappings.default_on_attach(bufnr)

      local function map(lhs, rhs, desc)
        vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = "NvimTree: " .. desc, noremap = true, silent = true })
      end

      map("a", api.fs.create, "Create file/folder")
      map("d", function()
        api.fs.remove(nil, { confirm = true, recursive = true })
      end, "Delete (confirm)")
      map("r", api.fs.rename, "Rename")
      map("m", api.fs.cut, "Cut")
      map("p", api.fs.paste, "Paste")
      map("y", api.fs.copy.node, "Copy")
      map("Y", api.fs.copy.filename, "Copy Name")
      map("gy", api.fs.copy.absolute_path, "Copy Absolute Path")
      map("o", api.node.open.edit, "Open")
      map("<CR>", api.node.open.edit, "Open")
      map("v", api.node.open.vertical, "Open: Vertical Split")
      map("s", api.node.open.horizontal, "Open: Horizontal Split")
      map("t", api.node.open.tab, "Open: New Tab")
      map("R", api.tree.reload, "Refresh")
      map(".", api.tree.toggle_hidden_filter, "Toggle Dotfiles")
      map("?", api.tree.toggle_help, "Help")
    end,
  },
}
