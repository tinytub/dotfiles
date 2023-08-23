--syntax highlighting
return {

  {
    "nvim-treesitter/nvim-treesitter",
    name = "nvim-treesitter",
    version = false,
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSUpdateSync" },
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        init = function()
          -- disable rtp plugin, as we only need its queries for mini.ai
          -- In case other textobject modules are enabled, we will load them
          -- once nvim-treesitter is loaded
          require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
          load_textobjects = true
        end,
      },
    },
    keys = {
      { "<c-space>", desc = "Increment selection" },
      { "<bs>",      desc = "Decrement selection", mode = "x" },
    },
    ---@type TSConfig
    opts = {
      context_commentstring = { enable = true, enable_autocmd = false },

      highlight = {
        enable = true,
        disable = function(_, bufnr) return vim.b[bufnr].large_buf end,
      },
      indent = { enable = true },
      ensure_installed = {
        "bash",
        "c",
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
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
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

      if load_textobjects then
        -- PERF: no need to load the plugin, if we only need its queries for mini.ai
        if opts.textobjects then
          for _, mod in ipairs({ "move", "select", "swap", "lsp_interop" }) do
            if opts.textobjects[mod] and opts.textobjects[mod].enable then
              local Loader = require("lazy.core.loader")
              Loader.disabled_rtp_plugins["nvim-treesitter-textobjects"] = nil
              local plugin = require("lazy.core.config").plugins["nvim-treesitter-textobjects"]
              require("lazy.core.loader").source_runtime(plugin.dir, "plugin")
              break
            end
          end
        end
      end
    end,
    ----    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSEnable", "TSDisable", "TSModuleInfo" },
    --config = function() require "plugins.configs.treesitter" end,
    ----run = ":TSUpdate",
    --run = function() require("nvim-treesitter.install").update { with_sync = true } () end,
    ----config = function ()
    ----   require "plugins.configs.treesitter"
    ----end
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = "nvim-treesitter",
    enabled = false,
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
}
