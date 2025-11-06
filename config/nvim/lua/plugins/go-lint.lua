return {
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = function(_, opts)
      opts.linters_by_ft = opts.linters_by_ft or {}
      if opts.linters_by_ft.go ~= nil then
        opts.linters_by_ft.go = nil
      end
    end,
  },
}
