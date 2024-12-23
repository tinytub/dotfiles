return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- set this if you want to always pull the latest change
    opts = {
      provider = "openai", -- "claude" or "openai" or "azure"
      --debug = true,
      openai = {
        --endpoint = "https://penran.cc/v1",
        endpoint = "https://gateway.ai.cloudflare.com/v1/b405e447102907b7dab0007a12d01a0f/my-ai-gw/openai",
        model = "gpt-4o",
        temperature = 0,
        max_tokens = 4096,
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
      {
        "saghen/blink.cmp",
        optional = true,
        opts = function(_, opts)
          -- set with avante and set to optional ?
          table.insert(opts.sources.compat, "avante_commands")
          table.insert(opts.sources.compat, "avante_mentions")
          table.insert(opts.sources.compat, "avante_files")
          table.insert(opts.sources.default, "markdown")
          opts.sources.providers.markdown = { name = "RenderMarkdown", module = "render-markdown.integ.blink" }
          opts.sources.providers.avante_commands = {
            name = "avante_commands",
            module = "blink.compat.source",
            score_offset = 90, -- show at a higher priority than lsp
            opts = {},
          }
          opts.sources.providers.avante_files = {
            name = "avante_commands",
            module = "blink.compat.source",
            score_offset = 100, -- show at a higher priority than lsp
            opts = {},
          }
          opts.sources.providers.avante_mentions = {
            name = "avante_mentions",
            module = "blink.compat.source",
            score_offset = 1000, -- show at a higher priority than lsp
            opts = {},
          }
        end,
      },
    },
  },
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    config = function(_, opts)
      require("go").setup(opts)
    end,
    opts = {
      -- we only need go command with this plugin
      disable_defaults = true,
      -- go binary need to set
      go = "go",
      -- preludes need set like below, otherwise will cause error
      preludes = {
        default = function()
          return {}
        end, -- one for all commands
        GoRun = function() -- the commands to run before GoRun, this override default
          return {} -- e.g. return {'watchexe', '--restart', '-v', '-e', 'go'}
          -- so you will run `watchexe --restart -v -e go go run `
        end,
      },
    },

    --    config = function() require "plugins.configs.go-nvim" end,
  },
  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      --opts.keymap = { preset = "super-tab", ["<CR>"] = { "accept", "fallback" } }
      opts.completion.menu.border = "rounded"
      opts.completion.menu.draw.columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } }
      opts.completion.documentation.window = {
        border = "rounded",
      }

      --opts.completion = {
      --  menu = {
      --    border = "rounded",
      --  },
      --  documentation = {
      --    window = {
      --      border = "rounded",
      --    },
      --  },
      --  ghost_text = {
      --    enabled = false,
      --  },
      --}
      --opts.sources.default = { "copilot", "lsp", "path" }
    end,
  },

  -- lazyvim 14.x version disabled nvim-cmp by default
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
    },
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local cmp = require("cmp")

      local function border(hl_name)
        return {
          { "╭", hl_name },
          { "─", hl_name },
          { "╮", hl_name },
          { "│", hl_name },
          { "╯", hl_name },
          { "─", hl_name },
          { "╰", hl_name },
          { "│", hl_name },
        }
      end

      local border_opts = {
        --border = "rounded",
        --winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
      }
      -- 去重
      opts.duplicates = {
        nvim_lsp = 1,
        cmp_tabnine = 1,
        buffer = 1,
        path = 1,
      }
      opts.window = {
        completion = cmp.config.window.bordered(border_opts),
        documentation = cmp.config.window.bordered(border_opts),
      }

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif vim.snippet.active({ direction = 1 }) then
            vim.schedule(function()
              vim.snippet.jump(1)
            end)
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif vim.snippet.active({ direction = -1 }) then
            vim.schedule(function()
              vim.snippet.jump(-1)
            end)
          else
            fallback()
          end
        end, { "i", "s" }),
      })
    end,
  },
}
