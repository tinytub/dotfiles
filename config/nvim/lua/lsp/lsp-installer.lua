local ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not ok then return end

-- NEW CONFIGURATION OF NVIM-LSP-INSTALLER
lsp_installer.setup {
    --ensure_installed = {
    --    "sumneko_lua", "vimls",
    --    "pyright", "jsonls", "gopls",
    --    "html", "bashls", "grammarly",
    --},

    automatic_installation = false, -- 在 lspconfig.xxx.setup() 的 LSP 自动安装.
    ui = {
        check_outdated_servers_on_open = true, -- 打开面板时检查 outdated lsp

        icons = {
            server_installed = " ",
            server_pending = " ",
            server_uninstalled = " ﮊ",
            --server_installed = "✓",
            --server_pending = "➜",
            --server_uninstalled = "✗"
        },
    },
    --install_root_dir = vim.fn.stdpath("data") .. "/lsp_servers",

    log_level = vim.log.levels.DEBUG,

    max_concurrent_installers = 10, -- 并发安装数量
}
