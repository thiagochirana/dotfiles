local M = {}

local function sepia_options()
  local bg = "#f5ede1"
  local alt = "#e8ddc9"
  local border = "#d9c7ac"
  local scope = "#c09462"

  return {
    style = "day",
    transparent = false,
    on_colors = function(colors)
      colors.bg = bg
      colors.bg_dark = alt
      colors.bg_highlight = "#e3d4bd"
      colors.bg_float = bg
      colors.bg_popup = "#f1e3d2"
      colors.bg_statusline = alt
      colors.fg = "#4a3f35"
      colors.fg_dark = "#3a3129"
      colors.fg_gutter = "#b9a88f"
      colors.comment = "#a89279"
      colors.warning = "#c97a3e"
      colors.hint = "#4f6752"
      colors.info = "#5a6f81"
      colors.error = "#b14d3f"
      colors.border = border
    end,
    on_highlights = function(highlights, colors)
      highlights.Normal = { fg = colors.fg, bg = bg }
      highlights.NormalFloat = { fg = colors.fg, bg = bg }
      highlights.FloatBorder = { fg = border, bg = bg }
      highlights.CursorLine = { bg = "#ede2d0" }
      highlights.CursorLineNr = { fg = "#ab7946", bg = "#ede2d0", bold = true }
      highlights.LineNr = { fg = "#bda98f", bg = bg }
      highlights.StatusLine = { fg = colors.fg, bg = alt }
      highlights.StatusLineNC = { fg = colors.fg_gutter, bg = alt }
      highlights.VertSplit = { fg = border, bg = bg }
      highlights.Visual = { bg = "#dbc8ae" }
      highlights.Search = { fg = colors.fg, bg = "#e5b469" }
      highlights.IncSearch = { fg = colors.fg, bg = "#d49d52" }
      highlights.Pmenu = { fg = colors.fg, bg = alt }
      highlights.PmenuSel = { fg = colors.bg, bg = "#d6b088" }
      highlights.IblIndent = { fg = "#d4c8b5" }
      highlights.IblScope = { fg = scope, bold = true }
    end,
  }
end

local function night_options()
  return {
    style = "night",
    transparent = false,
    on_highlights = function(highlights)
      highlights.IblIndent = { fg = "#3b4261" }
      highlights.IblScope = { fg = "#7aa2f7", bold = true }
    end,
  }
end

local variants = {
  light = sepia_options,
  dark = night_options,
}

local function apply(variant)
  local builder = variants[variant]
  if not builder then
    return
  end

  local opts = builder()
  vim.opt.background = variant == "light" and "light" or "dark"
  require("tokyonight").setup(opts)
  vim.cmd.colorscheme("tokyonight")
  vim.g.theme_variant = variant
  M.current = variant
end

function M.setup()
  M.current = vim.g.theme_variant or "light"
  apply(M.current)

  vim.api.nvim_create_user_command("ToggleTheme", function()
    local next_variant = M.current == "light" and "dark" or "light"
    apply(next_variant)
    vim.notify(string.format("Switched to %s theme", next_variant), vim.log.levels.INFO)
  end, { desc = "Toggle between light and dark themes" })
end

function M.set(variant)
  apply(variant)
end

function M.toggle()
  local next_variant = M.current == "light" and "dark" or "light"
  apply(next_variant)
end

return M
