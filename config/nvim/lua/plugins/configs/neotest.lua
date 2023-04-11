-- get neotest namespace (api call creates or returns namespace)
local neotest_ns = vim.api.nvim_create_namespace "neotest"
vim.diagnostic.config({
  virtual_text = {
    format = function(diagnostic)
      local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
      return message
    end,
  },
}, neotest_ns)
require('neotest').setup({
  discovery = {
    enabled = false,
  },
  summary = {
    mappings = {
      expand = { "l", "zo", "za" },
      expand_all = { "e", "zO" },
      mark = { "<Tab>", "m", "<Space>" },
      jumpto = { "i", "<CR>", "<2-LeftMouse>" },
    },
  },
  output = {
    open_on_run = false,
  },
  icons = {
    child_indent = " ",
    child_prefix = " ",
    expanded = " ",
    final_child_prefix = " ",
    collapsed = " ",
    non_collapsible = " ",
    running_animated = { "◴", "◷", "◶", "◵" },
    passed = "",
    failed = "",
    running = "",
    skipped = "",
    unknown = "",
  },
  adapters = {
    require("neotest-plenary"),
    require("neotest-python"),
    require('neotest-go')({
      -- args = { '-race' },
      args = { "-count=1", "-timeout=60s" },
      experimantal = {
        test_table = true,
      },
    }),
  }
})

vim.api.nvim_create_user_command('Neotest', function()
  require('neotest').run.run()
end, { desc = 'Neotest: run nearest test' })

vim.api.nvim_create_user_command('NeotestFile', function()
  require('neotest').run.run(vim.fn.expand '%')
end, { desc = 'Neotest: run the current file' })

vim.api.nvim_create_user_command('NeotestStop', function()
  require('neotest').run.stop()
end, { desc = 'Neotest: stop the nearest test' })

vim.keymap.set('n', '<leader>tf', function()
  require('neotest').run.run(vim.fn.expand '%')
end, { desc = 'Neotest: run all tests in file' })

vim.keymap.set('n', '<leader>tn', function()
  require('neotest').run.run()
end, { desc = 'Neotest: run nearest test' })

vim.keymap.set('n', '<leader>tl', function()
  require('neotest').run.run_last()
end, { desc = 'Neotest: run last test' })

vim.keymap.set('n', '<leader>ts', function()
  require('neotest').summary.toggle()
end, { desc = 'Neotest: toggle summary' })

vim.keymap.set('n', '<leader>to', function()
  require('neotest').output.open { enter = true }
end, { desc = 'Neotest: show test output' })

vim.keymap.set('n', '<leader>tp', function()
  require('neotest').output_panel.toggle()
end, { desc = 'Neotest: show test output' })
