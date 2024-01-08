require("utils.lsp").on_attach(function(client, buffer)
  if client.name == "docker_compose_language_service" then
    if vim.api.nvim_buf_get_option(buffer, "filetype") == "helm" then
      vim.schedule(function()
        vim.cmd("LspStop ++force docker_compose_language_service")
      end)
    end
  end
end)

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = {
    "*/templates/*.yaml",
    "*/templates/*.tpl",
    "*.gotmpl",
    "helmfile*.yaml",
  },
  callback = function()
    vim.bo.filetype = "helm"
    vim.bo.commentstring = "{{/* %s */}}"
  end,
})

return {
  { "towolf/vim-helm" },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        docker_compose_language_service = {},
        helm_ls = {},
      },
    },
  },
}
