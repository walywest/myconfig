function ColorMyPencils(color)
    color = color or "rose-pine"
    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

local themes = {
    {
        "folke/tokyonight.nvim",
        config = function()
            require("tokyonight").setup({
                style = "moon",
                transparent = false,
                terminal_colors = true,
                styles = {
                    comments = { italic = true },
                    keywords = { italic = false },
                    sidebars = "dark",
                    floats = "dark",
                },
            })
            vim.cmd("colorscheme tokyonight-moon")
        end
    },
    {

        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            require('rose-pine').setup({
                disable_background = true,
            })
            ColorMyPencils()
        end
    },

    {
        'navarasu/onedark.nvim',
        -- Lua
        config = function()
            require('onedark').setup {
                style = 'deep',
                term_colors = true,
                transparent = false -- Enable this to disable setting the background color
            }
            require('onedark').load()
            ColorMyPencils('onedark')
        end
    },

    {
        "olimorris/onedarkpro.nvim",
        priority = 1000, -- Ensure it loads first
        config = function()
            -- require('onedark_vivid')
            -- require('onedark').setup()
            vim.cmd("colorscheme onedark_dark")
            ColorMyPencils('onedark_dark')
        end
    }

}

-- NOTE: theme : 1- folke folke, 2- rose-pine, 3- onedark, 4- onedarkpro

return {
    themes[1]
}
