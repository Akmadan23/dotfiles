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


# Keys and default apps
mod = "mod4"
alt = "mod1"
sft = "shift"
ctrl = "control"
term = "alacritty"

# Colors
red = "#CC0000"
teal = "#1ABC9C"
darkteal = "#24574D"
yellow = "#C4A000"
darkgrey = "#242424"
darkgrey1 = "#212121"
black = "#000000"
white = "#FFFFFF"

keys = [
    # Switch between windows in current stack pane
    Key([alt], "Tab", lazy.layout.down()),
    Key([alt, sft], "Tab", lazy.layout.up()),

    # Move windows up or down in current stack
    Key([alt, ctrl], "Tab", lazy.layout.shuffle_down()),
    Key([alt, ctrl, sft], "Tab", lazy.layout.shuffle_up()),

    # Windows and layout behaviour
    Key([mod], "plus", lazy.layout.grow(), lazy.layout.increase_nmaster()),
    Key([mod], "minus", lazy.layout.shrink(), lazy.layout.decrease_nmaster()),
    Key([mod, sft], "n", lazy.layout.normalize()),
    Key([mod, sft], "f", lazy.window.toggle_floating()),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout()),
    Key([mod, sft], "Tab", lazy.prev_layout()),
    Key([mod, sft], "q", lazy.window.kill()),
    Key([mod, sft], "r", lazy.restart()),
    Key([mod, sft], "e", lazy.spawn("wlogout")),
    Key([mod], "r", lazy.spawncmd()),

    # Other personal key bindings
    Key([mod, sft], "t", lazy.spawn("flatpak run org.telegram.desktop")),
    Key([mod, sft], "v", lazy.spawn("flatpak run com.visualstudio.code-oss")),
    Key([mod, sft], "k", lazy.spawn("flatpak run okg.kde.kdenlive")),
    Key([mod], "Return", lazy.spawn(term)),
    Key([mod], "space", lazy.spawn("rofi -show run -config ~/.config/rofi/config.rasi")),
    Key([mod], "g", lazy.spawn("gimp")),
    Key([mod], "f", lazy.spawn("firefox")),
    Key([mod], "t", lazy.spawn("thunderbird")),
    Key([mod], "h", lazy.spawn(term + " -e htop")),
    Key([mod], "e", lazy.spawn(term + " -e ranger")),
    Key([mod], "l", lazy.spawn("lock-script")), # Copied the i3lock.sh script in /bin/ as "lock-script"
]

group_names = [("1: >_"), ("2: 🔗"), ("3: @"), ("4: 🗁"), ("5"), ("6"), ("7"), ("8")]

groups = [Group(name) for name in group_names]
for i, (name) in enumerate(group_names, 1):
	keys.extend([
        Key([mod], str(i), lazy.group[name].toscreen()),
        Key([mod, sft], str(i), lazy.window.togroup(name, switch_group=True)),
    ])
    
layout_theme = {
    "margin": 10,
    "single_margin": 0,
    "single_border_width": 0,
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
        {'wmclass': 'confirm'},
        {'wmclass': 'dialog'},
        {'wmclass': 'download'},
        {'wmclass': 'error'},
        {'wmclass': 'file_progress'},
        {'wmclass': 'notification'},
        {'wmclass': 'splash'},
        {'wmclass': 'toolbar'},
        {'wmclass': 'confirmreset'},    # gitk
        {'wmclass': 'makebranch'},      # gitk
        {'wmclass': 'maketag'},         # gitk
        {'wmclass': 'ssh-askpass'},     # ssh-askpass
        {'wmclass': 'pavucontrol'},     # pavucontrol windows
        {'wmclass': 'galculator'},      # galculator windows
        {'wname': 'branchdialog'},      # gitk
        {'wname': 'pinentry'},          # GPG key password entry
    ]
)

widget_defaults = dict(
    font='sans',
    fontsize=12,
    padding=3,
)

extension_defaults = widget_defaults.copy()
home = os.path.expanduser('~')

# Mouse callbacks

def open_rofi(qtile):
    qtile.cmd_spawn("rofi -show run -config ~/.config/qtile/rofi-onedark.rasi")
    
def open_htop(qtile):
    qtile.cmd_spawn(term + " -e htop")
    
def open_stui(qtile):
    qtile.cmd_spawn(term + " -e s-tui")

def open_pavucontrol(qtile):
    qtile.cmd_spawn("pavucontrol")
    
def open_calendar(qtile):
    qtile.cmd_spawn(term + " -e calcurse")
    
def open_settings(qtile):
    qtile.cmd_spawn("gnome-control-center")

def logout_menu(qtile):
    qtile.cmd_spawn("wlogout")

def suspend(qtile):
    qtile.cmd_spawn("lock-suspend") # Copied che lock-suspend.sh script in /bin/ as "lock-suspend"

# Monitor setup check    

f = open(home + "/.config/qtile/.hdmi/temp.txt", "r")
x = f.read()
f.close()

f = open(home + "/.config/qtile/.hdmi/no-hdmi1.txt", "r")
y1 = f.read()
f.close()

f = open(home + "/.config/qtile/.hdmi/no-hdmi2.txt", "r")
y2 = f.read()
f.close()

f = open(home + "/.config/qtile/.hdmi/no-hdmi3.txt", "r")
y3 = f.read()
f.close()

if (x == y1) and (x == y2) and (x == y3): # if "xrandr | grep HDMI-1" outputs no hdmi device connected
    @hook.subscribe.startup
    def integrated_display(): subprocess.call([home + "/.config/scripts/integrated-display.sh"])
    screens = [
        Screen( # Only screen
            top = bar.Bar([
                widget.CurrentLayoutIcon(
                    scale = 0.8,
                ),
                
                widget.GroupBox(
                    this_current_screen_border = teal,
                    this_screen_border = teal,
                    hide_unused = True,
                    rounded = False,
                    highlight_color = darkteal,
                    highlight_method = "line",
                ),
                
                widget.Prompt(),
                widget.WindowName(),
                
                widget.TextBox(
                    text = "CPU:", 
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
                    text = "NET:", 
                ),
                
                widget.NetGraph(
                    samples = 50,
                    line_width = 2,
                    graph_color = red,
                    border_color = darkgrey,
                ),

                widget.TextBox(
                    text = "",
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
                    background = teal,
                    foreground = black,
                ),

                widget.TextBox(
                    text = "",
                    fontsize = 43,
                    padding = 0,
                    margin = 0,
                    background = teal,
                    foreground = darkteal,
                ),
                
                widget.Clock(
                    background = darkteal,
                    format = '%a %d/%m/%Y, %H:%M %p',
                    mouse_callbacks = {"Button1": open_calendar},
                ),

                widget.TextBox(
                    text = "",
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
                    fontsize = 20,
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
    @hook.subscribe.startup
    def dual_monitor(): subprocess.call([home + "/.config/scripts/dual-monitor.sh"])
    screens = [
        Screen( # Main external monitor
            top = bar.Bar([
                widget.CurrentLayoutIcon(
                    scale = 0.8,
                ),
                
                widget.GroupBox(
                    this_current_screen_border = teal,
                    this_screen_border = teal,
                    hide_unused = True,
                    rounded = False,
                    highlight_color = darkteal,
                    highlight_method = "line",
                ),
                
                widget.Prompt(),
                widget.WindowName(),

                widget.TextBox(
                    text = "",
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
                    background = teal,
                    foreground = black,
                ),

                widget.TextBox(
                    text = "",
                    fontsize = 43,
                    padding = 0,
                    margin = 0,
                    background = teal,
                    foreground = darkteal,
                ),
                
                widget.Clock(
                    background = darkteal,
                    format = '%a %d/%m/%Y, %H:%M %p',
                    mouse_callbacks = {"Button1": open_calendar},
                ),

                widget.TextBox(
                    text = "",
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
                    fontsize = 20,
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
                    hide_unused = True,
                    rounded = False,
                    highlight_color = darkteal,
                    highlight_method = "line",
                ),
                
                widget.Prompt(),
                widget.WindowName(),
                
                widget.TextBox(
                    text = "CPU:", 
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
                    text = "NET:", 
                ),
                
                widget.NetGraph(
                    line_width = 2,
                    graph_color = red,
                    border_color = darkgrey,
                ),

                widget.Clipboard(
                    timeout = 60,
                    max_width = 40,
                    padding = 5,
                    foreground = teal,
                ),
                
                widget.Clock(
                    format = '%A %d/%m/%Y, %H:%M %p',
                    mouse_callbacks = {"Button1": open_calendar},
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
focus_on_window_activation = "smart"
    
# Startup commands
@hook.subscribe.startup
def autostart():
    subprocess.call([home + "/.config/scripts/autostart.sh"])

# neofetch fixes
dename = ""
wmname = "Qtile"
