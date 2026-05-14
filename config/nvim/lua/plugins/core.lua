return {
  { "folke/lazy.nvim", version = false },
  {
    "LazyVim/LazyVim",
    version = false,
    opts = function(_, opts)
      opts.colorscheme = "catppuccin"
    end,
    --opts = {
    --  colorscheme = "catppuccin",
    --},
  },
}
