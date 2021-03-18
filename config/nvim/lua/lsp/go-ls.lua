local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local function nvim_create_augroup(group_name,definitions)
  vim.api.nvim_command('augroup '..group_name)
  vim.api.nvim_command('autocmd!')
  for _, def in ipairs(definitions) do
    local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
    vim.api.nvim_command(command)
  end
  vim.api.nvim_command('augroup END')
end

function lsp_before_save()
  local defs = {}
  table.insert(defs,{"BufWritePre","*.go",
            "lua go_organize_imports_sync(1000)"})

  nvim_create_augroup('lsp_before_save',defs)
end

-- Synchronously organise (Go) imports. Taken from
-- https://github.com/neovim/nvim-lsp/issues/115#issuecomment-654427197.
function go_organize_imports_sync(timeout_ms)
  local context = { source = { organizeImports = true } }
  vim.validate { context = { context, 't', true } }
  local params = vim.lsp.util.make_range_params()
  params.context = context

  -- See the implementation of the textDocument/codeAction callback
  -- (lua/vim/lsp/handler.lua) for how to do this properly.
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
  if not result or next(result) == nil then return end
  local actions = result[1].result or nil
  if not actions then return end
  local action = actions[1]

  -- textDocument/codeAction can return either Command[] or CodeAction[]. If it
  -- is a CodeAction, it can have either an edit, a command or both. Edits
  -- should be executed first.
  if action.edit or type(action.command) == "table" then
    if action.edit then
      vim.lsp.util.apply_workspace_edit(action.edit)
    end
    if type(action.command) == "table" then
      vim.lsp.buf.execute_command(action.command)
    end
  else
    vim.lsp.buf.execute_command(action)
  end
end

local enhance_attach = function(client,bufnr)
  if client.resolved_capabilities.document_formatting then
    lsp_before_save()
  end
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
end

require'lspconfig'.gopls.setup {
  cmd = {"gopls","--remote=auto"},
  on_attach = enhance_attach,
  capabilities = capabilities,
  init_options = {
    usePlaceholders=false,
    completeUnimported=true,
    gofumpt = false,
--    staticcheck = true,
    deepCompletion=true,
    allowModfileModifications=true
  }
}

