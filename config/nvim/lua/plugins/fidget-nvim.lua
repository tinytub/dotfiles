require("fidget").setup({
    text = {
        spinner = 'dots_pulse',
        done = "✔",
        commenced = "Started",
        completed = "Completed",
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
