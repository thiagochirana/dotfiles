return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    {
      "williamboman/mason.nvim",
      cmd = {
        "Mason",
        "MasonInstall",
        "MasonUpdate",
        "MasonUninstall",
        "MasonUninstallAll",
        "MasonLog",
      },
      config = function()
        require("mason").setup()
      end,
    },
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    local mason_lspconfig = require("mason-lspconfig")
    local util = require("lspconfig.util")

    local function read_first_line(path)
      local f = io.open(path, "r")
      if not f then
        return nil
      end
      local line = f:read("*l")
      f:close()
      if not line then
        return nil
      end
      line = line:gsub("^%s+", ""):gsub("%s+$", "")
      if line == "" then
        return nil
      end
      return line
    end

    local function ruby_lsp_cmd()
      local bufnr = vim.api.nvim_get_current_buf()
      local root = vim.fs.root(bufnr, { ".ruby-version", "Gemfile", ".git" })
      local ver = root and read_first_line(root .. "/.ruby-version") or nil

      -- mason's ruby-lsp stub hardcodes the Ruby interpreter it was installed with.
      -- Running the stub script through `ruby` lets us pick the right Ruby per-project.
      if ver and vim.fn.executable("mise") == 1 then
        local mason_script = vim.fn.stdpath("data") .. "/mason/packages/ruby-lsp/bin/ruby-lsp"
        return { "mise", "x", "ruby@" .. ver, "--", "ruby", mason_script }
      end

      return { "ruby-lsp" }
    end

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
        cmd = ruby_lsp_cmd,
        cmd_env = {
          GEM_PATH = (vim.fn.stdpath("data") .. "/mason/packages/ruby-lsp") .. ":" .. (vim.env.GEM_PATH or ""),
        },
        init_options = {
          formatting = false,
          rubyVersion = "ruby",
        },
      },
      herb_ls = {},
      html = {},
      cssls = {},
      ts_ls = {},
      eslint = {},
      tailwindcss = {
        root_dir = util.root_pattern(
          "tailwind.config.js",
          "tailwind.config.cjs",
          "tailwind.config.mjs",
          "tailwind.config.ts",
          "postcss.config.js",
          "postcss.config.cjs"
        ),
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
