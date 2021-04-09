local config = {}

function config.galaxyline()
  require('modules.ui.eviline')
  -- stand alone setup devicons
  require "nvim-web-devicons".setup {
    override = {
        html = {
            icon = "",
            color = "#DE8C92",
            name = "html"
        },
        css = {
            icon = "",
            color = "#61afef",
            name = "css"
        },
        js = {
            icon = "",
            color = "#EBCB8B",
            name = "js"
        },
        png = {
            icon = " ",
            color = "#BD77DC",
            name = "png"
        },
        jpg = {
            icon = " ",
            color = "#BD77DC",
            name = "jpg"
        },
        jpeg = {
            icon = " ",
            color = "#BD77DC",
            name = "jpeg"
        },
        mp3 = {
            icon = "",
            color = "#C8CCD4",
            name = "mp3"
        },
        mp4 = {
            icon = "",
            color = "#C8CCD4",
            name = "mp4"
        },
        out = {
            icon = "",
            color = "#C8CCD4",
            name = "out"
        },
        toml = {
            icon = "",
            color = "#61afef",
            name = "toml"
        },
        lock = {
            icon = "",
            color = "#DE6B74",
            name = "lock"
        },
        zip = {
            icon = "",
            color = "#EBCB8B",
            name = "zip"
        },
        xz = {
            icon = "",
            color = "#EBCB8B",
            name = "xz"
        }
    }
  }
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
--    highlights = {
--        background = {
--            guifg = comment_fg,
--            guibg = "#282c34"
--        },
--        fill = {
--            guifg = comment_fg,
--            guibg = "#282c34"
--        },
--        buffer_selected = {
--            guifg = normal_fg,
--            guibg = "#3A3E44",
--            gui = "bold"
--        },
--        separator_visible = {
--            guifg = "#282c34",
--            guibg = "#282c34"
--        },
--        separator_selected = {
--            guifg = "#282c34",
--            guibg = "#282c34"
--        },
--        separator = {
--            guifg = "#282c34",
--            guibg = "#282c34"
--        },
--        indicator_selected = {
--            guifg = "#282c34",
--            guibg = "#282c34"
--        },
--        modified_selected = {
--            guifg = string_fg,
--            guibg = "#3A3E44"
--        }
--     }
  }
end

function config.barbar()
      --vim.cmd("let bufferline = get(g:, 'bufferline', {})")
      --vim.cmd("let bufferline.animation = v:false")
      --vim.cmd("let bufferline.closable = v:false")
      --vim.cmd("let bufferline.icon_close_tab_modified = '●'")
      --
      vim.cmd [[ let g:bufferline = {} ]]
      vim.cmd [[ let bufferline.icon_close_tab_modified = '✥' ]]
      vim.cmd [[ let bufferline.animation = v:false ]]
      vim.cmd [[ let bufferline.closeable = v:false ]]
      vim.cmd [[ let bufferline.clickable = v:false ]]
      vim.cmd [[ let bufferline.icon_close_tab = '' ]]
end

function config.dashboard()
  local home = os.getenv('HOME')
  --vim.g.dashboard_footer_icon = '🐬 '
  --vim.g.dashboard_preview_command = 'cat'
  --vim.g.dashboard_preview_pipeline = 'lolcat -F 0.3'
  --vim.g.dashboard_preview_file = home .. '/.config/nvim/static/neovim.cat'
  --vim.g.dashboard_preview_file_height = 12
  --vim.g.dashboard_preview_file_width = 80
  vim.g.dashboard_default_executive = 'telescope'
  vim.g.dashboard_custom_section = {
    last_session = {
      description = {'  Recently laset session                  Leader s l'},
      command =  'SessionLoad'},
    find_history = {
      description = {'  Recently opened files                   Leader f h'},
      command =  'DashboardFindHistory'},
    find_file  = {
      description = {'  Find  File                              Leader f f'},
      command = 'DashboardFindFile'},
    new_file = {
     description = {'  File Browser                            Leader f b'},
     command =  'Telescope file_browser'},
    find_word = {
     description = {'  Find  word                              Leader f w'},
     command = 'DashboardFindWord'},
    find_dotfiles = {
     description = {'  Open Personal dotfiles                  Leader f d'},
     command = 'Telescope dotfiles path=' .. home ..'/.dotfiles'},
    --go_source = {
    -- description = {'  Find Go Source Code                     Leader f s'},
    -- command = 'Telescope gosource'},
  }
end

function config.nvim_tree()
  vim.g.nvim_tree_follow = 1
  vim.g.nvim_tree_hide_dotfiles = 1
  vim.g.nvim_tree_indent_markers = 1
  vim.g.nvim_tree_quit_on_open = 1
  vim.g.nvim_tree_ignore = {'.git', 'node_modules', '.cache'}
  vim.g.nvim_tree_bindings = {
    ["l"] = ":lua require'nvim-tree'.on_keypress('edit')<CR>",
    ["s"] = ":lua require'nvim-tree'.on_keypress('vsplit')<CR>",
    ["i"] = ":lua require'nvim-tree'.on_keypress('split')<CR>",
    ["<CR>"]  = ":lua require'nvim-tree'.on_keypress('edit')<CR>",
    ["zh"]    = ":lua require'nvim-tree'.on_keypress('toggle_dotfiles')<CR>",
    ["<Tab>"] = ":lua require'nvim-tree'.on_keypress('preview')<CR>",
    ["cd"]    = ":lua require'nvim-tree'.on_keypress('cd')<CR>",
    ["a"]     = ":lua require'nvim-tree'.on_keypress('create')<CR>",
    ["rm"]    = ":lua require'nvim-tree'.on_keypress('remove')<CR>",
    ["rn"]    = ":lua require'nvim-tree'.on_keypress('rename')<CR>",
    ["dd"]    = ":lua require'nvim-tree'.on_keypress('cut')<CR>",
    ["yy"]    = ":lua require'nvim-tree'.on_keypress('copy')<CR>",
    ["p"]     = ":lua require'nvim-tree'.on_keypress('paste')<CR>",
    ["q"]     = ":lua require'nvim-tree'.on_keypress('close')<CR>"
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

function config.lspkind_nvim()
  require('lspkind').init()
--  require('lspkind').init({
--    with_text = false,
--    symbol_map = {
--      Text = '  ',
--      Method = '  ',
--      Function = '  ',
--      Constructor = '  ',
--      Variable = '[]',
--      Class = '  ',
--      Interface = ' 蘒',
--      Module = '  ',
--      Property = '  ',
--      Unit = ' 塞 ',
--      Value = '  ',
--      Enum = ' 練',
--      Keyword = '  ',
--      Snippet = '  ',
--      Color = '',
--      File = '',
--      Folder = ' ﱮ ',
--      EnumMember = '  ',
--      Constant = '  ',
--      Struct = '  '
--    },
--})
end

function config.gitsigns()

  -- colors from gruvbox8
  vim.cmd('autocmd ColorScheme * hi GitSignsAdd guifg=#b8bb26 guibg=none')
  vim.cmd('autocmd ColorScheme * hi GitSignsChange guifg=#8ec07c guibg=none')
  vim.cmd('autocmd ColorScheme * hi GitSignsDelete guifg=#fb4934 guibg=none')
  if not packer_plugins['plenary.nvim'].loaded then
    vim.cmd [[packadd plenary.nvim]]
  end
  require('gitsigns').setup {
    numhl = false,
    linehl = false,
    watch_index = {
      interval = 1000
    },
    sign_priority = 6,
    update_debounce = 200,
    status_formatter = nil, -- Use default
    use_decoration_api = true,
    use_internal_diff = true,  -- If luajit is present
    debug_mode = true,
    --signs = {
    --  add = {hl = 'GitSignsAdd', text = '▎'},
    --  change = {hl = 'GitSignsChange',text= '▎'},
    --  delete = {hl= 'GitSignsDelete', text = '契'},
    --  topdelete = {hl ='GitSignsDeleteChange',text = '▔'},
    --  changedelete = {hl = 'GitSignsChange', text = '▎'},
    --},
    signs = {
      add = {hl = 'GitSignsAdd', text = '▋'},
      change = {hl = 'GitSignsChange',text= '▋'},
      delete = {hl= 'GitSignsDelete', text = '▋'},
      topdelete = {hl ='GitSignsDeleteChange',text = '▔'},
      changedelete = {hl = 'GitSignsChange', text = '▎'},
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
