return {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("bufferline").setup({
            options = {
                mode = "tabs",
                numbers = "none",
                indicator = { style = "underline" },
                modified_icon = "●",
                show_buffer_close_icons = false,
                show_close_icon = false,
                show_buffer_icons = true,
                color_icons = true,
                separator_style = "thin",
                always_show_bufferline = true,
                left_mouse_command = function(id)
                    vim.api.nvim_set_current_tabpage(id)
                end,
                close_command = function(id)
                    vim.cmd("tabclose " .. vim.api.nvim_tabpage_get_number(id))
                end,
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
    end,
}
