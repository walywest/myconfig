return {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("bufferline").setup({
            options = {
                mode = "buffers",
                numbers = "none",
                close_command = "bdelete %d",
                right_mouse_command = "bdelete %d",
                left_mouse_command = "buffer %d",
                indicator = { style = "icon", icon = "▎" },
                buffer_close_icon = "󰅖",
                modified_icon = "●",
                close_icon = "",
                left_trunc_marker = "",
                right_trunc_marker = "",
                show_buffer_close_icons = true,
                show_close_icon = false,
                show_tab_indicators = true,
                persist_buffer_sort = true,
                separator_style = "thin",
                always_show_bufferline = true,
                offsets = {
                    {
                        filetype = "NvimTree",
                        text = "File Explorer",
                        text_align = "center",
                        separator = true,
                    },
                },
            },
        })

        vim.keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<CR>")
        vim.keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<CR>")
    end,
}
