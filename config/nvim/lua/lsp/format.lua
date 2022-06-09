local lsp = vim.lsp
local format = {}

-- newer imports from
-- https://github.com/neovim/nvim-lspconfig/issues/115#issuecomment-866632451
function format.OrgImports(wait_ms)
    -- neovim 0.7 need an param in make_range_params
    --local params = vim.lsp.util.make_range_params()
    local params = vim.lsp.util.make_range_params(0)
    params.context = { only = { "source.organizeImports" } }
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
    for _, res in pairs(result or {}) do
        for _, r in pairs(res.result or {}) do
            if r.edit then
                vim.lsp.util.apply_workspace_edit(r.edit, "utf-16")
            else
                vim.lsp.buf.execute_command(r.command)
            end
        end
    end
end

return format

--vim.api.nvim_create_autocmd("BufWritePre", {
--  pattern = { "*.go" },
--  callback = function()
--	  vim.lsp.buf.formatting_sync(nil, 3000)
--  end,
--})
--
--vim.api.nvim_create_autocmd("BufWritePre", {
--	pattern = { "*.go" },
--	callback = function()
--		local params = vim.lsp.util.make_range_params(nil, vim.lsp.util._get_offset_encoding())
--		params.context = {only = {"source.organizeImports"}}
--
--		local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
--		for _, res in pairs(result or {}) do
--			for _, r in pairs(res.result or {}) do
--				if r.edit then
--					vim.lsp.util.apply_workspace_edit(r.edit, vim.lsp.util._get_offset_encoding())
--				else
--					vim.lsp.buf.execute_command(r.command)
--				end
--			end
--		end
--	end,
--})
