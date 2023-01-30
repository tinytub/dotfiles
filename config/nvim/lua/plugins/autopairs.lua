local cmp = require("cmp")
local autopairs = require("nvim-autopairs")

-- autopairs.setup()

autopairs.setup({
  fast_wrap = {},
  disable_filetype = { "TelescopePrompt", "vim" },

  check_ts = true,
  --autopairs = {enable = true},
  --enable_check_bracket_line = false,
  --html_break_line_filetype = {'html', 'vue', 'typescriptreact', 'svelte', 'javascriptreact'},
})

-- Customise existing rules
-- local parens = npairs.get_rule('[')
-- parens.not_filetypes = { 'go'} -- no autopair for slices in Go

-- Add custom rules
local Rule = require('nvim-autopairs.rule')
local cond = require('nvim-autopairs.conds')
autopairs.add_rules({
  Rule('"""', '"""', { "scala", "java", "python" }), -- triple quoted strings
  Rule(':', '=', { "golang" })
      :with_pair(cond.not_inside_quote())
      :with_pair(cond.not_before_text('"'))
      :set_end_pair_length(0), -- assignment with type inference
})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
