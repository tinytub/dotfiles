local M = {}
function M.Lsp_keymaps(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  -- Mappings.
  local opts = { noremap = true, silent = true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  buf_set_keymap("n", "gk", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
  buf_set_keymap("n", "<space>lt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  --buf_set_keymap('n', '<leader>lc', '<cmd>lua vim.diagnostic.reset()<CR>',
  --  { desc = "clear diagnostics [LSP]" })
  --buf_set_keymap('n', '<leader>ll', '<cmd>lua vim.diagnostic.open_float(0, { scope = "line", border = "rounded" })<CR>'
  --  , { desc = "show line diagnostic [LSP]" })
  --buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  --buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references({includeDeclaration = false} )<CR>", opts)
  buf_set_keymap("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
  buf_set_keymap(
    "n",
    "ge",
    '<cmd>lua vim.diagnostic.open_float(0, { scope = "line", header = false, focus = false })<CR>',
    opts
  )
  --buf_set_keymap("n", "[e", '<cmd>lua vim.lsp.diagnostic.goto_prev({ popup_opts = { border = "single" }})<CR>', opts)
  --buf_set_keymap("n", "]e", '<cmd>lua vim.lsp.diagnostic.goto_next({ popup_opts = { border = "single" }})<CR>', opts)
  buf_set_keymap("n", "[e", '<cmd>lua vim.diagnostic.goto_prev({ float = { border = "rounded" } })<CR>', opts)
  buf_set_keymap("n", "]e", '<cmd>lua vim.diagnostic.goto_next({ float = { border = "rounded" } })<CR>', opts)
  buf_set_keymap("n", "<space>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
  buf_set_keymap("n", "<space>lf", "<cmd>lua vim.lsp.buf.format()<cr>", opts)
  buf_set_keymap("v", "<space>la", "<cmd>lua vim.lsp.buf.range_code_action()<CR>", opts)

  --client.server_capabilities.documentFormattingProvider = false
  --client.server_capabilities.documentRangeFormattingProvider = false
  -- neovim 0.8?
  --if client.server_capabilities.documentFormattingProvider then
  --  --vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { unpack(opts), desc = "LSP format" })
  --  vim.api.nvim_buf_create_user_command(
  --    bufnr,
  --    "LspFormat",
  --    vim.lsp.buf.format,
  --    { range = false, desc = "LSP format" }
  --  )
  --end

  --if client.server_capabilities.documentRangeFormattingProvider then
  --  vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr(#{timeout_ms:250})")
  --  --vim.keymap.set("x", "<leader>lf", vim.lsp.buf.range_formatting, { unpack(opts), desc = "LSP range format" })
  --  vim.api.nvim_buf_create_user_command(
  --    bufnr,
  --    "LspRangeFormat",
  --    --vim.lsp.buf.range_formatting,
  --    vim.lsp.buf.format,
  --    { range = true, desc = "LSP range format" }
  --  )
  --end
end

return M
