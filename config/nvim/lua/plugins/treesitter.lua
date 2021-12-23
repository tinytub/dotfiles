local present, ts_config = pcall(require, "nvim-treesitter.configs")
if not present then
    return
end

local enable = true
local lines = vim.fn.line('$')
local langtree = true

local treesitter = function()
  --lprint("loading treesitter")
  if lines > 30000 then -- skip some settings for large file
    -- vim.cmd[[syntax on]]
    print('skip treesitter')
    require"nvim-treesitter.configs".setup {highlight = {enable = enable}}
    return
  end

  if lines > 7000 then
    enable = false
    langtree = false
    print("disable ts txtobj")
  end


  ts_config.setup {
      ensure_installed = {
        "go", "gomod", "css", "html", "javascript", "typescript", "jsdoc", "json", "c", "java", "toml", "tsx",
        "lua", "cpp", "python", "rust", "jsonc", "dart", "css", "yaml", "vue", "bash"
      },
      --ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
      --ignore_install = {"haskell","comment"}, -- comment make golang file lag
      matchup = {
       enable = false,              -- mandatory, false will disable the whole extension
       disable = { "c", "ruby" },  -- optional, list of language that will be disabled
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
        use_languagetree = langtree,
        disable = {"elm"},
        custom_captures = {todo = 'Todo'}
      },
      --context_commentstring = {
      --    enable = true,
      --    config = {
      --      css = '// %s'
      --    }
      --  },
      autopairs = { enable = true },
      autotag = {enable = true},
      rainbow = {enable = true},
      incremental_selection = {
      enable = enable,
      -- disable = {"elm"},
      }
    }
end

local function textsubjects()
  require'nvim-treesitter.configs'.setup {
    textsubjects = {
      enable = true,
      --keymaps = {['<S-.>'] = 'textsubjects-smart', [';'] = 'textsubjects-container-outer'}
      keymaps = { ["."] = "textsubjects-smart", [";"] = "textsubjects-container-outer" },
    }
  }
end

-- treesitter()

return {
  treesitter = treesitter,
  textsubjects = textsubjects
}
