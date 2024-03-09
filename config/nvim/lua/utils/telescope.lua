local Util = require("utils")

---@class utils.telescope.opts
---@field cwd? string|boolean
---@field show_untracked? boolean

---@class utils.telescope
---@overload fun(builtin:string, opts?:utils.telescope.opts)
local M = setmetatable({}, {
  __call = function(m, ...)
    return m.telescope(...)
  end,
})

-- this will return a function that calls telescope.
-- cwd will default to utils.get_root
-- for `files`, git_files or find_files will be chosen depending on .git
---@param builtin string
---@param opts? utils.telescope.opts
function M.telescope(builtin, opts)
  local params = { builtin = builtin, opts = opts }
  return function()
    builtin = params.builtin
    opts = params.opts
    opts = vim.tbl_deep_extend("force", { cwd = Util.root() }, opts or {}) --[[@as utils.telescope.opts]]
    if builtin == "files" then
      if
        vim.loop.fs_stat((opts.cwd or vim.loop.cwd()) .. "/.git")
        and not vim.loop.fs_stat((opts.cwd or vim.loop.cwd()) .. "/.ignore")
        and not vim.loop.fs_stat((opts.cwd or vim.loop.cwd()) .. "/.rgignore")
      then
        opts.show_untracked = true
        builtin = "git_files"
      else
        builtin = "find_files"
      end
    end
    if opts.cwd and opts.cwd ~= vim.loop.cwd() then
      local function open_cwd_dir()
        local action_state = require("telescope.actions.state")
        local line = action_state.get_current_line()
        M.telescope(
          params.builtin,
          vim.tbl_deep_extend("force", {}, params.opts or {}, { cwd = false, default_text = line })
        )()
      end
      ---@diagnostic disable-next-line: inject-field
      opts.attach_mappings = function(_, map)
        -- opts.desc is overridden by telescope, until it's changed there is this fix
        map("i", "<a-c>", open_cwd_dir, { desc = "Open cwd directory" })
        return true
      end
    end

    require("telescope.builtin")[builtin](opts)
  end
end

function M.config_files()
  return Util.telescope("find_files", { cwd = vim.fn.stdpath("config") })
end

return M
