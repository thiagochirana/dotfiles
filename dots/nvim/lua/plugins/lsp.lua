return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    {
      "williamboman/mason.nvim",
      config = function()
        require("mason").setup()
      end,
    },
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    local mason_lspconfig = require("mason-lspconfig")

    local server_configs = {
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
          },
        },
      },
      bashls = {},
      pyright = {},
      ruby_lsp = {
        init_options = {
          formatting = true,
          rubyVersion = "ruby",
        },
      },
      html = {},
      cssls = {},
      tailwindcss = {
        filetypes = {
          "html",
          "css",
          "scss",
          "javascript",
          "typescript",
          "javascriptreact",
          "typescriptreact",
          "svelte",
          "vue",
          "eruby",
        },
        settings = {
          tailwindCSS = {
            includeLanguages = {
              eruby = "erb",
            },
          },
        },
      },
    }

    local ensure_servers = vim.tbl_keys(server_configs)
    mason_lspconfig.setup({ ensure_installed = ensure_servers })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    if ok then
      capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
    end

    local on_attach = function(_, bufnr)
      vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
    end

    vim.lsp.config("*", {
      capabilities = capabilities,
      on_attach = on_attach,
    })

    for name, cfg in pairs(server_configs) do
      if cfg and next(cfg) ~= nil then
        vim.lsp.config(name, cfg)
      end
    end

    vim.lsp.enable(ensure_servers)
  end,
}
