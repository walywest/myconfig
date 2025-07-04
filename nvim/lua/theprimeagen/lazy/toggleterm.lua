return
{
    "akinsho/toggleterm.nvim",
    version = '*',
    config = function()
        --require("toggleterm").setup()


        vim.keymap.set({ "n", "i", "t" }, "`n", ":ToggleTermSetName<CR>")
        require("toggleterm").setup({

            -- size can be a number or function which is passed the current terminal
            size = function(term)
                if term.direction == "horizontal" then
                    return 15
                elseif term.direction == "vertical" then
                    return vim.o.columns * 0.4
                end
            end,
            open_mapping = [[`[]],

            --highlights = {
            --    -- highlights which map to a highlight group name and a table of it's values
            --    -- NOTE: this is only a subset of values, any group placed here will be set for the terminal window split
            --    Normal = {
            --        guibg = "<VALUE-HERE>",
            --    },
            --    NormalFloat = {
            --        link = 'Normal'
            --    },
            --    FloatBorder = {
            --        guifg = "<VALUE-HERE>",
            --        guibg = "<VALUE-HERE>",
            --    },
            --},

            start_in_insert = true,
            insert_mappings = true,   -- whether or not the open mapping applies in insert mode
            terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
            persist_size = true,
            persist_mode = true,      -- if set to true (default) the previous terminal mode will be remembered
            direction = 'float',
            close_on_exit = true,     -- close the terminal window when the process exits
            -- Change the default shell. Can be a string or a function returning a string
            shell = vim.fn.exepath("zsh"), -- Absolute path to Zsh
            -- Optional: Add args to ensure Zsh loads your configs
            -- shell_args = { "-l" }, -- Login shell (loads .zprofile, .zshrc)

            auto_scroll = true,  -- automatically scroll to the bottom on terminal output
            -- This field is only relevant if direction is set to 'float'
            float_opts = {
                -- The border key is *almost* the same as 'nvim_open_win'
                -- see :h nvim_open_win for details on borders however
                -- the 'curved' border is a custom border type
                -- not natively supported but implemented in this plugin.
                border = 'curved', -- like `size`, width, height, row, and col can be a number or function which is passed the current terminal
                title_pos = 'center'
            },
            winbar = {
                enabled = false,
                name_formatter = function(term) --  term: Terminal
                    return term.name
                end
            },
        })
    end
}
