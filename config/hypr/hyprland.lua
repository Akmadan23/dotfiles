-- This is anmexample Hyprland config file.
-- Refer to the wiki for more information.
-- https://wiki.hyprland.org/Configuring/

-- Please note not all available settings / options are set here.
-- For a full list, see the wiki

-- You can split this configuration into multiple files
-- Create your files separately and then link them to this file like this:
-- source = ~/.config/hypr/myColors.conf

----------------
--- MONITORS ---
----------------

-- See https://wiki.hyprland.org/Configuring/Monitors/
hl.monitor {
    output = "eDP-1",
    mode = "1920x1080",
    position = "-1600x100",
    scale = 1.2,
}

hl.monitor {
    output = "HDMI-A-1",
    mode = "1920x1080",
    -- mode = "1360x768",
    position = "0x0",
}

-----------------
--- AUTOSTART ---
-----------------

hl.on("hyprland.start", function()
    -- Autostart necessary processes (like notifications daemons, status bars, etc.)
    local autostart = {
        -- "uwsm finalize",
        -- "hypridle",
        "waybar",
        "nm-applet",
        "udiskie -At",
        "swayosd-server",
        "wl-paste -t text --watch clipman store",
    }

    for _, cmd in ipairs(autostart) do
        hl.exec_cmd(cmd)
    end
end)

hl.on("config.reloaded", function()
    hl.exec_cmd("notify-send 'Hyprland' 'Config reloaded'")
end)

-----------------------------
--- ENVIRONMENT VARIABLES ---
-----------------------------

-- See https://wiki.hyprland.org/Configuring/Environment-variables/

local env = {
    XCURSOR_SIZE = 20,
    HYPRCURSOR_SIZE = 20,
    ELECTRON_OZONE_PLATFORM_HINT = "auto",
    GDK_BACKEND = "wayland",
    XDG_CURRENT_DESKTOP = "Hyprland",
    XDG_SESSION_DESKTOP = "Hyprland",
    XDG_SESSION_TYPE = "wayland",
    LIBVA_DRIVER_NAME = "nvidia",
    __GLX_VENDOR_LIBRARY_NAME = "nvidia",
}

for name, val in pairs(env) do
    hl.env(name, val)
end

-- https://wiki.hyprland.org/Configuring/Variables/#general
hl.config {
    general = {
        border_size = 2,
        gaps_in = 5,
        gaps_out = 5,

        -- https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
        col = {
            active_border = {
                colors = { "#66D8EFee", "#A6E22Eee" },
                angle = 45
            },
            inactive_border = "#595959aa",
        },

        -- Set to true enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,

        -- Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
        allow_tearing = false,

        no_focus_fallback = false,

        layout = "master",
        -- layout = "lua:columns",
    },

    group = {
        col = {
            border_active = {
                colors = { "#E6DB74ee", "#FD971Fee" },
                angle = 45
            },
            border_inactive = "#595959aa",
        },

        groupbar = {
            render_titles = false,
            col = {
                active = "#E6DB74ee",
                inactive = "#595959aa",
            },
        },
    },

    -- https://wiki.hyprland.org/Configuring/Variables/#decoration
    decoration = {
        rounding = 8,
        rounding_power = 2,

        -- Change transparency of focused and unfocused windows
        active_opacity = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = "#1a1a1aee",
        },

        -- https://wiki.hyprland.org/Configuring/Variables/#blur
        blur = {
            enabled = true,
            size = 3,
            passes = 1,
            vibrancy = 0.1696,
        },
    },

    -- https://wiki.hyprland.org/Configuring/Variables/#animations
    animations = {
        enabled = true,
    },

    -- https://wiki.hyprland.org/Configuring/Variables/#input
    input = {
        kb_layout = "it",
        kb_options = "caps:escape_shifted_capslock",

        focus_on_close = 1,
        follow_mouse = 1,

        sensitivity = 0.75, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = true,
        }
    },

    -- See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
    dwindle = {
        preserve_split = false, -- You probably want this
        force_split = 2,
    },

    -- See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
    master = {
        new_status = "slave",
        new_on_active = "after",
        mfact = 0.5,
        allow_small_split = true,
    },

    -- https://wiki.hyprland.org/Configuring/Variables/#misc
    misc = {
        disable_autoreload = true,
        disable_hyprland_logo = false, -- If true disables the random hyprland logo / anime girl background. :(
        font_family = "Cantarell",
        force_default_wallpaper = 1, -- Set to 0 or 1 to disable the anime mascot wallpapers
        on_focus_under_fullscreen = 2,
    },

    xwayland = {
        force_zero_scaling = true,
    },
}

require("modules.animations")
require("modules.keybinds")
require("modules.rules")
