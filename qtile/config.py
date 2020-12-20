#     _    _                        _             ____  _____ 
#    / \  | | ___ __ ___   __ _  __| | __ _ _ __ |___ \|___ /
#   / _ \ | |/ / '_ ` _ \ / _` |/ _` |/ _` | '_ \  __) | |_ \
#  / ___ \|   <| | | | | | (_| | (_| | (_| | | | |/ __/ ___) |
# /_/   \_\_|\_\_| |_| |_|\__,_|\__,_|\__,_|_| |_|_____|____/
#
# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

import os
import re
import socket
import subprocess
from libqtile.config import Key, Screen, Group, Drag, Click
from libqtile.lazy import lazy
from libqtile import layout, bar, widget, hook
from typing import List  # noqa: F401

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
    # Switch between windows in current stack pane
    Key([mod], "h", lazy.layout.left()),
    Key([mod], "j", lazy.layout.down()),
    Key([mod], "k", lazy.layout.up()),
    Key([mod], "l", lazy.layout.right()),

    # Move windows in current stack
    Key([mod, sft], "h", lazy.layout.shuffle_left()),
    Key([mod, sft], "j", lazy.layout.shuffle_down()),
    Key([mod, sft], "k", lazy.layout.shuffle_up()),
    Key([mod, sft], "l", lazy.layout.shuffle_right()),

    # Windows and layout behaviour
    Key([mod, sft], "n", lazy.layout.normalize()),
    Key([mod, sft], "f", lazy.window.toggle_floating()),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout()),
    Key([mod, sft], "Tab", lazy.prev_layout()),

    # Other
    Key([mod], "minus", lazy.layout.shrink(), lazy.layout.decrease_nmaster()),
    Key([mod], "plus", lazy.layout.grow(), lazy.layout.increase_nmaster()),
    Key([mod, sft], "q", lazy.window.kill()),
    Key([mod, sft], "r", lazy.restart()),
    Key([mod, sft], "e", lazy.spawn("rofi -show power-menu -modi power-menu:" + home + "/.local/bin/rofi-power-menu")),
    Key([mod], "r", lazy.spawncmd()),

    # Terminal and rofi
    Key([mod], "Return", lazy.spawn(term)),
    Key([mod], "space", lazy.spawn("rofi -modi 'drun,run' -show drun")),

    # App spawning
    Key([mod], "g", lazy.spawn("gimp")),
    Key([mod], "f", lazy.spawn("firefox")),
    Key([mod], "t", lazy.spawn("thunderbird")),
    Key([mod], "s", lazy.spawn("flameshot gui")),
    Key([mod], "e", lazy.spawn(term + " -e ranger")),
    Key([mod, sft], "g", lazy.spawn("galculator")),
    Key([mod, sft], "t", lazy.spawn("flatpak run org.telegram.desktop")),

    # Volume and brightness controls key bindings
    Key([ctrl, alt], "space", lazy.spawn("deadbeef --play-pause")),                      # deadbeef toggle play/pause
    Key([ctrl, alt], "Up", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%")),      # +5% volume
    Key([ctrl, alt], "Down", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%")),    # -5% volume
    Key([ctrl, alt], "m", lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")),      # mute
    Key([ctrl, alt], "Right", lazy.spawn("brightlight -i 239")),                         # +5% backlight
    Key([ctrl, alt], "Left", lazy.spawn("brightlight -d 239")),                          # -5% backlight
    Key([ctrl, alt], "r", lazy.spawn("brightlight -w 2390")),                            # resets to 50%
]

groups = []
group_names = ["1", "2", "3", "4", "5", "6", "7", "8"]
group_labels = ["", "", "@", "", "", "🎜", "", ""]

for i in range(len(group_names)):
    groups.append(
        Group(
            name = group_names [i],
            label = group_labels [i],
        )
    )

for i in groups:
    keys.extend([
        Key([mod], i.name, lazy.group[i.name].toscreen()),
        Key([mod, sft], i.name, lazy.window.togroup(i.name, switch_group = True)),
        Key([mod, ctrl], i.name, lazy.window.togroup(i.name, switch_group = False)),
    ])

# ASSIGN APPLICATIONS TO A SPECIFIC GROUPNAME
@hook.subscribe.client_new
def assign_app_group(client):
    d = {}
    d["1"] = []
    d["2"] = ["firefox", "Firefox"]
    d["3"] = ["Mail", "Thunderbird"]
    d["4"] = ["ranger", "Ranger"]
    d["5"] = ["telegram-desktop", "TelegramDesktop"]
    d["6"] = ["lmms", "deadbeef", "Deadbeef"]
    d["7"] = []
    d["8"] = []

    wm_class = client.window.get_wm_class()[0]
    for i in range(len(d)):
        if wm_class in list(d.values())[i]:
            group = list(d.keys())[i]
            client.togroup(group)
            client.group.cmd_toscreen()

# IMPORTANT: 
# in order to avoid switching groups typing
# the current group name, comment out the "toggle_group" funcion in
# /usr/local/lib/python3.x/site-packages/libqtile/config.py

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
    # layout.Matrix(),    
    # layout.RatioTile(),
    # layout.Tile(),
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
        panel_width = 200,
        fontsize = 12,
        section_fontsize = 10,
    ),
]

floating_layout = layout.Floating(
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
        {"wmclass": "confirmreset"},    # gitk
        {"wmclass": "makebranch"},      # gitk
        {"wmclass": "maketag"},         # gitk
        {"wmclass": "ssh-askpass"},     # ssh-askpass
        {"wmclass": "cpu-x"},           # cpu-x windows
        {"wmclass": "gcr-prompter"},    # password input prompts
        {"wmclass": "blueman-manager"}, # blueman windows
        {"wmclass": "blueman-manager"}, # blueman windows
        # {"wmclass": "telegram-desktop"}, # Telegram desktop windows
        {"wmclass": "pavucontrol"},     # pavucontrol windows
        {"wmclass": "volumeicon"},      # volumeicon preferences window
        {"wmclass": "galculator"},      # galculator windows
        {"wmclass": "Msgcompose"},      # Thunderbird message window
        {"wmclass": "Calendar"},        # Thunderbird calendar window
        {"wmclass": "gsimplecal"},      # My minimal calendar of choice
        {"wmclass": "gcolor2"},         # gcolor2 windows
        {"wmclass": "balena-etcher-electron"}, # balena etcher
        {"wmclass": "osxmanager"},      # XAMPP windows
        {"wmclass": "authentication"},  # polkit authentication
        {"wmclass": "autenticazione"},  # italian version
    ]
)

widget_defaults = dict(
    font = "sans",
    fontsize = 12,
    padding = 3,
)

extension_defaults = widget_defaults.copy()

# Mouse callbacks

def open_rofi(qtile):
    qtile.cmd_spawn("rofi -modi 'drun,run' -show drun")

def open_htop(qtile):
    qtile.cmd_spawn(term + " -e htop")

def open_stui(qtile):
    qtile.cmd_spawn(term + " -e s-tui")

def open_pavucontrol(qtile):
    qtile.cmd_spawn("pavucontrol")

def open_calendar(qtile):
    qtile.cmd_spawn("gsimplecal")

def open_settings(qtile):
    qtile.cmd_spawn("gnome-control-center")

def logout_menu(qtile):
    qtile.cmd_spawn("rofi -show power-menu -modi power-menu:" + home + "/.local/bin/rofi-power-menu")

# Single/dual monitor check

@hook.subscribe.startup
def autostart():
    subprocess.call([home + "/.config/qtile/autostart.sh"])

f = open(home + "/.config/qtile/.hdmi.txt", "r")
x = f.read()
f.close()

if x == "disconnected\n": # if "xrandr | grep HDMI-1" outputs no hdmi device connected
    screens = [
        Screen( # Only screen
            top = bar.Bar([
                widget.CurrentLayoutIcon(
                    scale = 0.8,
                ),

                widget.GroupBox(
                    this_current_screen_border = teal,
                    this_screen_border = teal,
                    rounded = False,
                    font= "FontAwesome",
                    fontsize = 20,
                    highlight_color = darkteal,
                    highlight_method = "line",
                ),

                widget.Prompt(),
                widget.WindowName(),

                widget.TextBox(
                    text = "㎓",
                    fontsize = 20,
                ),

                widget.CPUGraph(
                    samples = 50,
                    line_width = 2,
                    graph_color = teal,
                    border_color = darkgrey,
                    mouse_callbacks = {"Button1": open_stui},
                ),

                widget.TextBox(
                    text = "RAM:",
                ),

                widget.MemoryGraph(
                    samples = 50,
                    line_width = 2,
                    graph_color = yellow,
                    border_color = darkgrey,
                    mouse_callbacks = {"Button1": open_htop},
                ),

                widget.TextBox(
                    text = "⇵",
                    fontsize = 20,
                ),

                widget.NetGraph(
                    samples = 50,
                    line_width = 2,
                    graph_color = red,
                    border_color = darkgrey,
                ),

                widget.TextBox(
                    text = "",
                    font= "FontAwesome",
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
                    font= "FontAwesome",
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
                    font= "FontAwesome",
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
                    font= "FontAwesome",
                    fontsize = 43,
                    padding = 0,
                    margin = 0,
                    background = darkteal,
                    foreground = teal,
                ),

                widget.TextBox(
                    text = "🕬",
                    fontsize = 22,
                    background = teal,
                    foreground = black,
                    mouse_callbacks = {"Button1": open_pavucontrol},
                ),

                widget.Volume(
                    step = 5,
                    mute_character = "⮿",
                    background = teal,
                    foreground = black,
                ),

                widget.TextBox(
                    text = "",
                    font= "FontAwesome",
                    fontsize = 43,
                    padding = 0,
                    margin = 0,
                    background = teal,
                    foreground = darkteal,
                ),

                widget.Clock(
                    background = darkteal,
                    format = "%A %d %B, %H:%M",
                    mouse_callbacks = {"Button1": open_calendar},
                ),

                widget.TextBox(
                    text = "",
                    font= "FontAwesome",
                    fontsize = 43,
                    padding = 0,
                    margin = 0,
                    background = darkteal,
                    foreground = darkgrey,
                ),

                widget.Systray(
                    background = darkgrey,
                ),

                widget.TextBox(
                    text = "⚙",
                    padding = 2,
                    fontsize = 24,
                    background = darkgrey,
                    mouse_callbacks = {"Button1": open_settings},
                ),

                widget.TextBox(
                    text = "⏻",
                    padding = 2,
                    fontsize = 30,
                    background = darkgrey,
                    mouse_callbacks = {"Button1": logout_menu},
                ),
            ],

            22,
            background = darkgrey,
            ),
        ),
    ]

else:
    screens = [
        Screen( # Main external monitor
            top = bar.Bar([
                widget.CurrentLayoutIcon(
                    scale = 0.8,
                ),

                widget.GroupBox(
                    this_current_screen_border = teal,
                    this_screen_border = teal,
                    rounded = True,
                    font= "FontAwesome",
                    fontsize = 16,
                    highlight_color = darkteal,
                    highlight_method = "line",
                ),

                widget.Prompt(),
                widget.WindowName(),

                widget.TextBox(
                    text = "",
                    font= "FontAwesome",
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
                    font= "FontAwesome",
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
                    change_command = "xbacklight -set {0}", # not working on my system
                    backlight_name = "intel_backlight",
                    brightness_file = "brightness",
                    background = teal,
                    foreground = black,
                    step = 5,
                ),

                widget.TextBox(
                    text = "",
                    font= "FontAwesome",
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
                    update_interval = 10,
                ),

                widget.TextBox(
                    text = "",
                    font= "FontAwesome",
                    fontsize = 43,
                    padding = 0,
                    margin = 0,
                    background = darkteal,
                    foreground = teal,
                ),

                widget.TextBox(
                    text = "🕬",
                    fontsize = 22,
                    background = teal,
                    foreground = black,
                    mouse_callbacks = {"Button1": open_pavucontrol},
                ),

                widget.Volume(
                    step = 5,
                    mute_character = "⮿",
                    background = teal,
                    foreground = black,
                ),

                widget.TextBox(
                    text = "",
                    font= "FontAwesome",
                    fontsize = 43,
                    padding = 0,
                    margin = 0,
                    background = teal,
                    foreground = darkteal,
                ),

                widget.Clock(
                    background = darkteal,
                    format = "%A %d %B, %H:%M",
                    mouse_callbacks = {"Button1": open_calendar},
                ),

                widget.TextBox(
                    text = "",
                    font= "FontAwesome",
                    fontsize = 43,
                    padding = 0,
                    margin = 0,
                    background = darkteal,
                    foreground = darkgrey,
                ),

                widget.Systray(
                    background = darkgrey,
                ),

                widget.TextBox(
                    text = "⚙",
                    padding = 2,
                    fontsize = 24,
                    background = darkgrey,
                    mouse_callbacks = {"Button1": open_settings},
                ),

                widget.TextBox(
                    text = "⏻",
                    padding = 2,
                    fontsize = 30,
                    background = darkgrey,
                    mouse_callbacks = {"Button1": logout_menu},
                ),
            ],

            22,
            background = darkgrey,
            ),
        ),

        Screen( # Integrated display
            top = bar.Bar([
                widget.CurrentLayoutIcon(
                    scale = 0.8,
                ),

                widget.GroupBox(
                    this_current_screen_border = teal,
                    this_screen_border = teal,
                    rounded = False,
                    font= "FontAwesome",
                    fontsize = 16,
                    highlight_color = darkteal,
                    highlight_method = "line",
                ),

                widget.Prompt(),
                widget.WindowName(),

                widget.TextBox(
                    text = "㎓",
                    fontsize = 20,
                ),

                widget.CPUGraph(
                    line_width = 2,
                    graph_color = teal,
                    border_color = darkgrey,
                    mouse_callbacks = {"Button1": open_stui},
                ),

                widget.TextBox(
                    text = "RAM:",
                ),

                widget.MemoryGraph(
                    line_width = 2,
                    graph_color = yellow,
                    border_color = darkgrey,
                    mouse_callbacks = {"Button1": open_htop},
                ),

                widget.TextBox(
                    text = "⇵",
                    fontsize = 20,
                ),

                widget.NetGraph(
                    line_width = 2,
                    graph_color = red,
                    border_color = darkgrey,
                ),

                widget.Clock(
                    format = "%A %d %B, %H:%M",
                    mouse_callbacks = {"Button1": open_calendar},
                ),

                widget.TextBox(
                    text = "⏻",
                    padding = 2,
                    fontsize = 30,
                    background = darkgrey,
                    mouse_callbacks = {"Button1": logout_menu},
                ),
            ],

            24,
            background = darkgrey,
            ),
        ),
    ]

# Drag floating layouts.
mouse = [
    Drag(
        [mod], "Button1", lazy.window.set_position_floating(),
        start=lazy.window.get_position()
    ),

    Drag(
        [mod], "Button3", lazy.window.set_size_floating(),
        start=lazy.window.get_size()
    ),

    Click(
        [mod], "Button2", lazy.window.bring_to_front()
    ),
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
dename = ""
wmname = "Qtile"
