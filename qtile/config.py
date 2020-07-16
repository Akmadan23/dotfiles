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
ctrl = "control"
term = "gnome-terminal"

# Colors
red = "#CC0000"
teal = "#1ABC9C"
darkteal = "#24574D"
yellow = "#C4A000"
darkgrey = "#212121"
black = "#000000"
white = "#FFFFFF"

# Suspend function

def suspend(qtile):
    qtile.cmd_spawn("")

keys = [
    # Switch between windows in current stack pane
    Key([mod], "k", lazy.layout.down()),
    Key([mod], "j", lazy.layout.up()),

    # Move windows up or down in current stack
    Key([mod, ctrl], "k", lazy.layout.shuffle_down()),
    Key([mod, ctrl], "j", lazy.layout.shuffle_up()),

    # Switch window focus to other pane(s) of stack
    # Key([mod], "space", lazy.layout.next()),

    # Swap panes of split stack
    Key([mod, "shift"], "space", lazy.layout.rotate()),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return", lazy.layout.toggle_split()),
    Key([mod], "Return", lazy.spawn(term)),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout()),
    Key([mod, "shift"], "Tab", lazy.prev_layout()),
    Key([mod, "shift"], "q", lazy.window.kill()),

    Key([mod, "shift"], "r", lazy.restart()),
    Key([mod, "shift"], "e", lazy.shutdown()),
    Key([mod], "r", lazy.spawncmd()),

    # Other personal key bindings
    # Key([mod, "shift"], "s", qtile.cmd_spawn("systemctl suspend && i3lock -i ~/Immagini/Wallpapers/aurora-over-iceland.png -ft"),
    # Key([mod, "shift"], "s", suspend,
    Key([mod, "shift"], "f", lazy.window.set_position_tiling()),
    Key([mod], "space", lazy.spawn("rofi -show run")),
    Key([mod], "g", lazy.spawn("gimp")),
    Key([mod], "f", lazy.spawn("firefox")),
    Key([mod], "t", lazy.spawn("thunderbird")),
    Key([mod], "s", lazy.spawn("deepin-screenshot")),
    Key([mod], "h", lazy.spawn(term + " -- htop")),
    Key([mod], "e", lazy.spawn(term + " -- ranger")),
    Key([mod], "l", lazy.spawn("lock-script")),
]

groups = [Group(i) for i in "12345678"]

for i in groups:
    keys.extend([
        # mod1 + letter of group = switch to group
        Key([mod], i.name, lazy.group[i.name].toscreen()),

        # mod1 + shift + letter of group = switch to & move focused window to group
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=True)),
        # Or, use below if you prefer not to switch to that group.
        # # mod1 + shift + letter of group = move focused window to group
        # Key([mod, "shift"], i.name, lazy.window.togroup(i.name)),
    ])

layouts = [
    layout.MonadTall(
        border_focus = teal,
        border_width = 1,
        margin = 10,
        single_border_width = 0,
        single_margin = 0,
    ),
    
    layout.MonadWide(
        border_focus = teal,
        border_width = 1,
        margin = 10,
        single_border_width = 0,
        single_margin = 0,
    ),
    
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
    
    # layout.Floating(),
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Columns(),
    # layout.Matrix(),    
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font='sans',
    fontsize=12,
    padding=3,
)
extension_defaults = widget_defaults.copy()

# Mouse callbacks

def open_rofi(qtile):
    qtile.cmd_spawn("rofi -show run")
    
def open_htop(qtile):
    qtile.cmd_spawn("gnome-terminal -- htop")
    
def open_stui(qtile):
    qtile.cmd_spawn("gnome-terminal -- s-tui")

def open_settings(qtile):
    qtile.cmd_spawn("gnome-control-center")
    
def open_pavucontrol(qtile):
    qtile.cmd_spawn("pavucontrol")

screens = [
    # Integrated display
    Screen(
        top=bar.Bar(
            [
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

                widget.Clipboard(
                    timeout = None,
                    max_width = 30,
                    padding = 10,
                ),
                
                widget.Clock(
                    format = '%a %d/%m/%Y, %I:%M %p',
                ),
                
                widget.CurrentLayoutIcon(
                    scale = 0.8,
                ),
            ], 
            24,
            background = darkgrey,
        ),
    ),

    # Main external monitor
    Screen(
        top=bar.Bar(
            [
                widget.Image(
                    filename = "~/.config/qtile/logo.png",
                    mouse_callbacks = {"Button1": open_rofi},
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

                widget.TextBox(
                   text = "🌡",
                   padding = 2,
                   fontsize = 11,
                ),
                
                widget.ThermalSensor(
                    update_interval = 1,
                    foreground_alert = red,
                    threshold = 90,
                    padding = 5,
                ),
                
                widget.CPUGraph(
                    graph_color = teal,
                    border_color = darkgrey,
                    mouse_callbacks = {"Button1": open_stui},
                ),
                
                widget.TextBox(
                    text = "RAM:", 
                ),
                
                widget.MemoryGraph(
                    graph_color = yellow,
                    border_color = darkgrey,
                    mouse_callbacks = {"Button1": open_htop},
                ),
                
                widget.TextBox(
                    text = "NET:", 
                ),
                
                widget.NetGraph(
                    graph_color = red,
                    border_color = darkgrey,
                ),

                widget.TextBox(
                    text = "",
                    fontsize = 43,
                    padding = 0,
                    margin = 0,
                    background = darkgrey,
                    foreground = darkteal,
                ),

                widget.BatteryIcon(
                    background = darkteal,
                ),

                widget.Battery(
                    background = darkteal,
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
                    text = "Vol:", 
                    background = teal,
                    foreground = black,
                ),
                
                widget.Volume(
                    step = 5,
                    # mouse_callbacks = {"Button1": open_pavucontrol},
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
                    format = '%a %d/%m/%Y, %I:%M %p',
                    background = darkteal,
                ),

                widget.TextBox(
                    text = "",
                    fontsize = 43,
                    padding = 0,
                    margin = 0,
                    background = darkteal,
                    foreground = darkgrey,
                ),
                
                widget.Systray(),

                widget.TextBox(
                    text = "⚙",
                    padding = 2,
                    fontsize = 26,
                    background = darkgrey,
                    mouse_callbacks = {"Button1": open_settings},
                ),
                
                widget.CurrentLayoutIcon(
                    scale = 0.8,
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
        [mod, "shift"], "Button1", lazy.window.set_size_floating(),
        start=lazy.window.get_size()
    ),

    Click(
        [mod], "Button3", lazy.window.bring_to_front()
    ),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    {'wmclass': 'confirm'},
    {'wmclass': 'dialog'},
    {'wmclass': 'download'},
    {'wmclass': 'error'},
    {'wmclass': 'file_progress'},
    {'wmclass': 'notification'},
    {'wmclass': 'splash'},
    {'wmclass': 'toolbar'},
    {'wmclass': 'confirmreset'},  # gitk
    {'wmclass': 'makebranch'},  # gitk
    {'wmclass': 'maketag'},  # gitk
    {'wname': 'branchdialog'},  # gitk
    {'wname': 'pinentry'},  # GPG key password entry
    {'wmclass': 'ssh-askpass'},  # ssh-askpass
])

auto_fullscreen = True
focus_on_window_activation = "smart"

# Startup commands
@hook.subscribe.startup
def autostart():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart.sh'])

# neofetch fixes
dename = ""
wmname = "Qtile"
