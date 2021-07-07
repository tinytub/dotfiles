local M = {}

M.config = function()
    local status_ok, gitsigns = pcall(require, "gitsigns")
    if not status_ok then
      return
    end
    -- colors from gruvbox8
    vim.cmd('autocmd ColorScheme * hi GitSignsAdd guifg=#b8bb26 guibg=NONE')
    vim.cmd('autocmd ColorScheme * hi GitSignsChange guifg=#8ec07c guibg=NONE')
    vim.cmd('autocmd ColorScheme * hi GitSignsDelete guifg=#fb4934 guibg=NONE')
    gitsigns.setup {
      numhl = false,
      linehl = false,
      watch_index = {
        interval = 1000
      },
      sign_priority = 6,
      update_debounce = 200,
      status_formatter = nil, -- Use default
      use_decoration_api = false,
      use_internal_diff = true,  -- If luajit is present
      --debug_mode = true,
      --signs = {
      --  add = {hl = 'GitSignsAdd', text = '▎'},
      --  change = {hl = 'GitSignsChange',text= '▎'},
      --  delete = {hl= 'GitSignsDelete', text = '契'},
      --  topdelete = {hl ='GitSignsDeleteChange',text = '▔'},
      --  changedelete = {hl = 'GitSignsChange', text = '▎'},
      --},
      signs = {
        add = {hl = 'GitSignsAdd', text = '▋'},
        change = {hl = 'GitSignsChange',text= '▋'},
        delete = {hl= 'GitSignsDelete', text = '▋'},
        topdelete = {hl ='GitSignsDeleteChange',text = '▔'},
        changedelete = {hl = 'GitSignsChange', text = '▎'},
      },
      keymaps = {
         -- Default keymap options
         noremap = true,
         buffer = true,
    
         --['n ]g'] = { expr = true, "&diff ? ']g' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'"},
         --['n [g'] = { expr = true, "&diff ? '[g' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'"},
    
         ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
         ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
         ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
         ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
         ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line()<CR>',
    
         -- Text objects
         ['o ih'] = ':<C-U>lua require"gitsigns".text_object()<CR>',
         ['x ih'] = ':<C-U>lua require"gitsigns".text_object()<CR>'
      }
    }
    
end

return M
