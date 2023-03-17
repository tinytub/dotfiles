local status_ok, todocomments = pcall(require, "todo-comments")

if not status_ok then
  return
end

-- HACK: #104 Invalid in command-line window
local hl = require("todo-comments.highlight")
local highlight_win = hl.highlight_win
hl.highlight_win = function(win, force)
  pcall(highlight_win, win, force)
end

todocomments.setup {
  signs = false,
  highlight = {
    keyword = "bg",
  },
  keywords = {
    FIX = {
      icon = " ", -- icon used for the sign, and in search results
      color = "error", -- can be a hex color, or a named color (see below)
      alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE', 'fix', 'fixme', 'bug' }, -- a set of other keywords that all map to this FIX keywords
      -- signs = false, -- configure signs for some keywords individually
    },
    IDEA = { icon = " ", color = "#ffb86c" },
    TODO = { icon = " ", color = "#bd93f9" },
    HACK = { icon = " ", color = "#ffb86c" },
    WARN = { icon = " ", color = "#ff5555", alt = { "WARNING", "XXX" } },
    PERF = { icon = " ", color = "#8be9fd", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
    NOTE = { icon = " ", color = "#50fa7b", alt = { "INFO" } },
  },
}
