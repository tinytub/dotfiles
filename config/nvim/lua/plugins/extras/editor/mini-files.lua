local function map_split(buf_id, lhs, direction)
  local minifiles = require("mini.files")

  local function rhs()
    local window = minifiles.get_target_window()

    -- Noop if the explorer isn't open or the cursor is on a directory.
    if window == nil or minifiles.get_fs_entry().fs_type == "directory" then
      return
    end

    -- Make a new window and set it as target.
    local new_target_window
    vim.api.nvim_win_call(window, function()
      vim.cmd(direction .. " split")
      new_target_window = vim.api.nvim_get_current_win()
    end)

    minifiles.set_target_window(new_target_window)

    -- Go in and close the explorer.
    minifiles.go_in({ close_on_file = true })
  end

  vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = "Split " .. string.sub(direction, 12) })
end
return {
  "echasnovski/mini.files",
  opts = {
    windows = {
      preview = true,
      width_focus = 30,
      width_preview = 30,
    },
    options = {
      -- Whether to use for editing directories
      -- Disabled by default in LazyVim because neo-tree is used for that
      use_as_default_explorer = false,
    },
  },
  keys = {
    {
      "<leader>fm",
      function()
        require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
      end,
      desc = "Open mini.files (directory of current file)",
    },
    {
      "<leader>fM",
      function()
        require("mini.files").open(vim.uv.cwd(), true)
      end,
      desc = "Open mini.files (cwd)",
    },
  },
  config = function(_, opts)
    require("mini.files").setup(opts)

    local show_dotfiles = true
    local filter_show = function(fs_entry)
      return true
    end
    local filter_hide = function(fs_entry)
      return not vim.startswith(fs_entry.name, ".")
    end

    local toggle_dotfiles = function()
      show_dotfiles = not show_dotfiles
      local new_filter = show_dotfiles and filter_show or filter_hide
      require("mini.files").refresh({ content = { filter = new_filter } })
    end

    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesBufferCreate",
      callback = function(args)
        local buf_id = args.data.buf_id
        -- Tweak left-hand side of mapping to your liking
        vim.keymap.set("n", "g.", toggle_dotfiles, { buffer = buf_id, desc = "Toggle hidden files" })
      end,
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesActionRename",
      callback = function(event)
        require("utils").lsp.on_rename(event.data.from, event.data.to)
      end,
    })

    vim.api.nvim_create_autocmd("User", {
      desc = "Add minifiles split keymaps",
      pattern = "MiniFilesBufferCreate",
      callback = function(args)
        local buf_id = args.data.buf_id
        map_split(buf_id, "<C-s>", "belowright horizontal")
        map_split(buf_id, "<C-v>", "belowright vertical")
      end,
    })
    --local map_split = function(buf_id, lhs, direction)
    --  local minifiles = require("mini.files")
    --  local rhs = function()
    --    -- Make new window and set it as target
    --    local new_target_window
    --    vim.api.nvim_win_call(minifiles.get_target_window(), function()
    --      vim.cmd(direction .. " split")
    --      new_target_window = vim.api.nvim_get_current_win()
    --    end)

    --    minifiles.set_target_window(new_target_window)
    --  end

    --  -- Adding `desc` will result into `show_help` entries
    --  local desc = "Split " .. direction
    --  vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
    --end

    --vim.api.nvim_create_autocmd("User", {
    --  pattern = "MiniFilesBufferCreate",
    --  callback = function(args)
    --    local buf_id = args.data.buf_id
    --    -- Tweak keys to your liking
    --    map_split(buf_id, "<c-s>", "belowright horizontal")
    --    map_split(buf_id, "<c-v>", "belowright vertical")
    --  end,
    --})
  end,
}
