return {
  "thiagochirana/show-whitespaces",
  config = function()
    require("whitespaces").setup()
    require("whitespaces").set_mode("all") -- modo inicial
  end,
}
