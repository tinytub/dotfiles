if (vim.g.vscode) then
    require("core.options")
    require('vscode')
else
    local present, impatient = pcall(require, "impatient")
    if present then
        impatient.enable_profile()
    end

    require("core.options")
    require("core.autocmds")
    require("core.global")
    require("core.packerInit").bootstrap()
    require("plugins.pluginList")

    -- set all the non plugin mappings
    require("core.keymappings").misc()
end
