local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require('telescope.actions')
--local trouble = require("trouble.providers.telescope")
-- Global remapping
------------------------------
-- '--color=never',
telescope.setup {
    defaults = {
        find_command = {'rg', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case'},
        ---- prompt_prefix = " ",
        prompt_prefix = " ",
        selection_caret = " ",
        entry_prefix = "  ",
        initial_mode = "insert",
        -- initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "descending",
        layout_strategy = "horizontal",
        file_sorter = require'telescope.sorters'.get_fzy_sorter,
        file_ignore_patterns = {},
        generic_sorter = require'telescope.sorters'.get_generic_fuzzy_sorter,
        --path_display = "shorten",
        path_display = function(opts, path)
          local tail = require("telescope.utils").path_tail(path)
          return string.format("%s (%s)", tail, path)
        end,
        winblend = 0,
        border = {},
        borderchars = {'─', '│', '─', '│', '╭', '╮', '╯', '╰'},
        color_devicons = true,
        use_less = true,
        set_env = {['COLORTERM'] = 'truecolor'}, -- default = nil,
        file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
        grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
        qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

        layout_config = {
            width = 0.75,
            preview_cutoff = 120,
            horizontal = {mirror = false},
            vertical = {mirror = false}
        },

        ---- Developer configurations: Not meant for general override
        buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker,
        mappings = {
            i = {
                ["<C-c>"] = actions.close,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                -- To disable a keymap, put [map] = false
                -- So, to not map "<C-n>", just put
                -- ["<c-x>"] = false,
                -- ["<esc>"] = actions.close,

                -- Otherwise, just set the mapping to the function that you want it to be.
                -- ["<C-i>"] = actions.select_horizontal,

                -- Add up multiple actions
                ["<CR>"] = actions.select_default + actions.center

                -- You can perform as many actions in a row as you like
                -- ["<CR>"] = actions.select_default + actions.center + my_cool_custom_action,
            },
            n = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist
                -- ["<C-i>"] = my_cool_custom_action,
            }
        }
    },
    extensions = {fzy_native = {override_generic_sorter = false, override_file_sorter = true}}
}
-- load the term_picker extension
require("telescope").load_extension "terms"
--if
--    not pcall(
--        function()
--            telescope.load_extension("fzf")
--            telescope.load_extension("media_files")
--        end
--    )
-- then
--    -- This should only trigger when in need of PackerSync, so better do it
--    print("After completion of PackerSync, restart neovim.")
--    -- Trigger packer compile on PackerComplete, so it properly waits for PackerSync
--    vim.cmd 'autocmd User PackerComplete ++once lua require("packer").compile()'
--    require("packer").sync("telescope-fzf-native.nvim", "telescope-media-files.nvim")
--end
--require'telescope'.load_extension('project')
