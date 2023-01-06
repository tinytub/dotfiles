local present, alpha = pcall(require, "alpha")

if not present then
  return
end

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
    button("SPC P S", "  Update plugins", ":PackerSync<CR>"),
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
-- Disable statusline in dashboard
vim.api.nvim_create_autocmd("FileType", {
  pattern = "alpha",
  callback = function()
    -- store initial statusline value to be used later
    if type(vim.g.nvchad_vim_laststatus) == "nil" then
      vim.g.nvchad_vim_laststatus = vim.opt.laststatus._value
    end

    -- Remove statusline since we have just loaded into an "alpha" filetype (i.e. dashboard)
    vim.opt.laststatus = 0

    vim.api.nvim_create_autocmd({ "TabEnter", "BufLeave" }, {
      callback = function()
        local current_type = vim.bo.filetype
        if current_type == "alpha" or #current_type == 0 then
          -- Switched to alpha or unknown filetype
          vim.opt.laststatus = 0
        else
          -- Switched to any other filetype
          vim.opt.laststatus = vim.g.nvchad_vim_laststatus
        end
      end
    })

  end,
})

return M
