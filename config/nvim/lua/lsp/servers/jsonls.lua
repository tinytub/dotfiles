--local ok, schema = pcall(require, "schemastore")
--if not ok then return end

return {
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      --      validate = { enable = true },
    },
  },
}
