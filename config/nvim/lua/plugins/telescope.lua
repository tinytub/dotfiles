local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require('telescope.actions')

-- https://github.com/nvim-telescope/telescope.nvim/issues/223#issuecomment-810091610    don't show binaryfile
local previewers = require('telescope.previewers')
local Job = require('plenary.job')
local new_maker = function(filepath, bufnr, opts)
  filepath = vim.fn.expand(filepath)
  Job:new({
    command = 'file',
    args = { '--mime-type', '-b', filepath },
    on_exit = function(j)
      local mime_type = vim.split(j:result()[1], '/')[1]
      if mime_type == "text" then
        previewers.buffer_previewer_maker(filepath, bufnr, opts)
      else
        -- maybe we want to write something to the buffer here
        vim.schedule(function()
          vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { 'BINARY' })
        end)
      end
    end
  }):sync()
end


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
        selection_strategy = "reset",
        sorting_strategy = "descending",
        layout_strategy = "horizontal",
        file_sorter = require'telescope.sorters'.get_fzy_sorter,
        file_ignore_patterns = { "node_modules" },
        generic_sorter = require'telescope.sorters'.get_generic_fuzzy_sorter,
        --path_display = "shorten",
        --path_display = function(opts, path)
        --  local tail = require("telescope.utils").path_tail(path)
        --  return string.format("%s (%s)", tail, path)
        --end,
        path_display = { "truncate" },
        winblend = 0,
        border = {},
        borderchars = {'─', '│', '─', '│', '╭', '╮', '╯', '╰'},
        color_devicons = true,
        use_less = true,
        set_env = {['COLORTERM'] = 'truecolor'}, -- default = nil,
        file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
        grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
        qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

        --layout_config = {
        --    width = 0.75,
        --    preview_cutoff = 120,
        --    horizontal = {mirror = false},
        --    vertical = {mirror = false}
        --},
        layout_config = {
           horizontal = {
              prompt_position = "top",
              preview_width = 0.55,
              results_width = 0.8,
           },
           vertical = {
              mirror = false,
           },
           width = 0.87,
           height = 0.80,
           preview_cutoff = 120,
        },

        ---- Developer configurations: Not meant for general override
        -- buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker,
        buffer_previewer_maker = new_maker,
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
        },
        preview = {
            filesize_hook = function(filepath, bufnr, opts)
                local max_bytes = 10000
                local cmd = {"head", "-c", max_bytes, filepath}
                require('telescope.previewers.utils').job_maker(cmd, bufnr, opts)
            end
        }
    },
    --extensions = {fzy_native = {override_generic_sorter = false, override_file_sorter = true}}
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
