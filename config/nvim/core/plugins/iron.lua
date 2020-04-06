local iron = require('iron')

iron.core.add_repl_definitions {
  go = {
    mycustom = {
      command = {"gore"}
    }
  }
}

iron.core.set_config {
  preferred = {
    go = "gore",
    python = "ipython",
    typescript = "ts-node",
    javascript = "node"
  }
}
