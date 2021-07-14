-- autoformat
--if O.format_on_save then
  require("plugins.utils").define_augroups {
    autoformat = {
      {
        "BufWritePre",
        "*",
        [[try | undojoin | Neoformat | catch /^Vim\%((\a\+)\)\=:E790/ | finally | silent Neoformat | endtry]],
       -- "undojoin | Neoformat",
      },
    },
  }
--end

--if not O.format_on_save then
--  vim.cmd ":autocmd! autoformat"
--end
