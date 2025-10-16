return {
    "mfussenegger/nvim-dap-python",
    dependencies = 'mfussenegger/nvim-dap',

    config = function()
        local dapython, dap = require("dap-python"), require("dap")
        dapython.test_runner = "pytest"
        dapython.setup("/home/dumbledoor/.local/share/nvim/mason/bin/debugpy-adapter")
        table.insert(dap.configurations.python, {
            type = 'python',
            request = 'attach',
            name = 'Attach to Flask',
            connect = {
                host = '127.0.0.1',
                port = 5678
            },
            pathMappings = {
                {
                    localRoot = vim.fn.getcwd(),
                    remoteRoot = "."
                }
            },
            justMyCode = true, -- Set to true if you only want to debug your code
        })

        vim.keymap.set('n', '<leader>tc', dapython.test_class, { desc = 'Debug Test Class' })
    end
}
