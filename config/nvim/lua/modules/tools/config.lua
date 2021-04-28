local config = {}

local function load_env_file()
  local env_file = os.getenv("HOME")..'/.env'
  local env_contents = {}
  if vim.fn.filereadable(env_file) ~= 1 then
    print('.env file does not exist')
    return
  end
  local contents = vim.fn.readfile(env_file)
  for _,item in pairs(contents) do
    local line_content = vim.fn.split(item,"=")
    env_contents[line_content[1]] = line_content[2]
  end
  return env_contents
end

local function load_dbs()
  local env_contents = load_env_file()
  local dbs = {}
  for key,value in pairs(env_contents) do
    if vim.fn.stridx(key,"DB_CONNECTION_") >= 0 then
      local db_name = vim.fn.split(key,"_")[3]:lower()
      dbs[db_name] = value
    end
  end
  return dbs
end

function config.vim_dadbod_ui()
  if packer_plugins['vim-dadbod'] and not packer_plugins['vim-dadbod'].loaded then
    vim.cmd [[packadd vim-dadbod]]
  end
  vim.g.db_ui_show_help = 0
  vim.g.db_ui_win_position = 'left'
  vim.g.db_ui_use_nerd_fonts = 1
  vim.g.db_ui_winwidth = 35
  vim.g.db_ui_save_location = os.getenv("HOME") .. '/.cache/vim/db_ui_queries'
  vim.g.dbs = load_dbs()
end

function config.vim_vista()
  vim.g['vista#renderer#enable_icon'] = 1
  vim.g.vista_disable_statusline = 1
  vim.g.vista_default_executive = 'ctags'
  vim.g.vista_echo_cursor_strategy = 'floating_win'
  vim.g.vista_vimwiki_executive = 'markdown'
  vim.g.vista_executive_for = {
    vimwiki =  'markdown',
    pandoc = 'markdown',
    markdown = 'toc',
    typescript = 'nvim_lsp',
    typescriptreact =  'nvim_lsp',
  }
end

function config.markdown()
  vim.g.vim_markdown_frontmatter = 1
  vim.g.vim_markdown_strikethrough = 1
  vim.g.vim_markdown_folding_level = 6
  vim.g.vim_markdown_override_foldtext = 1
  vim.g.vim_markdown_folding_style_pythonic = 1
  vim.g.vim_markdown_conceal = 0
  --vim.g.vim_markdown_conceal_code_blocks = 0
  --vim.g.vim_markdown_conceal = 1
  --vim.g.vim_markdown_conceal_code_blocks = 1
  vim.g.vim_markdown_new_list_item_indent = 0
  vim.g.vim_markdown_toc_autofit = 0
  vim.g.vim_markdown_edit_url_in = "vsplit"
  vim.g.vim_markdown_strikethrough = 1
  vim.g.vim_markdown_fenced_languages = {
    "c++=javascript",
    "js=javascript",
    "json=javascript",
    "jsx=javascript",
    "tsx=javascript"
  }
end

function config.mkdp()
  vim.g.mkdp_auto_start = 0
  vim.g.mkdp_command_for_global = 1
  vim.cmd(
    [[let g:mkdp_preview_options = { 'mkit': {}, 'katex': {}, 'uml': {}, 'maid': {}, 'disable_sync_scroll': 0, 'sync_scroll_type': 'middle', 'hide_yaml_meta': 1, 'sequence_diagrams': {}, 'flowchart_diagrams': {}, 'content_editable': v:true, 'disable_filename': 0 }]]
  )
end

return config
