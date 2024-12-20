return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },

    config = function()
        local harpoon = require('harpoon')
        --harpoon:setup({})
        harpoon:setup({
            -- Setting up custom behavior for a list named "cmd"
            cmd = {

                -- When you call list:append() this function is called and the return
                -- value will be put in the list at the end.
                --
                -- which means same behavior for prepend except where in the list the
                -- return value is added
                --
                -- @param possible_value string only passed in when you alter the ui manual
                add = function(possible_value)
                    -- get the current line idx
                    local idx = vim.fn.line(".")

                    -- read the current line
                    local cmd = vim.api.nvim_buf_get_lines(0, idx - 1, idx, false)[1]
                    if cmd == nil then
                        return nil
                    end

                    return {
                        value = cmd,
                        context = {},
                    }
                end,

                --- This function gets invoked with the options being passed in from
                --- list:select(index, <...options...>)
                --- @param list_item {value: any, context: any}
                --- @param list { ... }
                --- @param option any
                select = function(list_item, list, option)
                    -- WOAH, IS THIS HTMX LEVEL XSS ATTACK??
                    vim.cmd(list_item.value)
                end

            }
        })

        harpoon:extend({
            UI_CREATE = function(cx)
                vim.keymap.set("n", "<C-v>", function()
                    harpoon.ui:select_menu_item({ vsplit = true })
                end, { buffer = cx.bufnr })

                vim.keymap.set("n", "<C-x>", function()
                    harpoon.ui:select_menu_item({ split = true })
                end, { buffer = cx.bufnr })

                vim.keymap.set("n", "<C-t>", function()
                    harpoon.ui:select_menu_item({ tabedit = true })
                end, { buffer = cx.bufnr })
            end,
        })

        -- basic telescope configuration
        local conf = require("telescope.config").values

        local function toggle_telescope(harpoon_files)
            local file_paths = {}
            for _, item in ipairs(harpoon_files.items) do
                table.insert(file_paths, item.value)
            end

            require("telescope.pickers").new({}, {
                prompt_title = "Harpoon",
                finder = require("telescope.finders").new_table({
                    results = file_paths,
                }),
                previewer = conf.file_previewer({}),
                sorter = conf.generic_sorter({}),
            }):find()
        end

        vim.keymap.set("n", "<leader>e", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

        vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end)

        vim.keymap.set("n", "<leader>r", function() harpoon:list():remove() end)
        vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

        vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
        vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
        vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
        vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)

        -- Toggle previous & next buffers stored within Harpoon list
        vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
        vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
    end

}
