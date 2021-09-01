--require "options"


--require "keymappings"
--pcall(require "pluginList")

--require "plugins.utils"
--require "plugins.treesitter"
--require "plugins.whichkey"


--local chad_modules = {
--    --"pluginList",
--    --"plugins.bufferline",
--    --"mappings",
--    --"utils"
--
--    "keymappings",
--    "pluginList",
--    "plugins.utils",
--}
--
--for i = 1, #chad_modules, 1 do
--    pcall(require, chad_modules[i])
--end
--

local init_modules = {
   "core",
}

for _, module in ipairs(init_modules) do
   local ok, err = pcall(require, module)
   if not ok then
      error("Error loading " .. module .. "\n\n" .. err)
   end
end
