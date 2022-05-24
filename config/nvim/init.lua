if vim.g.vscode then
    return
end


local present, impatient = pcall(require, "impatient")

if present then
   impatient.enable_profile()
end

require("core.options")
require("core.autocmds")
require("core.global")
require("packerInit").bootstrap()

-- set all the non plugin mappings
require("core.keymappings").misc()
