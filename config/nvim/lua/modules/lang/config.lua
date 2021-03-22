local config = {}

function config.nvim_treesitter()
  vim.api.nvim_command('set foldmethod=expr')
  vim.api.nvim_command('set foldexpr=nvim_treesitter#foldexpr()')
  require'nvim-treesitter.configs'.setup {
      ensure_installed = 'maintained',
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
      --playground = {
      --  enable = true,
      --  disable = {},
      --  updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
      --  persist_queries = false -- Whether the query persists across vim sessions
      --},
      --rainbow = {enable = false},
  }
end

function config.vim_go()
  vim.g.go_def_mapping_enabled = 0
  vim.g.go_code_completion_enabled = 0
  vim.g.go_code_completion_icase = 0
  vim.g.go_doc_keywordprg_enabled = 0
  vim.g.go_imports_autosave = 0
  vim.g.go_mod_fmt_autosave = 0
  vim.g.go_jump_to_error = 0
  vim.g.go_fmt_autosave = 0
  vim.g.go_diagnostics_enabled = 0
  vim.g.go_gopls_enabled = 0
  vim.g.go_echo_go_info = 0
  vim.g.go_fmt_fail_silently = 1

  vim.g.go_highlight_fields = 0
  vim.g.go_highlight_functions = 0
  vim.g.go_highlight_function_calls = 0
  vim.g.go_highlight_extra_types = 0
  vim.g.go_highlight_operators = 0
  vim.g.go_highlight_string_spellcheck = 0
  vim.g.go_highlight_variable_declarations = 0
  vim.g.go_highlight_variable_assignments = 0
  vim.g.go_fmt_command = "goimports"
  vim.g.go_version_warning = 1
  vim.g.go_auto_sameids = 0
  vim.g.go_updatetime = 500
  vim.g.go_doc_popup_window = 1
  vim.g.go_debug_mapping = {{}}
end

return config
