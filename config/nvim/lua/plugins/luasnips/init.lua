local present, luasnip = pcall(require, "luasnip")
if present then
    luasnip.snippets = {
      --all = require("settings.luasnip.all"),
      go = require("plugins.luasnips.go"),
      --lua = require("settings.luasnip.lua"),
      --gitcommit = require("settings.luasnip.gitcommit"),
      --markdown = require("settings.luasnip.markdown"),
    }


    luasnip.config.set_config {
       history = true,
       updateevents = "TextChanged,TextChangedI",
    }

    require("luasnip/loaders/from_vscode").load()
end

