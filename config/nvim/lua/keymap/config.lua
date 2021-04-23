local function check_back_space()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
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
  if packer_plugins['accelerated-jk'] and not packer_plugins['accelerated-jk'].loaded then
    vim.cmd [[packadd accelerated-jk]]
  end
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

_G.enhance_nice_block = function (key)
  if not packer_plugins['vim-niceblock'].loaded then
    vim.cmd [[packadd vim-niceblock]]
  end
  local map = {
    I = '<Plug>(niceblock-I)',
    ['gI'] = '<Plug>(niceblock-gI)',
    A = '<Plug>(niceblock-A)'
  }
  return t(map[key])
end

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
_G.MUtils = {}
-- TEST
vim.g.completion_confirm_key = ""
MUtils.completion_confirm = function()
    local npairs = require('nvim-autopairs')
    if vim.fn.pumvisible() ~= 0 then
        if vim.fn.complete_info()["selected"] ~= -1 then
            vim.fn["compe#confirm"]()
            -- return npairs.esc("<c-y>")
            return npairs.esc("")
        else
            vim.defer_fn(function()
                vim.fn["compe#confirm"]("<cr>")
            end, 20)
            return npairs.esc("<c-n>")
        end
    else
        return npairs.check_break_line_char()
    end
end
-- TEST
MUtils.completion_confirm = function()
    local npairs = require('nvim-autopairs')
    --if vim.fn.pumvisible() ~= 0 then
    --    if vim.fn.complete_info()["selected"] ~= -1 then
    --        vim.fn["compe#confirm"]()
    --        return npairs.esc("")
    if vim.fn.pumvisible() == 1 then
        if vim.fn.complete_info()["selected"] ~= -1 then
            return vim.fn["compe#confirm"](npairs.esc("<CR>"))
        else
            vim.api.nvim_select_popupmenu_item(0, false, false, {})
            vim.fn["compe#confirm"]()
            return npairs.esc("<c-n>")
        end
    else
        return npairs.check_break_line_char()
    end
end
MUtils.tab = function()
    local npairs = require('nvim-autopairs')
    if vim.fn.pumvisible() ~= 0 then
        return npairs.esc("<C-n>")
    else
        if vim.fn["vsnip#available"](1) ~= 0 then
            vim.fn.feedkeys(string.format('%c%c%c(vsnip-expand-or-jump)', 0x80, 253, 83))
            return npairs.esc("")
        else
            return npairs.esc("<Tab>")
        end
    end
end
MUtils.s_tab = function()
    local npairs = require('nvim-autopairs')
    if vim.fn.pumvisible() ~= 0 then
        return npairs.esc("<C-p>")
    else
        if vim.fn["vsnip#jumpable"](-1) ~= 0 then
            vim.fn.feedkeys(string.format('%c%c%c(vsnip-jump-prev)', 0x80, 253, 83))
            return npairs.esc("")
        else
            return npairs.esc("<C-h>")
        end
    end
end
-- Autocompletion and snippets
--    vim.api.nvim_set_keymap('i', '<CR>', 'v:lua.MUtils.completion_confirm()', {expr = true, noremap = true})
--    -- imap("<CR>", "v:lua.MUtils.completion_confirm()", {expr = true, noremap = true})
--    imap("<Tab>", "v:lua.MUtils.tab()", {expr = true, noremap = true})
--    imap("<S-Tab>", "v:lua.MUtils.s_tab()", {expr = true, noremap = true})
-- with autopairs configurations done --


