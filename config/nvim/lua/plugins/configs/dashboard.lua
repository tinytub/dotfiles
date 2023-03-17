local alpha = require("alpha")


local function button(sc, txt, keybind)
  local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")

  local opts = {
    position = "center",
    text = txt,
    shortcut = sc,
    cursor = 5,
    width = 36,
    align_shortcut = "right",
    hl = "AlphaButtons",
  }

  if keybind then
    opts.keymap = { "n", sc_, keybind, { noremap = true, silent = true } }
  end

  return {
    type = "button",
    val = txt,
    on_press = function()
      local key = vim.api.nvim_replace_termcodes(sc_, true, false, true) or ""
      vim.api.nvim_feedkeys(key, "normal", false)
    end,
    opts = opts,
  }
end

-- dynamic header padding
local fn = vim.fn
local marginTopPercent = 0.3
local headerPadding = fn.max { 2, fn.floor(fn.winheight(0) * marginTopPercent) }

local options = {
  headerPaddingTop = { type = "padding", val = headerPadding },
  headerPaddingBottom = { type = "padding", val = 2 },
}

--local ascii = {
--  "   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          ",
--  "    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ",
--  "          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     ",
--  "           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ",
--  "          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ",
--  "   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ",
--  "  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ",
--  " ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ",
--  " ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ ",
--  "      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ",
--  "       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ",
--}

local ascii = {
  " ",
  "    ███    ██ ██    ██ ██ ███    ███",
  "    ████   ██ ██    ██ ██ ████  ████",
  "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
  "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
  "    ██   ████   ████   ██ ██      ██",
}


options.header = {
  type = "text",
  --val = ascii,
  val = ascii,
  opts = {
    position = "center",
    hl = "AlphaHeader",
  },
}

--require("base46").load_highlight "alpha"
options.buttons = {
  type = "group",
  val = {
    button("N", "  New file", ":ene <BAR> startinsert <CR>"),
    button("SPC F F", "  Find File  ", ":Telescope find_files<CR>"),
    button("SPC F A", "  Find text", ":FzfLua live_grep <CR>"),
    button("SPC F W", "  Find Word  ", ":Telescope live_grep<CR>"),
    button("SPC F O", "  Recent File  ", ":Telescope oldfiles<CR>"),
    button("SPC E S", "  Settings", ":e $MYVIMRC | :cd %:p:h <CR>"),
    button("SPC P S", "  Update plugins", ":Lazy<CR>"),
  },
  opts = {
    spacing = 1,
  },
}

local M = {}

M.setup = function()
  alpha.setup {
    layout = {
      options.headerPaddingTop,
      options.header,
      options.headerPaddingBottom,
      options.buttons,
    },
    opts = {},
  }
end

return M
