return {

  {
    -- try snack scroll
    "karb94/neoscroll.nvim",
    enabled = false,
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
        version = "v2.*",
        opts = {
          --hint = "floating-big-letter",
          statusline_winbar_picker = {
            use_winbar = "smart",
          },

          -- 'statusline-winbar' | 'floating-big-letter'
          hint = "floating-big-letter",

          -- filter using buffer options
          filter_rules = {
            autoselect_one = true,
            include_current_win = false,
            bo = {

              -- if the file type is one of following, the window will be ignored
              filetype = {
                "neo-tree",
                "neo-tree-popup",
                "notify",
                "quickfix",
                "edgy",
                "noice",
                "snacks_notif",
                "snacks_notif_history",
                "snacks_dashboard",
                "snacks_terminal",
                "snacks_win",
              },
              -- if the buffer type is one of following, the window will be ignored
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
    opts = function(_, opts)
      --vim.api.nvim_set_hl(0, "NeoTreeCurrentFile", {
      --  --fg = "#ffcc00", -- 设置前景色为黄色
      --  fg = "#e35e4f",
      --  bg = "#282828", -- 设置背景色
      --  bold = true, -- 设置加粗
      --})
      opts.window.mappings = {
        ["<c-x>"] = "split_with_window_picker",
        ["<c-v>"] = "vsplit_with_window_picker",
        ["l"] = "open_with_window_picker",
        ["<cr>"] = "open_drop",
      }
      -- 高亮当前文件
      --opts.window.highlight_current_file = {
      --  enabled = true,
      --  group = "NeoTreeCurrentFile", -- 你可以自定义这个group
      --}
    end,
  },
  {
    "vim-test/vim-test",
    event = "VeryLazy",
    config = function()
      --vim.cmd([[
      --        function! ToggleTermStrategy(cmd) abort
      --          call luaeval("require('toggleterm').exec(_A[1], _A[2])", [a:cmd, 0])
      --        endfunction

      --        let g:test#custom_strategies = {'toggleterm': function('ToggleTermStrategy')}
      --      ]])
      --vim.g["test#strategy"] = "toggleterm"

      vim.g["test#custom_strategies"] = {
        snacks = function(cmd)
          --require("snacks").terminal(cmd, { win = { position = "bottom", enter = true }, interactive = false })
          require("snacks").terminal.open(cmd, { win = { position = "bottom", enter = true }, interactive = false })
          --vim.cmd("stopinsert")
          --vim.cmd("normal! G")
        end,
      }
      vim.g["test#strategy"] = "snacks"
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
    enabled = false,

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
  {
    "nvim-telescope/telescope.nvim",
    enabled = false,
    -- change some options
    opts = function(_, opts)
      if not LazyVim.has("flash.nvim") then
        return
      end
      local function flash(prompt_bufnr)
        require("flash").jump({
          pattern = "^",
          label = { after = { 0, 0 } },
          search = {
            mode = "search",
            exclude = {
              function(win)
                return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "TelescopeResults"
              end,
            },
          },
          action = function(match)
            local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
            picker:set_selection(match.pos[1] - 1)
          end,
        })
      end

      local actions = require("telescope.actions")
      opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
        mappings = {
          n = {
            s = flash,
          },
          i = {
            ["<c-s>"] = flash,

            ["<Tab>"] = actions.move_selection_previous,
            ["<S-Tab>"] = actions.move_selection_next,
          },
        },
      })

      --local actions = require("telescope.actions")
      --return {
      --  defaults = {
      --    mappings = {
      --      i = {
      --        ["<Tab>"] = actions.move_selection_previous,
      --        ["<S-Tab>"] = actions.move_selection_next,
      --      },
      --      n = {
      --        ["q"] = actions.close,
      --      },
      --    },
      --  },
      --}
    end,
  },
  {
    -- default for lazyvim version 14.x
    "ibhagwan/fzf-lua",
    --enabled = false,
    cmd = "FzfLua",
    opts = function(_, opts)
      local config = require("fzf-lua.config")
      config.defaults.keymap.fzf["tab"] = "down"
      config.defaults.keymap.fzf["shift-tab"] = "up"
    end,
  },
  {
    "s1n7ax/nvim-window-picker",
    version = "v2.*",
    event = "VeryLazy",
    opts = {
      --hint = "floating-big-letter",
      statusline_winbar_picker = {
        use_winbar = "smart",
      },

      -- 'statusline-winbar' | 'floating-big-letter'
      hint = "floating-big-letter",

      -- filter using buffer options
      filter_rules = {
        autoselect_one = true,
        include_current_win = false,
        bo = {

          -- if the file type is one of following, the window will be ignored
          filetype = {
            "neo-tree",
            "neo-tree-popup",
            "notify",
            "quickfix",
            "edgy",
            "noice",
            "snacks_notif",
            "snacks_notif_history",
            "snacks_dashboard",
            "snacks_terminal",
            "snacks_win",
          },
          -- if the buffer type is one of following, the window will be ignored
          buftype = { "terminal", "quickfix" },
        },
      },
      --         other_win_hl_color = "#e35e4f",
    },
    config = function(_, opts)
      require("window-picker").setup(opts)
    end,
  },
}
