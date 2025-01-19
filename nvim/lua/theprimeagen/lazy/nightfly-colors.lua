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
                -- your configuration comes here
                -- or leave it empty to use the default settings
                --style = "storm",        -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
                style = "night",     -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
                transparent = false, -- Enable this to disable setting the background color
                -- terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
                styles = {
                    -- Style to be applied to different syntax groups
                    -- Value is any valid attr-list value for `:help nvim_set_hl`
                    comments = { italic = false },
                    keywords = { italic = false },
                    -- Background styles. Can be "dark", "transparent" or "normal"
                    sidebars = "dark", -- style for sidebars, see below
                    floats = "dark",   -- style for floating windows
                },
            })
            vim.cmd("colorscheme tokyonight")
            ColorMyPencils("tokyonight")
        end
    },

    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            require('rose-pine').setup({
                disable_background = true,
            })
            vim.cmd("colorscheme rose-pine")
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
            -- ColorMyPencils('onedark')
        end
    },
    -- Lazy
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

    -- somewhere in your config:


}

-- NOTE: theme : 1- folke folke, 2- rose-pine, 3- onedark, 4- onedarkpro

return {
    themes[3]

}
