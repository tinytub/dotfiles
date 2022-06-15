if vim.g.vscode then
    require("core.options")
    require("vscode")
else
    require("core.options")
    require("core.autocmds")
    require("core.global")
    require("core.packerInit").bootstrap()
    require("plugins.pluginList")

    -- set all the non plugin mappings
    require("core.keymappings").misc()
end
