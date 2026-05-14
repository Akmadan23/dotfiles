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
