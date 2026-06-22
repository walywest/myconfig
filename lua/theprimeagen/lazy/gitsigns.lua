return {
    "lewis6991/gitsigns.nvim",
    config = function()
        require("gitsigns").setup({
            signs = {
                add          = { text = "▎" },
                change       = { text = "▎" },
                delete       = { text = "▸" },
                topdelete    = { text = "▾" },
                changedelete = { text = "▎" },
            },
            current_line_blame = true,
            current_line_blame_opts = {
                delay = 800,
                virt_text_pos = "eol",
            },
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns
                local opts = { buffer = bufnr }

                vim.keymap.set("n", "]h", gs.next_hunk, opts)
                vim.keymap.set("n", "[h", gs.prev_hunk, opts)
                vim.keymap.set("n", "<leader>hs", gs.stage_hunk, opts)
                vim.keymap.set("v", "<leader>hs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, opts)
                vim.keymap.set("n", "<leader>hr", gs.reset_hunk, opts)
                vim.keymap.set("v", "<leader>hr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, opts)
                vim.keymap.set("n", "<leader>hp", gs.preview_hunk, opts)
                vim.keymap.set("n", "<leader>hb", function() gs.blame_line({ full = true }) end, opts)
            end,
        })
    end,
}
