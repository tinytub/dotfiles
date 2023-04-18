local present, b = pcall(require, "bqf")

if not present then
  return
end

b.setup({
  --  auto_enable = true,
  auto_resize_height = false,
  func_map = {
    tab = 'st',
    split = 'sv',
    vsplit = 'sg',

    stoggleup = 'K',
    stoggledown = 'J',
    stogglevm = '<Space>',

    ptoggleitem = 'p',
    ptoggleauto = 'P',
    ptogglemode = 'zp',

    pscrollup = '<C-b>',
    pscrolldown = '<C-f>',

    prevfile = 'gk',
    nextfile = 'gj',

    prevhist = '<S-Tab>',
    nexthist = '<Tab>',
  },
  preview = {
    auto_preview = true,
    -- win_height = 12,
    -- win_vheight = 12,
    -- delay_syntax = 80,
    -- border_chars = { '┃', '┃', '━', '━', '┏', '┓', '┗', '┛', '█' },
    -- should_preview_cb = function(bufnr, qwinid)
    --   local ret = true
    --   local bufname = vim.api.nvim_buf_get_name(bufnr)
    --   local fsize = vim.fn.getfsize(bufname)
    --   if fsize > 100 * 1024 then
    --     -- skip file size greater than 100k
    --     ret = false
    --   elseif bufname:match('^fugitive://') then
    --     -- skip fugitive buffer
    --     ret = false
    --   end
    --   return ret
    -- end,
    should_preview_cb = function(bufnr)
      -- file size greater than 100kb can't be previewed automatically
      local filename = vim.api.nvim_buf_get_name(bufnr)
      local fsize = vim.fn.getfsize(filename)
      if fsize > 100 * 1024 then
        return false
      end
      return true
    end,
  },
})
