--syntax highlighting
return {
  {
    "nvim-treesitter/nvim-treesitter",
    name = "nvim-treesitter",
    version = false,
    build = ":TSUpdate",
    event = { "LazyFile", "VeryLazy" },
    init = function(plugin)
      -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
      -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
      -- no longer trigger the **nvim-treeitter** module to be loaded in time.
      -- Luckily, the only thins that those plugins need are the custom queries, which we make available
      -- during startup.
      require("lazy.core.loader").add_to_rtp(plugin)
      require("nvim-treesitter.query_predicates")
    end,
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        config = function()
          -- When in diff mode, we want to use the default
          -- vim text objects c & C instead of the treesitter ones.
          local move = require("nvim-treesitter.textobjects.move") ---@type table<string,fun(...)>
          local configs = require("nvim-treesitter.configs")
          for name, fn in pairs(move) do
            if name:find("goto") == 1 then
              move[name] = function(q, ...)
                if vim.wo.diff then
                  local config = configs.get_module("textobjects.move")[name] ---@type table<string,string>
                  for key, query in pairs(config or {}) do
                    if q == query and key:find("[%]%[][cC]") then
                      vim.cmd("normal! " .. key)
                      return
                    end
                  end
                end
                return fn(q, ...)
              end
            end
          end
        end,
      },
    },
    keys = {
      { "<c-space>", desc = "Increment selection" },
      { "<bs>", desc = "Decrement selection", mode = "x" },
    },
    ---@type TSConfig
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      context_commentstring = { enable = true, enable_autocmd = false },

      highlight = {
        enable = true,
        disable = function(_, bufnr)
          return vim.b[bufnr].large_buf
        end,
      },
      indent = { enable = true },
      ensure_installed = {
        "bash",
        "c",
        "diff",
        "css",
        "cpp",
        "html",
        "javascript",
        "typescript",
        "json",
        "jsonc",
        "jsdoc",
        "java",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
        "toml",
        "rust",
        "vue",
        "bash",
        "go",
        "gomod",
        "gowork",
        "gosum",
      },
      ignore_install = { "comment" }, -- lagging

      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
      textobjects = {
        move = {
          enable = true,
          goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
          goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
          goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
          goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
        },
      },
    },
    ---@param opts TSConfig
    config = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        ---@type table<string, boolean>
        local added = {}
        opts.ensure_installed = vim.tbl_filter(function(lang)
          if added[lang] then
            return false
          end
          added[lang] = true
          return true
        end, opts.ensure_installed)
      end
      require("nvim-treesitter.configs").setup(opts)
    end,
    ----    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSEnable", "TSDisable", "TSModuleInfo" },
    --config = function() require "plugins.configs.treesitter" end,
    ----run = ":TSUpdate",
    --run = function() require("nvim-treesitter.install").update { with_sync = true } () end,
    ----config = function ()
    ----   require "plugins.configs.treesitter"
    ----end
  },

  -- Custom semantic text objects
  --{
  --  "nvim-treesitter/nvim-treesitter-textobjects",
  --  dependencies = "nvim-treesitter",
  --  --config = function ()
  --  --  require("plugins.configs.treesitter").treesitter_obj()
  --  --end,
  --  enabled = false,
  --},
  ---- Smart text objects
  --{
  --  "RRethy/nvim-treesitter-textsubjects",
  --  dependencies = "nvim-treesitter",
  --  config = function()
  --    require("plugins.configs.treesitter").textsubjects()
  --  end,
  --  enabled = false,
  --},
  ---- Text objects using hint labels
  --{
  --  "mfussenegger/nvim-ts-hint-textobject",
  --  event = "BufRead",
  --  dependencies = "nvim-treesitter",
  --  enabled = false,
  --},

  -- Show context of the current function
  -- 现实当前function的上下文
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "LazyFile",
    enabled = false,
    opts = { mode = "cursor", max_lines = 3 },
  },
  -- Automatically add closing tags for HTML and JSX
  {
    "windwp/nvim-ts-autotag",
    event = "LazyFile",
    opts = {},
    keys = {
      {
        "<leader>ut",
        function()
          local Util = require("utils")
          local tsc = require("treesitter-context")
          tsc.toggle()
          if Util.inject.get_upvalue(tsc.toggle, "enabled") then
            Util.info("Enabled Treesitter Context", { title = "Option" })
          else
            Util.warn("Disabled Treesitter Context", { title = "Option" })
          end
        end,
        desc = "Toggle Treesitter Context",
      },
    },
  },
}
