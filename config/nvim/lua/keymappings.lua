vim.api.nvim_set_keymap('n', '-', ':RnvimrToggle<CR>', {noremap = true, silent = true})

-- better window movement
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', {silent = true})
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', {silent = true})
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', {silent = true})
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', {silent = true})

-- Insert Mode 移动光标
vim.api.nvim_set_keymap('i', '<C-h>', '<Left>', {silent = true, noremap = true})
vim.api.nvim_set_keymap('i', '<C-l>', '<Right>', {silent = true, noremap = true})
vim.api.nvim_set_keymap('i', '<C-j>', '<Down>', {silent = true, noremap = true})
vim.api.nvim_set_keymap('i', '<C-k>', '<Up>', {silent = true, noremap = true})
vim.api.nvim_set_keymap('i', '<C-s>', '<Esc>:w<CR>', {silent = true, noremap = true})

-- command line Mode 移动光标
vim.api.nvim_set_keymap('c', '<C-h>', '<Left>', {silent = true, noremap = true})
vim.api.nvim_set_keymap('c', '<C-l>', '<Right>', {silent = true, noremap = true})
vim.api.nvim_set_keymap('c', '<C-j>', '<Down>', {silent = true, noremap = true})
vim.api.nvim_set_keymap('c', '<C-k>', '<Up>', {silent = true, noremap = true})
vim.api.nvim_set_keymap('c', '<C-t>', '[[<C-R>=expand("%:p:h") . "/" <CR>]]', {silent = true, noremap = true})


--  -- Insert
--    ["i|<C-w>"]      = map_cmd('<C-[>diwa'):with_noremap(),
----    ["i|<C-h>"]      = map_cmd('<BS>'):with_noremap(),
--    ["i|<C-d>"]      = map_cmd('<Del>'):with_noremap(),
--    ["i|<C-u>"]      = map_cmd('<C-G>u<C-U>'):with_noremap(),
--    ["i|<C-b>"]      = map_cmd('<Left>'):with_noremap(),
--    ["i|<C-f>"]      = map_cmd('<Right>'):with_noremap(),
--    ["i|<C-a>"]      = map_cmd('<ESC>^i'):with_noremap(),
--    --["i|<C-j>"]      = map_cmd('<Esc>o'):with_noremap(),
--    --["i|<C-k>"]      = map_cmd('<Esc>O'):with_noremap(),
--    -- Insert Mode 移动光标
--    ["i|<C-j>"]      = map_cmd('<Down>'):with_noremap(),
--    ["i|<C-k>"]      = map_cmd('<Up>'):with_noremap(),
--    ["i|<C-h>"]      = map_cmd('<Left>'):with_noremap(),
--    ["i|<C-l>"]      = map_cmd('<Right>'):with_noremap(),
--    ["i|<C-s>"]      = map_cmd('<Esc>:w<CR>'),
--    ["i|<C-q>"]      = map_cmd('<Esc>:wq<CR>'),
--    ["i|<C-e>"]      = map_cmd([[pumvisible() ? "\<C-e>" : "\<End>"]]):with_noremap():with_expr(),
--  -- command line
--    ["c|<C-b>"]      = map_cmd('<Left>'):with_noremap(),
--    ["c|<C-f>"]      = map_cmd('<Right>'):with_noremap(),
--    ["c|<C-a>"]      = map_cmd('<Home>'):with_noremap(),
--    ["c|<C-e>"]      = map_cmd('<End>'):with_noremap(),
--    ["c|<C-d>"]      = map_cmd('<Del>'):with_noremap(),
--    --["c|<C-h>"]      = map_cmd('<BS>'):with_noremap(),
--    -- command line Mode 移动光标
--    ["c|<C-j>"]      = map_cmd('<Down>'):with_noremap(),
--    ["c|<C-k>"]      = map_cmd('<Up>'):with_noremap(),
--    ["c|<C-h>"]      = map_cmd('<Left>'):with_noremap(),
--    ["c|<C-l>"]      = map_cmd('<Right>'):with_noremap(),
--    ["c|<C-t>"]      = map_cmd([[<C-R>=expand("%:p:h") . "/" <CR>]]):with_noremap(),

-- TODO fix this
-- Terminal window navigation
--vim.cmd([[
--  tnoremap <C-h> <C-\><C-N><C-w>h
--  tnoremap <C-j> <C-\><C-N><C-w>j
--  tnoremap <C-k> <C-\><C-N><C-w>k
--  tnoremap <C-l> <C-\><C-N><C-w>l
--  inoremap <C-h> <C-\><C-N><C-w>h
--  inoremap <C-j> <C-\><C-N><C-w>j
--  inoremap <C-k> <C-\><C-N><C-w>k
--  inoremap <C-l> <C-\><C-N><C-w>l
--  tnoremap <Esc> <C-\><C-n>
--]])

-- TODO fix this
-- resize with arrows
vim.api.nvim_set_keymap('n', '<C-Up>', ':resize -2<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<C-Down>', ':resize +2<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<M-[>', ':vertical resize -2<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<M-]>', ':vertical resize +2<CR>', {silent = true})

-- better indenting
vim.api.nvim_set_keymap('v', '<', '<gv', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '>', '>gv', {noremap = true, silent = true})

-- I hate escape
vim.api.nvim_set_keymap('i', 'jk', '<ESC>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', 'kj', '<ESC>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', 'jj', '<ESC>', {noremap = true, silent = true})

-- Tab switch buffer
vim.api.nvim_set_keymap('n', '<TAB>', ':bnext<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<S-TAB>', ':bprevious<CR>', {noremap = true, silent = true})

-- Move selected line / block of text in visual mode
vim.api.nvim_set_keymap('x', 'K', ':move \'<-2<CR>gv-gv', {noremap = true, silent = true})
vim.api.nvim_set_keymap('x', 'J', ':move \'>+1<CR>gv-gv', {noremap = true, silent = true})

-- Better nav for omnicomplete
vim.cmd('inoremap <expr> <c-j> (\"\\<C-n>\")')
vim.cmd('inoremap <expr> <c-k> (\"\\<C-p>\")')

-- fix to get netrw's gx command to work correctly
--vim.api.nvim_set_keymap('n', 'gx', ":call netrw#BrowseX(expand((exists('g:netrw_gx')? g:netrw_gx : '<cfile>')),netrw#CheckIfRemote())<cr>", {noremap = true, silent = true})

vim.cmd('vnoremap p "0p')
vim.cmd('vnoremap P "0P')
-- vim.api.nvim_set_keymap('v', 'p', '"0p', {silent = true})
-- vim.api.nvim_set_keymap('v', 'P', '"0P', {silent = true})

-- vim.cmd('inoremap <expr> <TAB> (\"\\<C-n>\")')
-- vim.cmd('inoremap <expr> <S-TAB> (\"\\<C-p>\")')

-- vim.api.nvim_set_keymap('i', '<C-TAB>', 'compe#complete()', {noremap = true, silent = true, expr = true})

-- vim.cmd([[
-- map p <Plug>(miniyank-autoput)
-- map P <Plug>(miniyank-autoPut)
-- map <leader>n <Plug>(miniyank-cycle)
-- map <leader>N <Plug>(miniyank-cycleback)
-- ]])

-- Toggle the QuickFix window
vim.api.nvim_set_keymap('', '<C-q>', ':call QuickFixToggle()<CR>', {noremap = true, silent = true})

vim.g.smoothie_no_default_mappings = true
vim.api.nvim_set_keymap('n', '<C-f>', ':<C-U>call smoothie#forwards()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-b>', ':<C-U>call smoothie#backwards()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-d>', ':<C-U>call smoothie#downwards()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-u>', ':<C-U>call smoothie#upwards()<CR>', {noremap = true, silent = true})

vim.api.nvim_set_keymap('n', '<C-x>', ':bdelete<CR>', {noremap = true, silent = true})


vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
--vim.api.nvim_set_keymap("i", "<CR>", "v:lua.MUtils.completion_confirm()", {expr = true})
--vim.api.nvim_set_keymap('i' , '<CR>','v:lua.MUtils.completion_confirm()', {expr = true , noremap = true})
vim.api.nvim_set_keymap("i", "<CR>", "v:lua.completions()", {expr = true})
