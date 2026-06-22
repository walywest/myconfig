return {
    "kosayoda/nvim-lightbulb",
    event = "LspAttach",
    opts = {
        autocmd = { enabled = true, updatetime = 0 },
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
