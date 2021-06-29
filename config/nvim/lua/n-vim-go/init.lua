local M = {}

M.config = function()
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
  vim.g.go_echo_command_info = 1
  vim.g.go_fmt_fail_silently = 1
  vim.g.go_term_enabled = 1
  vim.g.go_fillstruct_mode = 'gopls'
  vim.g.go_addtags_transform = "camelcase"

  vim.g.go_auto_sameids = 0
--  vim.g.go_highlight_fields = 1
--  vim.g.go_highlight_function_parameters = 1
--  vim.g.go_highlight_functions = 1
--  vim.g.go_highlight_function_calls = 1
--  vim.g.go_highlight_extra_types = 1
--  vim.g.go_highlight_operators = 1
--  vim.g.go_highlight_string_spellcheck = 1
--  vim.g.go_highlight_variable_declarations = 1
--  vim.g.go_highlight_variable_assignments = 1
  vim.g.go_fmt_command = "goimports"
  vim.g.go_version_warning = 1
  vim.g.go_updatetime = 500
  vim.g.go_doc_popup_window = 1
  vim.g.go_debug_mapping = {{}}
end
return M
