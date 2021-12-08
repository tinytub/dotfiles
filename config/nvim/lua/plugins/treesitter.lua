local present, ts_config = pcall(require, "nvim-treesitter.configs")
if not present then
    return
end

ts_config.setup {
    ensure_installed = 'maintained', -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    ignore_install = {"haskell"},
    matchup = {
        enable = true,              -- mandatory, false will disable the whole extension
        -- disable = { "c", "ruby" },  -- optional, list of language that will be disabled
    },
    highlight = {
      enable = true,
      use_languagetree = true,
    },
    --context_commentstring = {
    --    enable = true,
    --    config = {
    --      css = '// %s'
    --    }
    --  },
    autopairs = { enable = true },
    autotag = {enable = true},
    rainbow = {enable = true}
}
