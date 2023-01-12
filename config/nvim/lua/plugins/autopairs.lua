local  cmp = require("cmp")
local  autopairs = require("nvim-autopairs")

  -- autopairs.setup()

autopairs.setup({
  fast_wrap = {},
  disable_filetype = { "TelescopePrompt", "vim" },
  --autopairs = {enable = true},
  --enable_check_bracket_line = false,
  --html_break_line_filetype = {'html', 'vue', 'typescriptreact', 'svelte', 'javascriptreact'},
})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())


