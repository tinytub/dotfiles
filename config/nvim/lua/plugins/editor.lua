return {

  {
    "karb94/neoscroll.nvim",
    enabled = true,
    --        event = "WinScrolled",
    config = function()
      require("neoscroll").setup()
    end,
    event = "VeryLazy",
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      {
        "s1n7ax/nvim-window-picker",
        --"tinytub/nvim-window-picker",
        version = "v2.*",
        opts = {
          --hint = "floating-big-letter",
          statusline_winbar_picker = {
            use_winbar = "smart",
          },
          filter_rules = {
            autoselect_one = true,
            include_current_win = false,
            bo = {
              filetype = { "neo-tree", "neo-tree-popup", "notify", "quickfix", "edgy", "noice" },
              buftype = { "terminal", "quickfix" },
            },
          },
          --         other_win_hl_color = "#e35e4f",
        },
        config = function(_, opts)
          require("window-picker").setup(opts)
        end,
      },
    },
    opts = {
      window = {
        mappings = {
          ["<c-x>"] = "split_with_window_picker",
          ["<c-v>"] = "vsplit_with_window_picker",
          ["l"] = "open_with_window_picker",
          ["<cr>"] = "open_drop",
        },
      },
      --document_symbols = {
      --  follow_cursor = true,
      --  renderers = {
      --    symbol = {
      --      { "indent", with_expanders = true },
      --      { "kind_icon", default = "?" },
      --      { "name", zindex = 10 },
      --      -- removed the kind text as its redundant with the icon
      --    },
      --  },
      --},
    },
    --config = function(_, opts)
    --  -- some from https://github.com/CKolkey/config/blob/master/nvim/lua/plugins/neo-tree.lua
    --  -- Enable a strong cursorline.
    --  local function set_cursorline()
    --    vim.wo.winhighlight = "CursorLine:WildMenu"
    --    vim.wo.cursorline = true
    --    vim.o.signcolumn = "auto"
    --  end

    --  -- Find previous neo-tree window and clear bright highlight selection.
    --  -- Don't hide cursorline though, so 'follow_current_file' works.
    --  local function reset_cursorline()
    --    local winid = vim.fn.win_getid(vim.fn.winnr("#"))
    --    vim.api.nvim_win_set_option(winid, "winhighlight", "")
    --  end
    --end,
  },
  {
    "vim-test/vim-test",
    event = "BufRead",
    config = function()
      vim.cmd([[
              function! ToggleTermStrategy(cmd) abort
                call luaeval("require('toggleterm').exec(_A[1], _A[2])", [a:cmd, 0])
              endfunction

              let g:test#custom_strategies = {'toggleterm': function('ToggleTermStrategy')}
            ]])

      vim.g["test#strategy"] = "toggleterm"
      --vim.g["test#strategy"] = "neovim"
      --vim.g["test#strategy"] = {
      --  nearest = "neovim",
      --  file = "neovim",
      --  suite = "neovim"
      --}
      vim.g["test#neovim#term_position"] = "vert"
      vim.g["test#preserve_screen"] = 1
      vim.g["test#go#runner"] = "gotest"
      vim.g["test#go#gotest#options"] = "-v --count=1"
      vim.g["test#echo_command"] = 1
    end,
    enabled = true,
  },

  -- Terminal
  {
    "akinsho/toggleterm.nvim",
    --commit = commit.toggleterm,

    optional = false,
    event = "BufWinEnter",
    opts = {
      -- size can be a number or function which is passed the current terminal
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = [[<c-\>]],
      hide_numbers = true, -- hide the number column in toggleterm buffers
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
      start_in_insert = true,
      insert_mappings = true, -- whether or not the open mapping applies in insert mode
      persist_size = false,
      direction = "horizontal", --'vertical' | 'horizontal' | 'window' | 'float'
      close_on_exit = true, -- close the terminal window when the process exits
      shell = vim.o.shell, -- change the default shell
      -- This field is only relevant if direction is set to 'float'
      float_opts = {
        -- The border key is *almost* the same as 'nvim_open_win'
        -- see :h nvim_open_win for details on borders however
        -- the 'curved' border is a custom border type
        -- not natively supported but implemented in this plugin.
        border = "rounded",
        --winblend = 0,
        --highlights = {
        --  border = "Normal",
        --  background = "Normal",
        --}
      },
      execs = {
        { "lazygit", "gg", "LazyGit" },
      },
    },
    --disable = not lvim.builtin.terminal.active,
  },
  -- Git
  {
    "tpope/vim-fugitive",
    event = "BufRead",
    cmd = {
      "Git",
      "Gdiff",
      "Gdiffsplit",
      "Gvdiffsplit",
      "Gwrite",
      "Gw",
    },
    keys = {},
  },
}
