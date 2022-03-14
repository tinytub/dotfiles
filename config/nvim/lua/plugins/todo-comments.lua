
local status_ok, todocomments = pcall(require, "todo-comments")

if not status_ok then
  return
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
    --TODO = { icon = " ", color = "info" },
    --HACK = { icon = " ", color = "warning" },
    --WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
    --PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
    --NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
    IDEA = { icon = " ", color = "#ffb86c" },
    TODO = { icon = " ", color = "#bd93f9" },
    HACK = { icon = " ", color = "#ffb86c" },
    WARN = { icon = " ", color = "#ff5555", alt = { "WARNING", "XXX" } },
    PERF = { icon = " ", color = "#8be9fd", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
    NOTE = { icon = " ", color = "#50fa7b", alt = { "INFO" } },
  },
  --colors = {
  --  error = { 'DiagnosticError', 'ErrorMsg', '#DC2626' },
  --  warning = { 'DiagnosticWarning', 'WarningMsg', '#FBBF24' },
  --  info = { 'DiagnosticInformation', '#2563EB' },
  --  hint = { 'DiagnosticHint', '#10B981' },
  --  default = { 'Identifier', '#7C3AED' },
  --},
}
