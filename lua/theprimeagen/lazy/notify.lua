-- ~/.config/nvim/init.lua or ~/.config/nvim/lua/plugins.lua
return {
    "rcarriga/nvim-notify",
    opts = {
        timeout = 3000,                    -- Default timeout (ms)
        render = "compact",                -- "default", "minimal", "simple", "compact"
        stages = "fade_in_slide_out",      -- Animation style
        background_colour = "#1a1b26",     -- Background color (optional)
    },
}
