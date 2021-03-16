local config = {}

function config.galaxyline()
  require('modules.ui.eviline')
end

function config.nvim_bufferline()
  require('bufferline').setup{
    options = {
      buffer_close_icon = "",
      modified_icon = "●",
      close_icon = "",
      left_trunc_marker = "",
      right_trunc_marker = "",
      max_name_length = 14,
      max_prefix_length = 13,
      tab_size = 18,
      enforce_regular_tabs = true,
      view = "multiwindow",
      show_buffer_close_icons = true,
      separator_style = "thin",
      mappings = true,
      always_show_bufferline = true
    },
    highlights = {
        background = {
            guifg = comment_fg,
            guibg = "#282c34"
        },
        fill = {
            guifg = comment_fg,
            guibg = "#282c34"
        },
        buffer_selected = {
            guifg = normal_fg,
            guibg = "#3A3E44",
            gui = "bold"
        },
        separator_visible = {
            guifg = "#282c34",
            guibg = "#282c34"
        },
        separator_selected = {
            guifg = "#282c34",
            guibg = "#282c34"
        },
        separator = {
            guifg = "#282c34",
            guibg = "#282c34"
        },
        indicator_selected = {
            guifg = "#282c34",
            guibg = "#282c34"
        },
        modified_selected = {
            guifg = string_fg,
            guibg = "#3A3E44"
        }
     }
  }
end

--function config.barbar()
--      vim.cmd("let bufferline = get(g:, "bufferline", {})")
--      vim.cmd("let bufferline.animation = v:false")
--      vim.cmd("let bufferline.closable = v:false")
--      vim.cmd("let bufferline.icon_close_tab_modified = ''")
--end

function config.dashboard()
  local home = os.getenv('HOME')
  vim.g.dashboard_footer_icon = '🐬 '
  vim.g.dashboard_preview_command = 'cat'
  vim.g.dashboard_preview_pipeline = 'lolcat'
  vim.g.dashboard_preview_file = home .. '/.config/nvim/static/neovim.cat'
  vim.g.dashboard_preview_file_height = 12
  vim.g.dashboard_preview_file_width = 80
  vim.g.dashboard_default_executive = 'telescope'
  vim.g.dashboard_custom_section = {
    last_session = {
      description = {'  Recently laset session                  SPC s l'},
      command =  'SessionLoad'},
    find_history = {
      description = {'  Recently opened files                   SPC f h'},
      command =  'DashboardFindHistory'},
    find_file  = {
      description = {'  Find  File                              SPC f f'},
      command = 'DashboardFindFile'},
    new_file = {
     description = {'  File Browser                            SPC f d'},
     command =  'Telescope file_browser'},
    find_word = {
     description = {'  Find  word                              SPC f w'},
     command = 'DashboardFindWord'},
    find_dotfiles = {
     description = {'  Open Personal dotfiles                  SPC f d'},
     command = 'Telescope dotfiles path=' .. home ..'/.dotfiles'},
    go_source = {
     description = {'  Find Go Source Code                     SPC f s'},
     command = 'Telescope gosource'},
  }
end

function config.nvim_tree()
  vim.g.nvim_tree_follow = 1
  vim.g.nvim_tree_hide_dotfiles = 1
  vim.g.nvim_tree_indent_markers = 1
  vim.g.nvim_tree_ignore = {'.git', 'node_modules', '.cache'}
  vim.g.nvim_tree_bindings = {
    ["l"] = ":lua require'nvim-tree'.on_keypress('edit')<CR>",
    ["s"] = ":lua require'nvim-tree'.on_keypress('vsplit')<CR>",
    ["i"] = ":lua require'nvim-tree'.on_keypress('split')<CR>",
  }
  vim.g.nvim_tree_icons = {
    default =  '',
    symlink =  '',
    git = {
     unstaged = "✚",
     staged =  "✚",
     unmerged =  "≠",
     renamed =  "≫",
     untracked = "★",
    },
  }
end

function config._gitsigns()
  if not packer_plugins['plenary.nvim'].loaded then
    vim.cmd [[packadd plenary.nvim]]
  end
  require('gitsigns').setup {
    signs = {
      add = {hl = 'GitGutterAdd', text = '▋'},
      change = {hl = 'GitGutterChange',text= '▋'},
      delete = {hl= 'GitGutterDelete', text = '▋'},
      topdelete = {hl ='GitGutterDeleteChange',text = '▔'},
      changedelete = {hl = 'GitGutterChange', text = '▎'},
    },
    keymaps = {
       -- Default keymap options
       noremap = true,
       buffer = true,

       ['n ]g'] = { expr = true, "&diff ? ']g' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'"},
       ['n [g'] = { expr = true, "&diff ? '[g' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'"},

       ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
       ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
       ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
       ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
       ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line()<CR>',

       -- Text objects
       ['o ih'] = ':<C-U>lua require"gitsigns".text_object()<CR>',
       ['x ih'] = ':<C-U>lua require"gitsigns".text_object()<CR>'
     },
  }
end

return config
