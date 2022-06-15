local M = {}

M.config = function()
    --    require("base46").load_highlight "git"
    local status_ok, gitsigns = pcall(require, "gitsigns")
    if not status_ok then
        return
    end
    -- colors from gruvbox8
    gitsigns.setup({
        numhl = false,
        --linehl = false,
        watch_gitdir = {
            interval = 100,
        },
        sign_priority = 5,
        --update_debounce = 200,
        --status_formatter = nil, -- Use default
        --use_decoration_api = false,
        --use_internal_diff = true,  -- If luajit is present
        --debug_mode = true,
        signs = {
            add = { hl = "DiffAdd", text = "▋", numhl = "GitSignsAddNr" },
            change = { hl = "DiffChange", text = "▋", numhl = "GitSignsChangeNr" },
            --    delete = { hl = "DiffDelete", text = "▋", numhl = "GitSignsDeleteNr" },
            delete = { hl = "DiffDelete", text = "", numhl = "GitSignsDeleteNr" },
            topdelete = { hl = "DiffDelete", text = "▔", numhl = "GitSignsDeleteNr" },
            changedelete = { hl = "DiffChangeDelete", text = "▎", numhl = "GitSignsChangeNr" },
        },
        --signs = {
        --    add = { hl = "DiffAdd", text = "│", numhl = "GitSignsAddNr" },
        --    change = { hl = "DiffChange", text = "│", numhl = "GitSignsChangeNr" },
        --    delete = { hl = "DiffDelete", text = "", numhl = "GitSignsDeleteNr" },
        --    topdelete = { hl = "DiffDelete", text = "‾", numhl = "GitSignsDeleteNr" },
        --    changedelete = { hl = "DiffChangeDelete", text = "~", numhl = "GitSignsChangeNr" },
        --},
        --signs = {
        --  add = {hl = 'GitSignsAdd', text = '▋', numhl = "GitSignsAddNr" },
        --  change = {hl = 'GitSignsChange',text= '▋', numhl = "GitSignsChangeNr" },
        --  delete = {hl= 'GitSignsDelete', text = '▋', numhl = "GitSignsDeleteNr" },
        --  topdelete = {hl ='GitSignsDeleteChange',text = '▔', numhl = "GitSignsDeleteNr" },
        --  changedelete = {hl = 'GitSignsChange', text = '▎', numhl = "GitSignsChangeNr" },
        --},
        --keymaps = {
        --   -- Default keymap options
        --   noremap = true,
        --   buffer = true,

        --   --['n ]g'] = { expr = true, "&diff ? ']g' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'"},
        --   --['n [g'] = { expr = true, "&diff ? '[g' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'"},

        --   ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
        --   ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
        --   ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
        --   ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
        --   ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line()<CR>',

        --   -- Text objects
        --   ['o ih'] = ':<C-U>lua require"gitsigns".text_object()<CR>',
        --   ['x ih'] = ':<C-U>lua require"gitsigns".text_object()<CR>'
        --}
    })
end

return M
