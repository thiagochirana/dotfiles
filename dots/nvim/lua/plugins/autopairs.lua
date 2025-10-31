return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  opts = {
    check_ts = true,
    enable_afterquote = false,
  },
  config = function(_, opts)
    local autopairs = require("nvim-autopairs")
    local Rule = require("nvim-autopairs.rule")

    autopairs.setup(opts)

    -- Remove the default angle bracket rule so we can reintroduce it without ERB conflicts.
    autopairs.remove_rule("<")

    local function last_chars(line, col, count)
      local start_index = col - count
      if start_index < 1 then
        start_index = 1
      end
      return line:sub(start_index, col - 1)
    end

    local function has_double_percent(opts)
      local next_char = opts.next_char or ""
      return next_char:match("%%") ~= nil
    end

    autopairs.add_rules({
      -- Restore angle bracket pairing for other markup filetypes.
      Rule("<", ">", { "html", "xml", "javascriptreact", "typescriptreact", "svelte", "vue", "php" }),
      -- ERB control flow block.
      Rule("<%", " %>", "eruby")
        :with_pair(function(opts)
          return last_chars(opts.line, opts.col, 2) == "<%"
        end)
        :set_end_pair_length(3)
        :replace_endpair(function()
          return " %>"
        end)
        :with_move(has_double_percent)
        :use_key("%"),
      -- ERB output block.
      Rule("<%=", " %>", "eruby")
        :with_pair(function(opts)
          return last_chars(opts.line, opts.col, 3) == "<%="
        end)
        :set_end_pair_length(3)
        :replace_endpair(function()
          return " %>"
        end)
        :with_move(has_double_percent)
        :use_key("="),
    })

    local cmp_ok, cmp = pcall(require, "cmp")
    if cmp_ok then
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end
  end,
}
