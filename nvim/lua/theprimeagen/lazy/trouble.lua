return {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
        {
            "<leader>tt",
            "<cmd>Trouble diagnostics toggle<cr>",
            desc = "Diagnostics (Trouble)",
        },
        -- {
        --     "<leader>xX",
        --     "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        --     desc = "Buffer Diagnostics (Trouble)",
        -- },
        -- {
        --     "<leader>cs",
        --     "<cmd>Trouble symbols toggle focus=false<cr>",
        --     desc = "Symbols (Trouble)",
        -- },
        -- {
        --     "<leader>cl",
        --     "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        --     desc = "LSP Definitions / references / ... (Trouble)",
        -- },
        -- {
        --     "<leader>xL",
        --     "<cmd>Trouble loclist toggle<cr>",
        --     desc = "Location List (Trouble)",
        -- },
        {
            "<leader>qt",
            "<cmd>Trouble qflist toggle<cr>",
            desc = "Quickfix List (Trouble)",
        },
    },
}


-- return {
--     {
--         "folke/trouble.nvim",
--         config = function()
--             require("trouble").setup({
--                 icons = false,
--             })
--
--             vim.keymap.set("n", "<leader>tt", function()
--                 require("trouble").toggle()
--             end)
--
--             vim.keymap.set("n", "[t", function()
--                 require("trouble").next({skip_groups = true, jump = true});
--             end)
--
--             vim.keymap.set("n", "]t", function()
--                 require("trouble").previous({skip_groups = true, jump = true});
--             end)
--
--         end
--     },
-- }
