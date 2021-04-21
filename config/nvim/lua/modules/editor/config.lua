local config = {}

function config.delimimate()
  vim.g.delimitMate_expand_cr = 0
  vim.g.delimitMate_expand_space = 1
  vim.g.delimitMate_smart_quotes = 1
  vim.g.delimitMate_expand_inside_quotes = 0
  vim.api.nvim_command('au FileType markdown let b:delimitMate_nesting_quotes = ["`"]')
end

function config.nvim_colorizer()
  require 'colorizer'.setup {
    css = { rgb_fn = true; };
    scss = { rgb_fn = true; };
    sass = { rgb_fn = true; };
    stylus = { rgb_fn = true; };
    vim = { names = true; };
    tmux = { names = false; };
    'javascript';
    'javascriptreact';
    'typescript';
    'typescriptreact';
    'lua';
    html = {
      mode = 'foreground';
    }
  }
end

function config.vim_cursorwod()
  vim.api.nvim_command('augroup user_plugin_cursorword')
  vim.api.nvim_command('autocmd!')
  vim.api.nvim_command('autocmd FileType NvimTree,lspsagafinder,dashboard,vista let b:cursorword = 0')
  vim.api.nvim_command('autocmd WinEnter * if &diff || &pvw | let b:cursorword = 0 | endif')
  vim.api.nvim_command('autocmd InsertEnter * let b:cursorword = 0')
  vim.api.nvim_command('autocmd InsertLeave * let b:cursorword = 1')
  vim.api.nvim_command('augroup END')
end

function config.autopairs()
    require('nvim-autopairs').setup({
      disable_filetype = { "TelescopePrompt", "NvimTree", "Vista" },
    })
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
    
    
    local function imap(lhs, rhs, opts)
        local options = {noremap = false}
        if opts then options = vim.tbl_extend('force', options, opts) end
        vim.api.nvim_set_keymap('i', lhs, rhs, options)
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
        if vim.fn.pumvisible() ~= 0 then
            if vim.fn.complete_info()["selected"] ~= -1 then
                vim.fn["compe#confirm"]()
                return npairs.esc("")
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
    vim.api.nvim_set_keymap('i', '<CR>', 'v:lua.MUtils.completion_confirm()', {expr = true, noremap = true})
    -- imap("<CR>", "v:lua.MUtils.completion_confirm()", {expr = true, noremap = true})
    imap("<Tab>", "v:lua.MUtils.tab()", {expr = true, noremap = true})
    imap("<S-Tab>", "v:lua.MUtils.s_tab()", {expr = true, noremap = true})
    -- with autopairs configurations done --
end


return config
