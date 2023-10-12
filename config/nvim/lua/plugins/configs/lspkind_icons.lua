local icons = {
  misc = {
    dots = "󰇘",
  },
  diagnostics = {
    --lspSymbol("Error", "")
    --lspSymbol("Info", "")
    --lspSymbol("Hint", "")
    --lspSymbol("Warn", "")
    Error = " ",
    Warn = " ",
    Hint = " ",
    Info = " ",
  },
  dap = {

    Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
    Breakpoint = " ",
    BreakpointCondition = " ",
    BreakpointRejected = { " ", "DiagnosticError" },
    LogPoint = ".>",
  },
  git = {
    added = " ",
    modified = " ",
    removed = " ",
  },
  kinds = {
    Array = " ",
    Boolean = " ",
    Class = " ",
    Color = " ",
    Constant = " ",
    Constructor = " ",
    Enum = " ",
    EnumMember = " ",
    Event = " ",
    Field = " ",
    File = " ",
    Folder = " ",
    Function = " ",
    Interface = " ",
    Key = " ",
    Keyword = " ",
    Method = " ",
    Module = " ",
    Namespace = " ",
    Null = " ",
    Number = " ",
    Object = " ",
    Operator = " ",
    Package = " ",
    Property = " ",
    Reference = " ",
    Snippet = " ",
    String = " ",
    Struct = " ",
    Text = " ",
    TypeParameter = " ",
    Unit = " ",
    Value = " ",
    Variable = " ",
    Copilot = " ",
    Codeium = "󰘦 ",
    Table = " ",
    Tag = " ",
    Calendar = " ",
    --    Watch = " ",
    Variable = "󰀫 ",
  },
}

return icons
