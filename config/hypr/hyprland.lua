-- Hyprland Lua config (0.55.2+)
-- Translated from legacy .conf format

-- MONITOR
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = 1.0,
})

-- PROGRAMS
local terminal    = "foot"
local fileManager = "dolphin"
local menu        = "wofi --show drun"
local bluetooth   = "blueman-manager"
local browser     = "flatpak run com.google.Chrome"

-- AUTOSTART
hl.on("hyprland.start", function()
    hl.exec_cmd(terminal)
    hl.exec_cmd("waybar")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("nm-applet --indicator")
end)

-- ENVIRONMENT VARIABLES
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")

-- LOOK AND FEEL
hl.config({
    general = {
        gaps_in     = 2,
        gaps_out    = 2,
        border_size = 1,

        col = {
            active_border   = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },

        resize_on_border = false,
        allow_tearing    = false,
        layout           = "dwindle",
    },

    decoration = {
        rounding         = 0,
        rounding_power   = 0,
        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        blur = {
            enabled  = true,
            size     = 3,
            passes   = 1,
            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        -- pseudotile was removed in Hyprland 0.55; pseudotiling is always available via the dispatcher
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo   = false,
    },

    input = {
        kb_layout    = "us",
        kb_variant   = "",
        kb_model     = "",
        kb_options   = "",
        kb_rules     = "",
        follow_mouse = 1,
        sensitivity  = 0.5,
        repeat_rate  = 35,
        repeat_delay = 200,

        touchpad = {
            natural_scroll = false,
        },
    },

    cursor = {
        inactive_timeout    = 30,
        no_hardware_cursors = true,
    },
})

-- ANIMATIONS
hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })

hl.animation({ leaf = "windows",    enabled = true, speed = 7,  bezier = "myBezier" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 7,  bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border",     enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "fade",       enabled = true, speed = 7,  bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 6,  bezier = "default" })

-- PER-DEVICE CONFIG
hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})

-- KEYBINDINGS
local mainMod = "SUPER"
local alt     = "ALT"

hl.bind(alt .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(alt .. " + Q",      hl.dsp.window.close())
hl.bind(mainMod .. " + M",  hl.dsp.exit())
hl.bind(alt .. " + E",      hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V",  hl.dsp.window.float({ action = "toggle" }))
hl.bind(alt .. " + SPACE",  hl.dsp.exec_cmd(menu))
hl.bind(alt .. " + B",      hl.dsp.exec_cmd(bluetooth))
hl.bind(mainMod .. " + N",  hl.dsp.exec_cmd("networkmanager_dmenu"))
hl.bind(alt .. " + G",      hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + P",  hl.dsp.window.pseudo())

-- Window switcher
hl.bind("CTRL + SPACE", hl.dsp.exec_cmd("rofi -show window"))

-- Focus movement (vim-style)
hl.bind(alt .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(alt .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(alt .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(alt .. " + j", hl.dsp.focus({ direction = "down" }))

-- Workspace switching and window moving
for i = 1, 10 do
    local key = i % 10
    hl.bind(alt .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(alt .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Special workspace (scratchpad)
hl.bind(alt .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(alt .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through workspaces
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Volume controls (with notify-send feedback, as in the old .conf)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd([[wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+ && notify-send -h string:x-canonical-private-synchronous:volume -u low "Volume: $(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2*100)}')%"]]), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd([[wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%- && notify-send -h string:x-canonical-private-synchronous:volume -u low "Volume: $(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2*100)}')%"]]), { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd([[wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && notify-send -h string:x-canonical-private-synchronous:volume -u low "Volume: $(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q MUTED && echo Muted || echo Unmuted)"]]), { locked = true })

-- Brightness controls (with notify-send feedback, as in the old .conf)
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd([[brightnessctl set +5% && notify-send -h string:x-canonical-private-synchronous:brightness -u low "Brightness: $(brightnessctl get)%"]]), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd([[brightnessctl set 5%- && notify-send -h string:x-canonical-private-synchronous:brightness -u low "Brightness: $(brightnessctl get)%"]]), { locked = true, repeating = true })

-- WINDOW RULES
hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})
