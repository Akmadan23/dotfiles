#     _    _                        _             ____  _____
#    / \  | | ___ __ ___   __ _  __| | __ _ _ __ |___ \|___ /
#   / _ \ | |/ / '_ ` _ \ / _` |/ _` |/ _` | '_ \  __) | |_ \
#  / ___ \|   <| | | | | | (_| | (_| | (_| | | | |/ __/ ___) |
# /_/   \_\_|\_\_| |_| |_|\__,_|\__,_|\__,_|_| |_|_____|____/
#
# IMPORTANT:
# in order to avoid switching groups typing
# the current group name, comment out the "toggle_group" funcion in
# /usr/local/lib/python3.x/site-packages/libqtile/config.py (if installed via pip)

import os
import re
import socket
import subprocess
from typing import List
from libqtile import layout, bar, widget, hook
from libqtile.lazy import lazy
from libqtile.config import Key, Screen, Group, Drag, Click

# Defining $HOME and $PATH
home = os.environ['HOME']
path = os.environ['PATH']

# Keys and default apps
mod = "mod4"
alt = "mod1"
sft = "shift"
ctrl = "control"
term = "alacritty"

# Colors
red =       "#CC0000"
teal =      "#1ABC9C"
darkteal =  "#24574D"
yellow =    "#C4A000"
darkgrey =  "#242424"
black =     "#000000"
white =     "#FFFFFF"

keys = [
    # Switch between windows
    Key([mod], "h", lazy.layout.left()),
    Key([mod], "j", lazy.layout.down()),
    Key([mod], "k", lazy.layout.up()),
    Key([mod], "l", lazy.layout.right()),

    # Switch between monitors
    Key([mod], "comma", lazy.prev_screen()),
    Key([mod], "period", lazy.next_screen()),

    # Move windows in current stack
    Key([mod, sft], "h", lazy.layout.shuffle_left()),
    Key([mod, sft], "j", lazy.layout.shuffle_down()),
    Key([mod, sft], "k", lazy.layout.shuffle_up()),
    Key([mod, sft], "l", lazy.layout.shuffle_right()),

    # Windows and layout behaviour
    Key([mod, sft], "n", lazy.layout.normalize()),
    Key([mod, sft], "f", lazy.window.toggle_floating()),
    Key([mod, sft], "q", lazy.window.kill()),
    Key([mod, sft], "r", lazy.restart()),
    Key([mod], "minus", lazy.layout.shrink(), lazy.layout.decrease_nmaster()),
    Key([mod], "plus", lazy.layout.grow(), lazy.layout.increase_nmaster()),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout()),
    Key([mod, sft], "Tab", lazy.prev_layout()),

    # Terminal and rofi
    Key([mod], "Return", lazy.spawn(term)),
    Key([mod], "space", lazy.spawn("rofi -modi 'drun,run' -show drun")),
    Key([mod, sft], "e", lazy.spawn("rofi -show power-menu -modi power-menu:rofi-power-menu")),
    Key([mod, sft], "x", lazy.spawn("rofi -show power-menu -modi power-menu:rofi-xrandr-menu")),

    # App spawning
    Key([mod], "f", lazy.spawn("firefox")),
    Key([mod], "t", lazy.spawn("thunderbird")),
    Key([mod], "s", lazy.spawn("flameshot gui")),
    Key([mod], "e", lazy.spawn(term + " -e ranger")),

    # Volume and brightness controls key bindings
    Key([ctrl, alt], "space", lazy.spawn("deadbeef --play-pause")),                     # deadbeef toggle play/pause
    Key([ctrl, alt], "Up", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%")),     # +5% volume
    Key([ctrl, alt], "Down", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%")),   # -5% volume
    Key([ctrl, alt], "m", lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")),     # mute
    Key([ctrl, alt], "Right", lazy.spawn("brightlight -i 239")),                        # +5% backlight
    Key([ctrl, alt], "Left", lazy.spawn("brightlight -d 239")),                         # -5% backlight
    Key([ctrl, alt], "r", lazy.spawn("brightlight -w 2390")),                           # resets to 50%
]

groups = []
group_names = ["1", "2", "3", "4", "5", "6", "7", "8"]
group_labels = ["", "", "@", "", "", "🎜", "", ""]

for i in range(len(group_names)):
    groups.append(
        Group(
            name = group_names[i],
            label = group_labels[i],
        )
    )

for i in groups:
    keys.extend([
        Key([mod], i.name, lazy.group[i.name].toscreen()),
        Key([mod, sft], i.name, lazy.window.togroup(i.name, switch_group = True)),
        Key([mod, ctrl], i.name, lazy.window.togroup(i.name, switch_group = False)),
    ])

# Assign applications to a specific groupname
@hook.subscribe.client_new
def assign_app_group(client):
    d = {}
    d["1"] = []
    d["2"] = ["firefox", "Firefox"]
    d["3"] = ["Mail", "Thunderbird"]
    d["4"] = ["ranger", "Ranger"]
    d["5"] = ["telegram-desktop", "TelegramDesktop"]
    d["6"] = ["lmms.real", "deadbeef", "Deadbeef"]
    d["7"] = []
    d["8"] = []

    wm_class = client.window.get_wm_class()[0]
    for i in range(len(d)):
        if wm_class in list(d.values())[i]:
            group = list(d.keys())[i]
            client.togroup(group)
            client.group.cmd_toscreen()

layout_theme = {
    "margin": 10,
    "single_margin": 0,
    "single_border_width": 0,
    "border_normal": darkgrey,
    "border_focus": teal,
    "border_width": 1,
}

layouts = [
    # layout.Floating(),
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Columns(),
    # layout.Matrix(),    
    # layout.RatioTile(),
    # layout.Max(),
    # layout.Tile(),
    # layout.Slice(),
    # layout.VerticalTile(),
    # layout.Zoomy(),

    layout.MonadTall(**layout_theme),
    layout.MonadWide(**layout_theme),

    layout.TreeTab(
        bg_color = darkgrey,
        active_bg = teal,
        active_fg = black,
        inactive_bg = darkgrey,
        inactive_fg = white,
        panel_width = 128,
        fontsize = 12,
        section_fontsize = 10,
    )
]

floating_layout = layout.Floating(
    border_focus = teal,
    border_normal = darkgrey,
    border_width = 1,

    float_rules = [
        # Run the utility of `xprop` to see the wm class and name of an X client.
        {"wmclass": "confirm"},
        {"wmclass": "dialog"},
        {"wmclass": "download"},
        {"wmclass": "error"},
        {"wmclass": "file_progress"},
        {"wmclass": "notification"},
        {"wmclass": "splash"},
        {"wmclass": "toolbar"},
        {"wmclass": "confirmreset"},        # gitk
        {"wmclass": "makebranch"},          # gitk
        {"wmclass": "maketag"},             # gitk
        {"wmclass": "ssh-askpass"},         # ssh-askpass
        {"wmclass": "cpu-x"},               # cpu-x windows
        {"wmclass": "gcr-prompter"},        # password input prompts
        {"wmclass": "blueman-manager"},     # blueman windows
        {"wmclass": "pavucontrol"},         # pavucontrol windows
        {"wmclass": "galculator"},          # galculator windows
        {"wmclass": "Msgcompose"},          # Thunderbird message window
        {"wmclass": "Calendar"},            # Thunderbird calendar window
        {"wmclass": "gsimplecal"},          # My minimal calendar of choice
        {"wmclass": "gcolor2"},             # gcolor2 windows
        {"wmclass": "balena-etcher-electron"}, # balena etcher
        {"wmclass": "authentication"},      # polkit authentication
        {"wmclass": "autenticazione"},      # italian version
    ]
)

widget_defaults = dict(
    font = "sans",
    fontsize = 12,
    padding = 3,
)

extension_defaults = widget_defaults.copy()

# Calendar spawner
def calendar(qtile):
    qtile.cmd_spawn("gsimplecal")

# Calendar spawner
def pavucontrol(qtile):
    qtile.cmd_spawn("pavucontrol")

# Autostart script
@hook.subscribe.startup
def autostart():
    subprocess.call([home + "/.config/qtile/autostart.sh"])

# Monitor detection
@hook.subscribe.startup_once
def autostart_once():
    subprocess.call([home + "/.config/qtile/monitordetection.sh"])

screens = [
    Screen( # Main/only screen
        top = bar.Bar(
            [
                widget.GroupBox(
                    this_current_screen_border = teal,
                    this_screen_border = teal,
                    font = "FontAwesome",
                    fontsize = 16,
                    rounded = False,
                    highlight_color = darkteal,
                    highlight_method = "line",
                ),

                widget.WindowName(
                    fontshadow = black,
                    show_state = False,
                ),

                widget.TextBox(
                    text = "",
                    font = "FontAwesome",
                    fontsize = 43,
                    padding = 0,
                    margin = 0,
                    step = 5,
                    background = darkgrey,
                    foreground = darkteal,
                ),

                widget.TextBox(
                    text = "🌡",
                    padding = 2,
                    fontsize = 20,
                    background = darkteal,
                    foreground = white,
                ),

                widget.ThermalSensor(
                    update_interval = 1,
                    foreground_alert = red,
                    threshold = 90,
                    padding = 5,
                    background = darkteal,
                    foreground = white,
                ),

                widget.TextBox(
                    text = "",
                    font = "FontAwesome",
                    fontsize = 43,
                    padding = 0,
                    margin = 0,
                    background = darkteal,
                    foreground = teal,
                ),

                widget.TextBox(
                    text = "☼",
                    fontsize = 24,
                    background = teal,
                    foreground = black,
                ),

                widget.Backlight(
                    backlight_name = "intel_backlight",
                    brightness_file = "brightness",
                    background = teal,
                    foreground = black,
                ),

                widget.TextBox(
                    text = "",
                    font = "FontAwesome",
                    fontsize = 43,
                    padding = 0,
                    margin = 0,
                    step = 5,
                    background = teal,
                    foreground = darkteal,
                ),

                widget.BatteryIcon(
                    background = darkteal,
                    fontsize = 20,
                ),

                widget.Battery(
                    format = '{char} {percent:2.0%}',
                    background = darkteal,
                    charge_char = "▲",
                    discharge_char = "▼",
                    low_foreground = red,
                    notify_below = 10,
                    update_interval = 10
                ),

                widget.TextBox(
                    text = "",
                    font = "FontAwesome",
                    fontsize = 43,
                    padding = 0,
                    margin = 0,
                    background = darkteal,
                    foreground = teal,
                ),

                widget.TextBox(
                    # text = "🕬",
                    text = "🔊",
                    font = "Hasklug",
                    fontsize = 22,
                    background = teal,
                    foreground = black,
                    mouse_callbacks = {"Button1": pavucontrol},
                ),

                widget.Volume(
                    step = 5,
                    background = teal,
                    foreground = black,
                ),

                widget.TextBox(
                    text = "",
                    font = "FontAwesome",
                    fontsize = 43,
                    padding = 0,
                    margin = 0,
                    background = teal,
                    foreground = darkteal,
                ),

                widget.Clock(
                    background = darkteal,
                    format = "%A %d %B, %H:%M",
                    mouse_callbacks = {"Button1": calendar},
                ),

                widget.TextBox(
                    text = "",
                    font = "FontAwesome",
                    fontsize = 43,
                    padding = 0,
                    margin = 0,
                    background = darkteal,
                    foreground = darkgrey,
                ),

                widget.Systray(
                    background = darkgrey,
                ),

                widget.CurrentLayoutIcon(
                    scale = 0.75,
                ),
            ],

            22,
            background = darkgrey,
        )
    ),

    Screen( # Secondary display
        top = bar.Bar(
            [
                widget.GroupBox(
                    this_current_screen_border = teal,
                    this_screen_border = teal,
                    font = "FontAwesome",
                    fontsize = 16,
                    rounded = False,
                    highlight_color = darkteal,
                    highlight_method = "line",
                ),

                widget.WindowName(
                    fontshadow = black,
                    show_state = False,
                ),

                widget.TextBox(
                    text = "CPU",
                    font = "FontAwesome",
                ),

                widget.CPUGraph(
                    line_width = 2,
                    graph_color = teal,
                    border_color = darkgrey,
                ),

                widget.TextBox(
                    text = "RAM",
                    font = "FontAwesome",
                ),

                widget.MemoryGraph(
                    line_width = 2,
                    graph_color = yellow,
                    border_color = darkgrey,
                ),

                widget.TextBox(
                    text = "NET",
                    font = "FontAwesome",
                ),

                widget.NetGraph(
                    line_width = 2,
                    graph_color = red,
                    border_color = darkgrey,
                ),

                widget.Clock(
                    format = "%A %d %B, %H:%M",
                    mouse_callbacks = {"Button1": calendar},
                ),

                widget.CurrentLayoutIcon(
                    scale = 0.75,
                ),
            ],

            24,
            background = darkgrey,
        )
    )
]

mouse = [
    Drag(
        [mod], "Button1", lazy.window.set_position_floating(),
        start = lazy.window.get_position()
    ),

    Drag(
        [mod], "Button3", lazy.window.set_size_floating(),
        start = lazy.window.get_size()
    ),

    Click(
        [mod], "Button2", lazy.window.bring_to_front()
    )
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = "auto"

# neofetch fixes
wmname = "Qtile"
dename = ""
