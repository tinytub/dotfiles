--local ok, schema = pcall(require, "schemastore")
--if not ok then return end

return {
  -- lazy-load schemastore when needed
  on_new_config = function(new_config)
    new_config.settings.json.schemas = new_config.settings.json.schemas or {}
    vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
  end,
  settings = {
    json = {
      --schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
      format = {
        enable = true,
      },
    },
  },
}
