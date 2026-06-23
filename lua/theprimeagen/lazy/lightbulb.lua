return {
    "kosayoda/nvim-lightbulb",
    event = "LspAttach",
    opts = {
        autocmd = { enabled = true, updatetime = 0 },
        hide_in_unfocused_buffer = false,
        ignore = {
            ft = { "NvimTree", "lazy", "mason", "help", "trouble" },
            bo = { buftype = { "nofile", "terminal", "prompt" } },
        },
        sign = {
            enabled = true,
            text = "󰌶",
            hl = "LightBulbSign",
        },
        virtual_text = { enabled = false },
        float = { enabled = false },
        status_text = { enabled = false },
    },
}
