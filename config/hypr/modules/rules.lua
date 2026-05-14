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
hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})

-- Fix some dragging issues with XWayland
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

-- PiP
-- windowrule = pin 1, match:class (firefox|zen), match:initial_title (Picture-in-Picture) -- Uncomment if needed
-- windowrule = float 1, match:class (firefox|zen), match:initial_title (Picture-in-Picture)
hl.window_rule {
    name = "picture-in-picture",
    match = {
        class = "(firefox|zen)",
        initial_title = "(Picture-in-Picture)",
    },

    pin = true,
    float = true,
}

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
