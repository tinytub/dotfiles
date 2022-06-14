local present, navic = pcall(require, "nvim-navic")

if not present then
    return
end

local icons = require("plugins.lspkind_icons")

local options = {

    separator = "  ",
    -- limit for amount of context shown
    -- 0 means no limit
    depth = 5,

    highlight = true,

    -- indicator used when context hits depth limit
    depth_limit_indicator = "..",
}

navic.setup(options)
