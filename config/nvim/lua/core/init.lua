local core_modules = {
   "core.options",
   "core.autocmds"
}

for _, module in ipairs(core_modules) do
   local ok, err = pcall(require, module)
   if not ok then
      error("Error loading " .. module .. "\n\n" .. err)
   end
end

-- set all the non plugin mappings
require("core.keymappings").misc()
require("core.keymappings").terms()
--M.terms()
