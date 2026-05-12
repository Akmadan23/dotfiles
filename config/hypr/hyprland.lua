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

hl.on("hyprland.start", function()
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

---------------------
--- LOOK AND FEEL ---
---------------------

-- Refer to https://wiki.hyprland.org/Configuring/Variables/
hl.config {
    -- https://wiki.hyprland.org/Configuring/Variables/#general
    general = {
        border_size = 2,
        gaps_in = 5,
        gaps_out = 5,

        -- https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
        col = {
            active_border = { colors = { "rgba(66D8EFee)", "rgba(A6E22Eee)" }, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },

        -- Set to true enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,

        -- Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
        allow_tearing = false,

        no_focus_fallback = false,

        layout = "master",
    },

    group = {
        col = {
            border_active = { colors = { "rgba(E6DB74ee)", "rgba(FD971Fee)" }, angle = 45 },
            border_inactive = "rgba(595959aa)",
        },

        groupbar = {
            render_titles = false,
            col = {
                active = "rgba(E6DB74ee)",
                inactive = "rgba(595959aa)",
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
            color = "rgba(1a1a1aee)",
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

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

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

    -- render = {
    --     cm_enabled = false,
    -- },
}

-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })

-- Default springs
hl.curve("easy",           { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true,  speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 4.1,  spring = "easy",         style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true,  speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 7,    bezier = "quick" })

------------------
--- SMART GAPS ---
------------------

hl.window_rule {
    match = {
        workspace = "w[tv1]s[false]",
        float = false,
    },

    border_size = 0,
    rounding = 0,
}

hl.window_rule {
    match = {
        workspace = "f[1]s[false]",
        float = false,
    },

    border_size = 0,
    rounding = 0,
}

hl.workspace_rule {
    workspace = "w[tv1]s[false]",
    gaps_out = 0,
    gaps_in = 0,
}

hl.workspace_rule {
    workspace = "f[1]s[false]",
    gaps_out = 0,
    gaps_in = 0,
}

-- Big gaps in special workspace
hl.workspace_rule {
    workspace = "s[true]",
    gaps_out = 100,
}

-------------------
--- KEYBINDINGS ---
-------------------

-- See https://wiki.hyprland.org/Configuring/Keywords/
local mod = "SUPER + "
local s_mod = "SUPER + SHIFT + "
local c_mod = "SUPER + CONTROL + "
local alt = "ALT + "
local s_alt = "ALT + SHIFT + "
local c_alt = "ALT + CTRL + "
local sc_alt = "ALT + SHIFT + CONTROL + "

local term = "kitty"

-- Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
local binds = {
    { mod  .. "RETURN", hl.dsp.exec_cmd(term) },
    { mod   .. "SPACE", hl.dsp.exec_cmd("wofi -S drun") },
    { s_mod .. "SPACE", hl.dsp.exec_cmd("rofimoji -a copy") },
    { s_mod .. "R",     hl.dsp.exec_cmd("hyprctl reload") },
    { s_mod .. "W",     hl.dsp.exec_cmd("killall waybar; waybar") },
    { s_mod .. "C",     hl.dsp.exec_cmd("hyprpicker -a") },
    { s_mod .. "Q",     hl.dsp.window.close() },
    { s_mod .. "P",     hl.dsp.window.pin() },
    { s_mod .. "F",     hl.dsp.window.float() },
    { mod   .. "COMMA", hl.dsp.focus { monitor = "+1" } },
    { mod   .. "TAB",   hl.dsp.window.fullscreen() },
    { c_alt .. "TAB",   hl.dsp.group.next() },
    { sc_alt .. "TAB",  hl.dsp.group.prev() },

    -- Master layoutmsgs
    { alt   .. "TAB",   hl.dsp.layout("cyclenext") },
    { s_alt .. "TAB",   hl.dsp.layout("cycleprev") },
    { s_mod .. "M",     hl.dsp.layout("addmaster") },
    { c_mod .. "M",     hl.dsp.layout("removemaster") },

    -- Move focus with mod + HJKL
    { mod .. "H", hl.dsp.focus { direction = "l" } },
    { mod .. "L", hl.dsp.focus { direction = "r" } },
    { mod .. "K", hl.dsp.focus { direction = "u" } },
    { mod .. "J", hl.dsp.focus { direction = "d" } },

    -- Swap windows with shift + mod + HJKL
    { s_mod .. "H", hl.dsp.window.swap { direction = "l" } },
    { s_mod .. "L", hl.dsp.window.swap { direction = "r" } },
    { s_mod .. "K", hl.dsp.window.swap { direction = "u" } },
    { s_mod .. "J", hl.dsp.window.swap { direction = "d" } },
    { s_mod .. "G", hl.dsp.group.toggle() },

    -- Applications
    -- $mod, F, exec, firefox
    { mod .. "F",  hl.dsp.exec_cmd("zen-browser") },
    { mod .. "X",  hl.dsp.exec_cmd("firefox -P extra") },
    { mod .. "C",  hl.dsp.exec_cmd("qalculate-gtk") },
    { mod .. "E",  hl.dsp.exec_cmd(term .. " -e josh") },

    { s_mod .. "E",  hl.dsp.exec_cmd("~/.config/wofi/scripts/power.sh") },
    { s_mod .. "D",  hl.dsp.exec_cmd("~/.config/wofi/scripts/dotfiles.sh") },
    { s_mod .. "V",  hl.dsp.exec_cmd("clipman pick -t wofi") },
    { s_mod .. "N",  hl.dsp.exec_cmd("networkmanager_dmenu") },

    -- Screenshot
    { mod .. "S",  hl.dsp.exec_cmd("slurp | grim -g-") },
    { s_mod .. "S",  hl.dsp.exec_cmd("slurp | grim -g- - | wl-copy") },

    -- Example special workspace (scratchpad)
    { mod .. "BACKSLASH", hl.dsp.workspace.toggle_special("magic") },
    { s_mod .. "BACKSLASH", hl.dsp.window.move { workspace = "special:magic" } },

    -- Move/resize windows with mod + LMB/RMB and dragging
    { mod .. "mouse:272", hl.dsp.window.drag(), { mouse = true } },
    { mod .. "mouse:273", hl.dsp.window.resize(), { mouse = true } },

    -- Scroll through existing workspaces with mod + scroll
    -- { mod .. "mouse_down", workspace, e+1 },
    -- { mod .. "mouse_up", workspace, e-1 },

    -- Laptop multimedia keys for volume and LCD brightness
    { "XF86AudioRaiseVolume",   hl.dsp.exec_cmd("swayosd-client --output-volume=+5"),           { locked = true, repeating = true } },
    { "XF86AudioLowerVolume",   hl.dsp.exec_cmd("swayosd-client --output-volume=-5"),           { locked = true, repeating = true } },
    { "XF86AudioMute",          hl.dsp.exec_cmd("swayosd-client --output-volume=mute-toggle"),  { locked = true, repeating = true } },
    { "XF86AudioMicMute",       hl.dsp.exec_cmd("swayosd-client --input-volume=mute-toggle"),   { locked = true, repeating = true } },
    { "XF86MonBrightnessUp",    hl.dsp.exec_cmd("swayosd-client --brightness=+5"),              { locked = true, repeating = true } },
    { "XF86MonBrightnessDown",  hl.dsp.exec_cmd("swayosd-client --brightness=-5"),              { locked = true, repeating = true } },
}

for _, bind in ipairs(binds) do
    hl.bind(bind[1], bind[2], bind[3] or {})
end

for i = 1, 10 do
    local key = i % 10
    hl.bind(mod .. key, hl.dsp.focus { workspace = i, on_current_monitor = true })
    hl.bind(s_mod .. key, hl.dsp.window.move { workspace = i, follow = true })
    hl.bind(c_mod .. key, hl.dsp.window.move { workspace = i, follow = false })
end

------------------------------
--- WINDOWS AND WORKSPACES ---
------------------------------

-- See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
-- See https://wiki.hyprland.org/Configuring/Workspace-Rules/ for workspace rules

hl.window_rule {
    match = {
        class = "nemo",
        title = "(Rotate|Resize) Images",
    },

    float = true,
}

hl.window_rule {
    match = {
        class = "nemo",
        title = ".* Properties",
    },

    float = true,
}

hl.window_rule {
    match = {
        class = "qalculate-.*",
    },

    float = true,
}

hl.window_rule {
    match = {
        class = "brave",
    },

    float = true,
}

-- Ignore maximize requests from apps. You'll probably like this.
hl.window_rule {
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
}

-- Fix some dragging issues with XWayland
hl.window_rule {
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
}

-- PiP
hl.window_rule {
    name = "picture-in-picture",
    match = {
        class = "(firefox|zen)",
        initial_title = "(Picture-in-Picture)",
    },

    pin = true,
    float = true,
}
