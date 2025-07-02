return {

    'mfussenegger/nvim-dap',

    --Setting breakpoints via :

    config = function()
        --NOTE: keymaps
        local dap= require("dap")
        vim.keymap.set("n", "<leader>db", function()
            dap.toggle_breakpoint()
        end)
        vim.keymap.set("n", "<leader>dc", function()
            dap.continue()
        end)
        vim.keymap.set("n", "<leader>dn", function()
            dap.step_into()
        end)
        -- If using the above, then `/path/to/venv/bin/python -m debugpy --version`
        -- must work in the shell

        -- Inspecting the state via the built-in REPL: :lua dap.repl.open() or using the widget UI (:help dap-widgets)
        vim.keymap.set("n", "<leader>ds", function()
            dap.repl.open()
        end)
    end
}
