return {
    'nvim-flutter/flutter-tools.nvim',
    lazy = false,
    dependencies = {
        'nvim-lua/plenary.nvim',
        'stevearc/dressing.nvim',     -- optional for vim.ui.select
    },
    config = true,

    --     config = function()
    --         require("telescope").load_extension("flutter")
    --     end
}
