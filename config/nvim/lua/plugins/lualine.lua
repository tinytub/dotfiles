local ok, lualine = pcall(require, "lualine")
if not ok then
    vim.notify("Failed to load lualine", "error", { title = "[lualine.nvim] error" })
    return
end

local navic_ok, navic = pcall(require, "nvim-navic")
if not navic_ok then
    vim.notify("Failed to load nvim-navic", "error", { title = "[nvim-navic.nvim] error" })
    return
end

--------------------------------------------------------------------------------
-- NOTE: to get the current client server name {{{
--------------------------------------------------------------------------------
local function get_client_name()
    local msg = "[No Active Lsp]"
    local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
        return msg
    end
    for _, client in ipairs(clients) do
        local filetypes = client.config.filetypes
        if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            -- return "[⚙ LSP: " .. client.name .. "]"
            return "[" .. client.name .. "]"
        end
    end
    return msg
end

-- }}}
--------------------------------------------------------------------------------

----------------------------------------------------------------------
-- NOTE: get session name {{{
----------------------------------------------------------------------
local function get_session_name()
    local session_name = auto_session_library.current_session_name()
    if session_name == nil then
        return "No Active Session"
    end
    -- return "[⚙ Session: " .. session_name .. "]"
    return "[" .. session_name .. "]"
end

-- }}}
----------------------------------------------------------------------

----------------------------------------------------------------------
-- NOTE: setup {{{
----------------------------------------------------------------------
lualine.setup({
    options = {
        theme = "gruvbox",
        globalstatus = true,
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
    },
    sections = {
        lualine_a = {
            {
                "mode",
                fmt = function(str)
                    return "<" .. str:sub(1, 1) .. ">"
                end,
            },
        },
        lualine_b = {
            {
                "branch",
                icon = "",
                separator = { right = "" },
            },
            {
                get_session_name,
                color = "LualineSessionName",
                separator = { right = "" },
            },
        },
        lualine_c = {
            -- "%=%=",
            { "filetype", icon_only = true },
            { "filename", path = 1, color = "LualineFileName" },
        },
        lualine_x = {
            {
                "diagnostics",
                sources = { "nvim_diagnostic" },
                symbols = {
                    error = " ",
                    warn = " ",
                    hint = " ",
                    info = " ",
                },
                update_in_insert = true,
            },
            { navic.get_location, cond = navic.is_available },
            { "filesize", color = "LualineFileSize" },
            { "filetype", color = "LualineFileType" },
            {
                get_client_name,
                color = "LualineSessionName",
                separator = { left = "" },
            },
        },
        lualine_y = { { "progress" } },
        lualine_z = { { "location" } },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { "filename", path = 0 } },
        lualine_x = { "filetype" },
        lualine_z = { "location" },
    },
    extensions = { "fzf", "fugitive", "nvim-tree", "quickfix", "toggleterm", "symbols-outline" },
})
