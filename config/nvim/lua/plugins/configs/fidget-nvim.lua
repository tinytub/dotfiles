require("fidget").setup({
  text = {
    --        spinner = 'dots_pulse',
    spinner = {
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
      " ",
    },

    done = "✔",
    --  commenced = "Started",
    --  completed = "Completed",
    commenced = " ", -- message shown when task starts
    completed = " ", -- message shown when task completes
  },
  align = {
    bottom = true, -- align fidgets along bottom edge of buffer
    right = true, -- align fidgets along right edge of buffer
  },
  timer = {
    spinner_rate = 100, -- frame rate of spinner animation, in ms
    fidget_decay = 2000, -- how long to keep around empty fidget, in ms
    task_decay = 1000, -- how long to keep around completed task, in ms
  },
  window = {
    relative = "editor", -- where to anchor the window, either `"win"` or `"editor"`
    blend = 100, -- `&winblend` for the window
    zindex = nil, -- the `zindex` value for the window
  },

  fmt = {
    leftpad = true, -- right-justify text in fidget box
    stack_upwards = true, -- list of tasks grows upwards
    max_width = 0, -- maximum width of the fidget box
    fidget = -- function to format fidget title
    function(fidget_name, spinner)
      return string.format("%s %s", spinner, fidget_name)
    end,
    task = -- function to format each task line
    function(task_name, message, percentage)
      return string.format(
        "%s%s [%s]",
        message,
        percentage and string.format(" (%s%%)", percentage) or "",
        task_name
      )
    end,
  },
})
