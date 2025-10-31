local ls = require("luasnip")
local s = ls.snippet
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node

return {
  s(
    {
      trig = "<%",
      name = "ERB code block",
      dscr = "Cria um bloco ERB <% %> para lógica Ruby.",
      wordTrig = false,
    },
    fmt("<% {} %>", { i(1) })
  ),
  s(
    {
      trig = "<%=",
      name = "ERB output block",
      dscr = "Renderiza o resultado de uma expressão Ruby.",
      wordTrig = false,
    },
    fmt("<%= {} %>", { i(1) })
  ),
}
