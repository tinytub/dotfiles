--local ok, schema = pcall(require, "schemastore")
--if not ok then return end

return {
  --settings = {
  --  json = {
  --    schemas = schema.json.schemas(),
  --  },
  --},
  setup = {
    commands = {
      Format = {
        function()
          vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line "$", 0 })
        end,
      },
    },
  },
}
