local cmd = vim.cmd

local function map(mode, lhs, rhs, opts)
   local options = { noremap = true, silent = true }
   if opts then
      options = vim.tbl_extend("force", options, opts)
   end
   vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local M = {}
local opt = {}


M.misc = function()

    local function non_config_mappings()
      -- Don't copy the replaced text after pasting in visual mode
        map("v", "p", '"_dP')

        map('n', '<C-h>', '<C-w>h', opt)
        map('n', '<C-j>', '<C-w>j', opt)
        map('n', '<C-k>', '<C-w>k', opt)
        map('n', '<C-l>', '<C-w>l', opt)
        
        -- Insert Mode 移动光标
        map('i', '<C-h>', '<Left>', opt)
        map('i', '<C-l>', '<Right>', opt)
        map('i', '<C-j>', '<Down>', opt)
        map('i', '<C-k>', '<Up>', opt)
        map('i', '<C-s>', '<Esc>:w<CR>', opt)
        
        -- command line Mode 移动光标
        map('c', '<C-h>', '<Left>', opt)
        map('c', '<C-l>', '<Right>', opt)
        map('c', '<C-j>', '<Down>', opt)
        map('c', '<C-k>', '<Up>', opt)
        map('c', '<C-t>', '[[<C-R>=expand("%:p:h") . "/" <CR>]]', opt)
        
        -- use ESC to turn off search highlighting
        map("n", "<Esc>", ":noh<CR>", opt)

        -- TODO fix this
        -- resize with arrows
        map('n', '<C-Up>', ':resize -2<CR>', {silent = true})
        map('n', '<C-Down>', ':resize +2<CR>', {silent = true})
        map('n', '<M-[>', ':vertical resize -2<CR>', {silent = true})
        map('n', '<M-]>', ':vertical resize +2<CR>', {silent = true})
        
        -- better indenting
        map('v', '<', '<gv', {noremap = true, silent = true})
        map('v', '>', '>gv', {noremap = true, silent = true})
        
        -- I hate escape
        map('i', 'jk', '<ESC>', {noremap = true, silent = true})
        map('i', 'kj', '<ESC>', {noremap = true, silent = true})
        map('i', 'jj', '<ESC>', {noremap = true, silent = true})
        
        -- Move selected line / block of text in visual mode
        map('x', 'K', ':move \'<-2<CR>gv-gv', {noremap = true, silent = true})
        map('x', 'J', ':move \'>+1<CR>gv-gv', {noremap = true, silent = true})
        
        -- Better nav for omnicomplete
        vim.cmd('inoremap <expr> <c-j> (\"\\<C-n>\")')
        vim.cmd('inoremap <expr> <c-k> (\"\\<C-p>\")')

        -- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
        -- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
        -- empty mode is same as using :map
        -- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
        map("", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
        map("", "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })
        map("", "<Down>", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
        map("", "<Up>", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })

        -- use ESC to turn off search highlighting
        map("n", "<Esc>", ":noh <CR>")
        
        -- fix to get netrw's gx command to work correctly
        --vim.api.nvim_set_keymap('n', 'gx', ":call netrw#BrowseX(expand((exists('g:netrw_gx')? g:netrw_gx : '<cfile>')),netrw#CheckIfRemote())<cr>", {noremap = true, silent = true})

        vim.cmd('vnoremap p "0p')
        vim.cmd('vnoremap P "0P')

        -- Toggle the QuickFix window
        map('', '<C-q>', ':call QuickFixToggle()<CR>', {noremap = true, silent = true})
        
        --map('n', '<C-x>', ':bdelete<CR>', {noremap = true, silent = true})
        map('n', '<C-x>', ':lua require(\'core.utils\').close_buffer() <CR>', {noremap = true, silent = true})
        
        map("i", "<C-Space>", "compe#complete()", { noremap = true, silent = true, expr = true })
        --vim.api.nvim_set_keymap("i", "<CR>", "compe#confirm('<CR>')", { noremap = true, silent = true, expr = true })
        map("i", "<C-e>", "compe#close('<C-e>')", { noremap = true, silent = true, expr = true })
        map("i", "<C-f>", "compe#scroll({ 'delta': +4 })", { noremap = true, silent = true, expr = true })
        map("i", "<C-d>", "compe#scroll({ 'delta': -4 })", { noremap = true, silent = true, expr = true })
    end

    local function required_mappings()
        -- Add Packer commands because we are not loading it at startup
        cmd "silent! command PackerClean lua require 'pluginList' require('packer').clean()"
        cmd "silent! command PackerCompile lua require 'pluginList' require('packer').compile()"
        cmd "silent! command PackerInstall lua require 'pluginList' require('packer').install()"
        cmd "silent! command PackerStatus lua require 'pluginList' require('packer').status()"
        cmd "silent! command PackerSync lua require 'pluginList' require('packer').sync()"
        cmd "silent! command PackerUpdate lua require 'pluginList' require('packer').update()"
    end

    non_config_mappings()
    required_mappings()
end

-- terminals
--local function terms()
M.terms = function()
   -- get out of terminal mode
   map("t", "jk", "<C-\\><C-n>", opt)
   -- hide a term from within terminal mode
   map("t", "JK", "<C-\\><C-n> :lua require('utils').close_buffer() <CR>", opt)
  -- pick a hidden term 
   map("n", "<leader>W", ":Telescope terms <CR>", opt)

   -- Open terminals
   -- TODO this opens on top of an existing vert/hori term, fixme
   --map("n", "<leader>w", ":execute 'terminal' | let b:term_type = 'wind' | startinsert <CR>", opt)
   --map("n", "<leader>v", ":execute 'vnew +terminal' | let b:term_type = 'vert' | startinsert <CR>", opt)
   map("n", "<leader>w", ":execute 15 .. 'new +terminal' | let b:term_type = 'hori' | startinsert <CR>", opt)
end

--M.misc()
--M.terms()
return M
