local M = {}

M.config = function()
  vim.g.matchup_matchparen_offscreen = { method = 'nil' } --popup and status will override statusline
end

return M
