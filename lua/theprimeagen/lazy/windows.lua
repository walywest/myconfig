return {
    "anuvyklack/windows.nvim",
    dependencies = {
        "anuvyklack/middleclass",
        "anuvyklack/animation.nvim"
    },
    config = function()
        vim.o.winwidth = 10
        vim.o.winminwidth = 10
        vim.o.equalalways = false
        require('windows').setup()

        local function cmd(command)
            return table.concat({ '<Cmd>', command, '<CR>' })
        end

        vim.keymap.set("n", "<leader>ww", cmd "WindowsMaximize")
        vim.keymap.set("n", "<leader>mi", cmd "WindowsMaximizeVertically")
        vim.keymap.set("n", "<leader>hh", cmd "WindowsMaximizeHorizontally")
        vim.keymap.set("n", "<leader>=", cmd "WindowsEqualize")

        vim.keymap.set("n", "<leader>l",    "<C-w><Right>")
        vim.keymap.set("n", "<leader>k",    "<C-w><Up>")
        vim.keymap.set("n", "<leader>j",    "<C-w><Down>")
        vim.keymap.set("n", "<leader><BS>", "<C-w><Left>")

        vim.keymap.set({ "n", "t" }, "`k", "<C-w><Up>")
        vim.keymap.set({ "n", "t" }, "`j", "<C-w><Down>")
    end
}
