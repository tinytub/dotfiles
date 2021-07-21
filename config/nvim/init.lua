require "options"
require "keymappings"
require "highlights"
require "pluginList"

require "plugins.utils"
require "plugins.treesitter"
require "plugins.whichkey"


--local async
--async =
--    vim.loop.new_async(
--    vim.schedule_wrap(
--        function ()
--            require "keymappings"
--            require "highlights"
--            require "pluginList"
--
--            require "plugins.utils"
--            require "plugins.treesitter"
--            require "plugins.whichkey"
--            async:close()
--        end
--    )
--)
--
--async:send()
