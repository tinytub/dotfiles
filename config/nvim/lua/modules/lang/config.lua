local config = {}

function config.nvim_treesitter()
  vim.api.nvim_command('set foldmethod=expr')
  vim.api.nvim_command('set foldexpr=nvim_treesitter#foldexpr()')
  require'nvim-treesitter.configs'.setup {
      highlight = {
        enable = true,
      },
      textobjects = {
        select = {
          enable = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },
        },
      },
    ensure_installed = 'maintained'
  }
end

function config.vim_go()
  local g = vim.g
  g.go_def_mapping_enabled = 0
  g.go_code_completion_enabled = 0
  g.go_code_completion_icase = 0
  g.go_doc_keywordprg_enabled = 0
  g.go_imports_autosave = 0
  g.go_mod_fmt_autosave = 0
  g.go_jump_to_error = 0
  g.go_fmt_autosave = 0
  g.go_diagnostics_enabled = 0
  g.go_gopls_enabled = 0

  g.go_fmt_fail_silently = 1

  g.go_highlight_fields = 0
  g.go_highlight_functions = 0
  g.go_highlight_function_calls = 0
  g.go_highlight_extra_types = 0
  g.go_highlight_operators = 0
  g.go_highlight_string_spellcheck = 0
  g.go_highlight_variable_declarations = 0
  g.go_highlight_variable_assignments = 0
  g.go_fmt_command = "goimports"
  g.go_version_warning = 1
  g.go_auto_sameids = 0
  g.go_updatetime = 500
  g.go_doc_popup_window = 1
  g.go_debug_mapping = {{}}
end

return config
