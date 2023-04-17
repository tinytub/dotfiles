local telescope = require("telescope")

local actions = require('telescope.actions')
--local action_state = require("telescope.actions.state")
--local transform_mod = require('telescope.actions.mt').transform_mod

vim.g.theme_switcher_loaded = true
-- require("base46").load_highlight "telescope"
--local trouble = require("trouble.providers.telescope")
-- Global remapping
------------------------------
-- '--color=never',
telescope.setup {
  defaults = {
    find_command = { 'rg', "-L", '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case' },
    ---- prompt_prefix = " ",
    prompt_prefix = " ",
    selection_caret = "❯ ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    file_sorter = require 'telescope.sorters'.get_fzy_sorter,
    file_ignore_patterns = {
      "node_modules",
      --      "vendor",
    },
    generic_sorter = require 'telescope.sorters'.get_generic_fuzzy_sorter,
    --path_display = "shorten",
    --path_display = function(opts, path)
    --  local tail = require("telescope.utils").path_tail(path)
    --  return string.format("%s (%s)", tail, path)
    --end,

    path_display = { "truncate" },

    --path_display = {
    --  truncate = 1,
    --},
    winblend = 0,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    file_previewer = require 'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require 'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require 'telescope.previewers'.vim_buffer_qflist.new,

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
    mappings = {
      i = {
        ["<C-c>"] = actions.close,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<Tab>"] = actions.move_selection_previous,
        ["<S-Tab>"] = actions.move_selection_next,
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
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["q"] = require("telescope.actions").close,
        -- ["<C-i>"] = my_cool_custom_action,
      }
    },

    preview = {
      filesize_hook = function(filepath, bufnr, opts)
        local max_bytes = 10000
        local cmd = { "head", "-c", max_bytes, filepath }
        require('telescope.previewers.utils').job_maker(cmd, bufnr, opts)
      end
    }
  },
}

-- load the term_picker extension
require("telescope").load_extension "terms"
