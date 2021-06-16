
    require'lspsaga'.init_lsp_saga({
      finder_action_keys = {
        open = 'o', vsplit = 's',split = 'i',quit = '<esc>',scroll_down = '<C-f>', scroll_up = '<C-b>' -- quit can be a table
      },
      use_saga_diagnostic_sign = false,
      error_sign = '',
      warn_sign = '',
      hint_sign = '',
      infor_sign = '',
      max_preview_lines = 45,
       code_action_keys = {
           quit = '<esc>',
           exec = '<cr>'
       },
    })