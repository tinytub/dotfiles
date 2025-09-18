return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = true,
    version = false, -- set this if you want to always pull the latest change
    opts = {
      web_search_engine = {
        provider = "google", -- tavily, serpapi, searchapi, google, kagi, brave, or searxng
        proxy = nil, -- proxy support, e.g., http://127.0.0.1:7890
      },

      provider = "gemini-cli",
      --    provider = "gemini", -- "claude" or "openai" or "azure"
      --provider = "moonshot", -- "claude" or "openai" or "azure"
      --provider = "openai", -- "claude" or "openai" or "azure"
      --debug = true,
      --
      providers = {
        openai = {
          --endpoint = "https://penran.cc/v1",
          -- endpoint = "https://gateway.ai.cloudflare.com/v1/b405e447102907b7dab0007a12d01a0f/my-ai-gw/openai",
          model = "gpt-4o",
          --timeout = 30000, -- timeout in milliseconds
          --temperature = 0,
          --max_tokens = 16384,
        },
        moonshot = {
          --  endpoint = "https://api.moonshot.ai/v1",
          endpoint = "https://api.moonshot.cn/v1",
          model = "kimi-k2-0711-preview",
          timeout = 30000, -- Timeout in milliseconds
          extra_request_body = {
            temperature = 0.75,
            max_tokens = 32768,
          },
        },
        gemini = {
          --endpoint = "https://penran.cc/v1",
          --model = "gemini-2.0-flash",
          -- model = "gemini-2.5-flash-preview-05-20",
          model = "gemini-2.5-pro",
          --model = "gemini-2.5-pro-preview-06-05",
          --timeout = 30000, -- timeout in milliseconds
          --temperature = 0,
          --max_tokens = 8192,
        },
      },
      behaviour = {
        enable_fastapply = false, -- Enable Fast Apply feature
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    --config = function()
    --  pcall(function()
    --    -- workaround for https://github.com/yetone/avante.nvim/issues/153
    --    local sidebar_ok, sidebar = pcall(require, "avante.sidebar")
    --    if sidebar_ok and sidebar then
    --      local mt = getmetatable(sidebar)
    --      if mt and mt.delete_containers then
    --        mt.delete_containers = function(self)
    --          if self.containers and self.containers.content then
    --            if #vim.api.nvim_list_wins() < 2 then
    --              vim.cmd.enew()
    --            end
    --            self.containers.content:unmount()
    --            self.containers.content = nil
    --          end
    --          if self.containers and self.containers.input then
    --            if #vim.api.nvim_list_wins() < 2 then
    --              vim.cmd.enew()
    --            end
    --            self.containers.input:unmount()
    --            self.containers.input = nil
    --          end
    --        end
    --      end
    --    end

    --    -- workaround for invalid window id error
    --    local utils_ok, utils = pcall(require, "avante.utils")
    --    if utils_ok and utils and utils.is_top_adjacent then
    --      local original_is_top_adjacent = utils.is_top_adjacent
    --      utils.is_top_adjacent = function(winid, bufnr)
    --        if not vim.api.nvim_win_is_valid(winid) then
    --          return false
    --        end
    --        return original_is_top_adjacent(winid, bufnr)
    --      end
    --    end
    --  end)
    --end,
    -- build = "make BUILD_FROM_SOURCE=true",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      -- "echasnovski/mini.pick", -- for file_selector provider mini.pick
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "ibhagwan/fzf-lua", -- for file_selector provider fzf
      -- "zbirenbaum/copilot.lua", -- for providers='copilot'
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
            -- use_absolute_path = true,
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
      --{
      --  "saghen/blink.cmp",
      --  optional = true,
      --  lazy = true,
      --  dependencies = { "saghen/blink.compat" },
      --  opts = function(_, opts)
      --    -- set with avante and set to optional ?
      --    table.insert(opts.sources.compat, "avante_commands")
      --    table.insert(opts.sources.compat, "avante_mentions")
      --    table.insert(opts.sources.compat, "avante_files")
      --    --table.insert(opts.sources.default, "markdown")
      --    --opts.sources.providers.markdown = { name = "RenderMarkdown", module = "render-markdown.integ.blink" }
      --    opts.sources.providers.avante_commands = {
      --      name = "avante_commands",
      --      module = "blink.compat.source",
      --      score_offset = 90, -- show at a higher priority than lsp
      --      opts = {},
      --      kind = "Avante",
      --    }
      --    opts.sources.providers.avante_files = {
      --      name = "avante_commands",
      --      module = "blink.compat.source",
      --      score_offset = 100, -- show at a higher priority than lsp
      --      opts = {},
      --      kind = "Avante",
      --    }
      --    opts.sources.providers.avante_mentions = {
      --      name = "avante_mentions",
      --      module = "blink.compat.source",
      --      score_offset = 1000, -- show at a higher priority than lsp
      --      opts = {},
      --      kind = "Avante",
      --    }
      --  end,
      --},
    },
  },

  -- npm install -g prettier prettier-plugin-go-template 解决go template 问题

  {
    "ray-x/go.nvim",
    lazy = true,
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

    dependencies = { "saghen/blink.compat" },
    opts = function(_, opts)
      --opts.keymap = { preset = "super-tab", ["<CR>"] = { "accept", "fallback" } }
      opts.completion.menu.border = "rounded"
      opts.completion.menu.draw.columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } }
      opts.completion.documentation.window = {
        border = "rounded",
      }
      opts.completion.accept.auto_brackets = {
        enabled = true,
      }
      opts.keymap = {
        preset = "enter",
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
      }

      -- for Avente --
      -- set with avante and set to optional ?
      table.insert(opts.sources.compat, "avante_commands")
      table.insert(opts.sources.compat, "avante_mentions")
      table.insert(opts.sources.compat, "avante_files")
      --table.insert(opts.sources.default, "markdown")
      --opts.sources.providers.markdown = { name = "RenderMarkdown", module = "render-markdown.integ.blink" }
      opts.sources.providers.avante_commands = {
        name = "avante_commands",
        module = "blink.compat.source",
        score_offset = 90, -- show at a higher priority than lsp
        opts = {},
        kind = "Avante",
      }
      opts.sources.providers.avante_files = {
        name = "avante_commands",
        module = "blink.compat.source",
        score_offset = 100, -- show at a higher priority than lsp
        opts = {},
        kind = "Avante",
      }
      opts.sources.providers.avante_mentions = {
        name = "avante_mentions",
        module = "blink.compat.source",
        score_offset = 1000, -- show at a higher priority than lsp
        opts = {},
        kind = "Avante",
      }
      -- for avente done--
    end,
  },

  -- lazyvim 14.x version disabled nvim-cmp by default
  {
    "hrsh7th/nvim-cmp",
    enabled = false,
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
