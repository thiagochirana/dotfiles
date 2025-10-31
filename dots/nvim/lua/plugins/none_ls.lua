return {
  "nvimtools/none-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local null_ls = require("null-ls")

    local function rubocop_plugins_for(root)
      if not root or root == "" then
        return {}
      end

      local config = vim.fs.find(".rubocop.yml", { path = root, upward = true })[1]
      if not config then
        return {}
      end

      local ok, lines = pcall(vim.fn.readfile, config)
      if not ok or not lines then
        return {}
      end

      local content = table.concat(lines, "\n")
      if content:find("rubocop%-rails") then
        return { "--plugins", "rubocop-rails" }
      end

      return {}
    end

    local function rubocop_extra_args(params)
      local extra = { "--no-color" }
      vim.list_extend(extra, rubocop_plugins_for(params.root))
      return extra
    end

    null_ls.setup({
      sources = {
        null_ls.builtins.diagnostics.rubocop.with({
          prefer_local = "bin",
          extra_args = rubocop_extra_args,
        }),
        null_ls.builtins.formatting.rubocop.with({
          prefer_local = "bin",
          extra_args = rubocop_extra_args,
        }),
      },
      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          local group = vim.api.nvim_create_augroup("RubocopFormatOnSave", { clear = false })
          vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = group,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ async = false, bufnr = bufnr })
            end,
          })
        end
      end,
    })
  end,
}
