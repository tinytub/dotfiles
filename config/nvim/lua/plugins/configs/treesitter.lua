local M = {}
local ts_config = require("nvim-treesitter.configs")

--require("base46").load_highlight "syntax"
--require("base46").load_highlight "treesitter"
local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

local enable = true
local lines = vim.fn.line('$')
local langtree = true

parser_config.sql = { --{{{
  install_info = {
    url = "https://github.com/DerekStride/tree-sitter-sql",
    files = { "src/parser.c" },
    branch = "main",
  },
} --}}}

parser_config.gotmpl = { --{{{
  install_info = {
    url = "https://github.com/ngalaiko/tree-sitter-go-template",
    files = { "src/parser.c" },
  },
  filetype = "gotmpl",
  used_by = { "gohtmltmpl", "gotexttmpl", "gotmpl", "yaml" },
} --}}}

--lprint("loading treesitter")
if lines > 30000 then -- skip some settings for large file
  -- vim.cmd[[syntax on]]
  print('skip treesitter')
  require "nvim-treesitter.configs".setup { highlight = { enable = enable } }
  return
end

if lines > 7000 then
  enable = false
  langtree = false
  print("disable ts txtobj")
end

local opts = {
  ensure_installed = {
    "go", "gomod", "css", "html", "javascript", "typescript", "jsdoc", "json", "c", "java", "toml", "tsx",
    "lua", "cpp", "python", "rust", "jsonc", "dart", "css", "yaml", "vue", "bash", "vim", "vimdoc", "luadoc",
  },
  --ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  --ignore_install = {"haskell","comment"}, -- comment make golang file lag
  matchup = {
    enable = true, -- mandatory, false will disable the whole extension
    disable = { "c", "ruby" }, -- optional, list of language that will be disabled
  },
  indent = { enable = true },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
    use_languagetree = langtree,
    disable = { "elm" },
    custom_captures = { todo = 'Todo' }
  },
  --context_commentstring = {
  --    enable = true,
  --    config = {
  --      css = '// %s'
  --    }
  --  },
  autopairs = { enable = true },
  autotag = { enable = true },
  --rainbow = {enable = true},
  incremental_selection = {
    enable = enable,
    -- disable = {"elm"},
    keymaps = {
      init_selection = "<C-space>",
      node_incremental = "<C-space>",
      scope_incremental = false,
      node_decremental = "<bs>",
    },
  }
}

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

ts_config.setup(opts)

--M.textsubjects = function()
--  require 'nvim-treesitter.configs'.setup {
--    textsubjects = {
--      enable = true,
--      --keymaps = {['<S-.>'] = 'textsubjects-smart', [';'] = 'textsubjects-container-outer'}
--      keymaps = { ["."] = "textsubjects-smart", [";"] = "textsubjects-container-outer" },
--    }
--  }
--end



--return {
--  treesitter = treesitter,
--  textsubjects = textsubjects
--}
