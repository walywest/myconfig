return
{
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
        enable = true,                -- Enable the plugin
        max_lines = 3,                -- How many lines to show
        min_window_height = 5,        -- Minimum window height to show context
        line_numbers = true,          -- Show line numbers in context
        multiline_threshold = 20,     -- Maximum lines for a single context line
    },
    keys = {
        {
            "<leader>ct",
            function()
                local tsc = require("treesitter-context")
                tsc.toggle()
            end,
            desc = "Toggle Treesitter Context",
        },
    },
}
