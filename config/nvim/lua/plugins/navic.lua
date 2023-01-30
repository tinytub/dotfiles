local navic = require("nvim-navic")

local options = {

  separator = "  ",
  -- limit for amount of context shown
  -- 0 means no limit
  depth_limit = 5,

  highlight = true,

  -- indicator used when context hits depth limit
  depth_limit_indicator = "..",
}

navic.setup(options)
