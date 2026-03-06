return {
  "nvimtools/none-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local null_ls = require("null-ls")
    local helpers = require("null-ls.helpers")
    local methods = require("null-ls.methods")

    local FORMATTING = methods.internal.FORMATTING

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
        return { "--plugin", "rubocop-rails" }
      end

      return {}
    end

    local function rubocop_extra_args(params)
      local extra = { "--no-color" }
      vim.list_extend(extra, rubocop_plugins_for(params.root))
      return extra
    end

    local herb_format_global = {
      name = "herb-format",
      method = FORMATTING,
      filetypes = { "eruby" },
      generator = helpers.formatter_factory({
        command = "herb-format",
        args = { "--force" },
        to_stdin = true,
      }),
      runtime_condition = function()
        return vim.fn.executable("herb-format") == 1
      end,
    }

    local herb_format_npx = {
      name = "@herb-tools/formatter (npx)",
      method = FORMATTING,
      filetypes = { "eruby" },
      generator = helpers.formatter_factory({
        command = "npx",
        args = { "-y", "@herb-tools/formatter", "--force" },
        to_stdin = true,
      }),
      runtime_condition = function()
        return vim.fn.executable("herb-format") ~= 1 and vim.fn.executable("npx") == 1
      end,
    }

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
        herb_format_global,
        herb_format_npx,
      },
      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          local group = vim.api.nvim_create_augroup("NullLSFormatOnSave", { clear = false })
          vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = group,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({
                async = false,
                bufnr = bufnr,
                filter = function(c)
                  return c.name == "null-ls"
                end,
              })
            end,
          })
        end
      end,
    })
  end,
}
