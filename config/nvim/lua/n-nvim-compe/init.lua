local M = {}

M.config = function()
    require'compe'.setup {
      enabled = true;
      autocomplete = true;
      throttle_time = 80;
      debug = false;
      min_length = 2;
      preselect = "always";
      allow_prefix_unmatch = false;
      source = {
        buffer = {kind = "﬘" , true};
        vsnip = {kind = "﬌"}; --replace to what sign you prefer
        nvim_lsp = true;
        nvim_lua = true;
        --path = true;
        --calc = true;
        --ultisnips = true;
        --treesitter = true;
      };
      -- speeden up compe
    }
    local vim = vim
    vim.g.loaded_compe_calc = 0
    vim.g.loaded_compe_emoji = 0

    vim.g.loaded_compe_luasnip = 0
    vim.g.loaded_compe_nvim_lua = 0

    vim.g.loaded_compe_path = 0
    vim.g.loaded_compe_spell = 0
    vim.g.loaded_compe_tags = 0
    vim.g.loaded_compe_treesitter = 0

    vim.g.loaded_compe_snippets_nvim = 0

    vim.g.loaded_compe_ultisnips = 0
    vim.g.loaded_compe_vim_lsc = 0
    vim.g.loaded_compe_vim_lsp = 0
    vim.g.loaded_compe_omni = 0

    -- 
    -- 
    -- 
    -- 
    -- 
    -- 
    -- 
    -- 
    -- 
    -- 
    -- 
    -- 
    -- 
    -- 
    -- 
    -- 
    -- ﬘
    -- 
    -- 
    -- 
    -- m
    -- 
    -- 
    -- 
    -- 

    -- local t = function(str)
    --     return vim.api.nvim_replace_termcodes(str, true, true, true)
    -- end

    -- local check_back_space = function()
    --     local col = vim.fn.col('.') - 1
    --     if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
    --         return true
    --     else
    --         return false
    --     end
    -- end

    -- -- Use (s-)tab to:
    -- --- move to prev/next item in completion menuone
    -- --- jump to prev/next snippet's placeholder
    -- _G.tab_complete = function()
    --     if vim.fn.pumvisible() == 1 then
    --         return t "<C-n>"
    --     elseif vim.fn.call("vsnip#available", {1}) == 1 then
    --         return t "<Plug>(vsnip-expand-or-jump)"
    --     elseif check_back_space() then
    --         return t "<Tab>"
    --     else
    --         return vim.fn['compe#complete']()
    --     end
    -- end
    -- _G.s_tab_complete = function()
    --     if vim.fn.pumvisible() == 1 then
    --         return t "<C-p>"
    --     elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
    --         return t "<Plug>(vsnip-jump-prev)"
    --     else
    --         return t "<S-Tab>"
    --     end
    -- end

    -- vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
    -- vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
    -- vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
    -- vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

    local t = function(str)
      return vim.api.nvim_replace_termcodes(str, true, true, true)
    end

    local check_back_space = function()
        local col = vim.fn.col('.') - 1
        if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
            return true
        else
            return false
        end
    end

    -- Use (s-)tab to:
    --- move to prev/next item in completion menuone
    --- jump to prev/next snippet's placeholder
    _G.tab_complete = function()
      if vim.fn.pumvisible() == 1 then
        return t "<C-n>"
      elseif vim.fn.call("vsnip#available", {1}) == 1 then
        return t "<Plug>(vsnip-expand-or-jump)"
      elseif check_back_space() then
        return t "<Tab>"
      else
        return vim.fn['compe#complete']()
      end
    end
    _G.s_tab_complete = function()
      if vim.fn.pumvisible() == 1 then
        return t "<C-p>"
      elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
        return t "<Plug>(vsnip-jump-prev)"
      else
        return t "<S-Tab>"
      end
    end

    --- move to prev/next item in completion menuone
    --- jump to prev/next snippet's placeholder
    _G.tab_complete = function()
      if vim.fn.pumvisible() == 1 then
        return t "<C-n>"
      elseif vim.fn.call("vsnip#available", {1}) == 1 then
        return t "<Plug>(vsnip-expand-or-jump)"
      elseif check_back_space() then
        return t "<Tab>"
      else
        return vim.fn['compe#complete']()
      end
    end

    _G.s_tab_complete = function()
      if vim.fn.pumvisible() == 1 then
        return t "<C-p>"
      elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
        return t "<Plug>(vsnip-jump-prev)"
      else
        return t "<S-Tab>"
      end
    end

    _G.enhance_jk_move = function(key)
      --if packer_plugins['accelerated-jk'] and not packer_plugins['accelerated-jk'].loaded then
      --  vim.cmd [[packadd accelerated-jk]]
      --end
      local map = key == 'j' and '<Plug>(accelerated_jk_gj)' or '<Plug>(accelerated_jk_gk)'
      return t(map)
    end

    --_G.enhance_ft_move = function(key)
    --  if not packer_plugins['vim-eft'].loaded then
    --    vim.cmd [[packadd vim-eft]]
    --  end
    --  local map = {
    --    f = '<Plug>(eft-f)',
    --    F = '<Plug>(eft-F)',
    --    [';'] = '<Plug>(eft-repeat)'
    --  }
    --  return t(map[key])
    --end

    -- with autopairs configurations --
    function _G.completions()
        local npairs = require("nvim-autopairs")
        if vim.fn.pumvisible() == 1 then
            if vim.fn.complete_info()["selected"] ~= -1 then
                return vim.fn["compe#confirm"]("<CR>")
            end
        end
        return npairs.check_break_line_char()
    end
    -- skip it, if you use another global object
    _G.MUtils= {}

    vim.g.completion_confirm_key = ""
    MUtils.completion_confirm=function()
      local npairs = require('nvim-autopairs')
      if vim.fn.pumvisible() ~= 0  then
        if vim.fn.complete_info()["selected"] ~= -1 then
          return vim.fn["compe#confirm"](npairs.esc("<cr>"))
        else
          return npairs.esc("<cr>")
        end
      else
        return npairs.autopairs_cr()
      end
    end

    vim.cmd('inoremap <silent><expr> <C-Space> compe#complete()')
    vim.cmd("inoremap <silent><expr> <CR>      compe#confirm('<CR>')")
    vim.cmd("inoremap <silent><expr> <C-e>     compe#close('<C-e>')")
    vim.cmd("inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })")
    vim.cmd("inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })")
end

return M
