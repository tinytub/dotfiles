return {
  "mikesmithgh/kitty-scrollback.nvim",
  enabled = true,
  lazy = true,
  cmd = { "KittyScrollbackGenerateKittens", "KittyScrollbackCheckHealth" },
  event = { "User KittyScrollbackLaunch" },
  -- version = '*', -- latest stable version, may have breaking changes if major version changed
  -- version = '^2.0.0', -- pin major version, include fixes and features that do not have breaking changes
  config = function()
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("kitty_scrollbackclose_with_q", { clear = true }),
      callback = function(event)
        vim.keymap.set({ "n" }, "q", "<Plug>(KsbCloseOrQuitAll)", {})
      end,
    })

    vim.o.mouse = "a"
    vim.o.clipboard = "unnamedplus"

    require("kitty-scrollback").setup({
      global = function()
        return {
          status_window = {
            icons = {
              nvim = "",
            },
          },
          --         keymaps_custom = function()
          --           vim.keymap.set({ "n" }, "q", "<Plug>(KsbCloseOrQuitAll)", {})
          --         end,
        }
      end,
    })
  end,
}
