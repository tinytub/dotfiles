local config = {}

function config.nvim_lsp()
  require('modules.completion.lspconfig')
end

function config.lspsaga()
  require'lspsaga'.init_lsp_saga({
    finder_action_keys = {
      open = 'o', vsplit = 's',split = 'i',quit = '<esc>',scroll_down = '<C-f>', scroll_up = '<C-b>' -- quit can be a table
    },
    use_saga_diagnostic_sign = false,
    error_sign = '',
    warn_sign = '',
    hint_sign = '',
    infor_sign = '',
    max_preview_lines = 45,
 	code_action_keys = {
 		quit = '<esc>',
 		exec = '<cr>'
 	},
  })
    -- body
end

function config.nvim_compe()
  require'compe'.setup {
    enabled = true;
    autocomplete = true;
    throttle_time = 80;
    debug = false;
    min_length = 2;
    preselect = 'always';
    allow_prefix_unmatch = false;
    source = {
      path = true;
      buffer = {kind = "﬘" , true},
      calc = true;
      vsnip = {kind = "﬌"}, --replace to what sign you prefer
      nvim_lsp = true;
      nvim_lua = false;
      spell = true;
      tags = false;
      snippets_nvim = false;
      --treesitter = true;
    };
  }
end

function config.vim_vsnip()
  vim.g.vsnip_snippet_dir = os.getenv('HOME') .. '/.config/nvim/snippets'
end

function config.telescope()
  if not packer_plugins['plenary.nvim'].loaded then
    vim.cmd [[packadd plenary.nvim]]
    vim.cmd [[packadd popup.nvim]]
    vim.cmd [[packadd telescope-fzy-native.nvim]]
  end

  local actions = require('telescope.actions')
  require('telescope').setup {
    defaults = {
--      prompt_prefix = '🔭 ',
      prompt_prefix = ' ',
      prompt_position = 'top',
      selection_caret = " ",
      sorting_strategy = 'ascending',
      results_width = 0.6,
      shorten_path = true,
      layout_defaults = {
          horizontal = {
              mirror = false,
              preview_width = 0.5
          },
          vertical = {
              mirror = false
          }
      },
      color_devicons = true,
      set_env = {['COLORTERM'] = 'truecolor'}, -- default = nil,
      file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
      grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
      vimgrep_arguments = {'rg', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case'},
      qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
    },
    mappings = {
      i = {
        ["<TAB>"] = actions.toggle_selection + actions.move_selection_next,
        ["<S-TAB>"] = actions.toggle_selection + actions.move_selection_previous,
        ["<C-j>"]  = actions.move_selection_next,
        ["<C-k>"]  = actions.move_selection_previous,
        ["<C-c>"]  = actions.close,
        ["<Down>"] = false,
        ["<Up>"]   = false,
        ["<C-p>"] = false,
        ["<C-n>"] = false,
      },
      n = {
        ["<Esc>"]  = actions.close,
        ["<CR>"]   = actions.select_default + actions.center,
        ["<C-s>"]  = actions.select_horizontal,
        ["<C-v>"]  = actions.select_vertical,
        ["j"]      = actions.move_selection_next,
        ["k"]      = actions.move_selection_previous,
        ["<Down>"] = false,
        ["<Up>"]   = false,
        ["<C-u>"]  = actions.preview_scrolling_up,
        ["<C-d>"]  = actions.preview_scrolling_down,
      }
    },
    file_ignore_patterns = {
      '.git/*',
      'node_modules/*',
      'bower_components/*',
      '.svn/*',
      '.hg/*',
      'CVS/*',
      '.next/*',
      '.docz/*',
      '.DS_Store'
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        }
    }
  --  Mappings	    Action
  --  <C-n>/<Down>	Next item
  --  <C-p>/<Up>	  Previous item
  --  j/k	          Next/previous (in normal mode)
  --  <CR>	        Confirm selection
  --  <C-x>	        go to file selection as a split
  --  <C-v>	        go to file selection as a vsplit
  --  <C-t>	        go to a file in a new tab
  --  <C-u>	        scroll up in preview window
  --  <C-d>	        scroll down in preview window
  --  <C-c>	        close telescope
  --  <Esc>	        close telescope (in normal mode)
  }
  require('telescope').load_extension('fzy_native')
  require'telescope'.load_extension('dotfiles')
  --require'telescope'.load_extension('gosource')
end

function config.vim_sonictemplate()
  vim.g.sonictemplate_postfix_key = '<C-,>'
  vim.g.sonictemplate_vim_template_dir = os.getenv("HOME").. '/.config/nvim/template'
end

--function config.smart_input()
--  require('smartinput').setup {
--    ['go'] = { ';',':=',';' }
--  }
--end

function config.emmet()
  vim.g.user_emmet_complete_tag = 0
  vim.g.user_emmet_install_global = 0
  vim.g.user_emmet_install_command = 0
  vim.g.user_emmet_mode = 'i'
end

return config
