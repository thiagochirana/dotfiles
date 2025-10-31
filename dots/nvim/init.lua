-- Entrypoint para a configuração em Lua do Neovim.
require("config.options")
require("config.keymaps").setup()
require("config.autocmds")
require("config.lazy")
