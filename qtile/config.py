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

from libqtile import layout, bar, widget, hook
from libqtile.lazy import lazy
from libqtile.config import Key, Screen, Group, Drag, Click
import os, re, socket, subprocess

# Importing environment variables
home = os.environ['HOME']
path = os.environ['PATH']
term = os.environ['TERMINAL']

# Keys aliases
mod = "mod4"
alt = "mod1"
sft = "shift"
ctrl = "control"

# FontAwesome
FA4 = "FontAwesome"                 # V4.7
FA5 = "Font Awesome 5 Free Solid"   # V5.15

# Colors
red =       "#CC0000"
black =     "#000000"
white =     "#FFFFFF"
accent1 =   "#1ABC9C"
accent2 =   "#24574D"
accent3 =   "#242424"

# Keyboard bindings
keys = [
    # Switch between windows
    Key([mod],          "h",        lazy.layout.left()),
    Key([mod],          "j",        lazy.layout.down()),
    Key([mod],          "k",        lazy.layout.up()),
    Key([mod],          "l",        lazy.layout.right()),

    # Move windows in current stack
    Key([mod, sft],     "h",        lazy.layout.shuffle_left()),
    Key([mod, sft],     "j",        lazy.layout.shuffle_down()),
    Key([mod, sft],     "k",        lazy.layout.shuffle_up()),
    Key([mod, sft],     "l",        lazy.layout.shuffle_right()),

    # Switch between monitors
    Key([mod],          "comma",    lazy.prev_screen()),
    Key([mod],          "period",   lazy.next_screen()),

    # Windows and layout behaviour
    Key([mod, sft],     "r",        lazy.restart()),
    Key([mod, sft],     "q",        lazy.window.kill()),
    Key([mod, sft],     "n",        lazy.layout.normalize()),
    Key([mod, sft],     "f",        lazy.window.toggle_floating()),
    Key([mod],          "plus",     lazy.layout.grow(), lazy.layout.increase_nmaster()),
    Key([mod],          "minus",    lazy.layout.shrink(), lazy.layout.decrease_nmaster()),

    # Toggle between different layouts
    Key([mod],          "Tab",      lazy.next_layout()),
    Key([mod, sft],     "Tab",      lazy.prev_layout()),

    # Terminal and rofi
    Key([mod],          "Return",   lazy.spawn(term)),
    Key([mod],          "space",    lazy.spawn("rofi -modi drun,run -show drun")),
    Key([mod, sft],     "e",        lazy.spawn("rofi -modi menu:rofi-power-menu -show menu")),
    Key([mod, sft],     "x",        lazy.spawn("rofi -modi menu:rofi-xrandr-menu -show menu")),
    Key([mod, sft],     "d",        lazy.spawn("rofi -modi menu:rofi-dotfiles-menu -show menu")),

    # App spawning
    Key([mod],          "f",        lazy.spawn("firefox")),
    Key([mod],          "c",        lazy.spawn("chromium")),
    Key([mod],          "g",        lazy.spawn("galculator")),
    Key([mod],          "t",        lazy.spawn("thunderbird")),
    Key([mod],          "s",        lazy.spawn("flameshot gui")),
    Key([mod],          "e",        lazy.spawn(term + " -t Ranger -e ranger")),

    # Volume and brightness controls
    Key([mod],          "Up",       lazy.spawn("amixer set Master 5%+")),                       # +5% volume
    Key([mod],          "Down",     lazy.spawn("amixer set Master 5%-")),                       # -5% volume
    Key([mod],          "m",        lazy.spawn("amixer set Master toggle")),                    # mute
    Key([mod],          "p",        lazy.spawn("deadbeef --play-pause")),                       # deadbeef toggle play/pause
    Key([mod],          "Right",    lazy.spawn("brightlight -i 239")),                          # +5% backlight
    Key([mod],          "Left",     lazy.spawn("brightlight -d 239")),                          # -5% backlight
    Key([mod],          "r",        lazy.spawn("brightlight -w 2390")),                         # resets to 50%
    # Key([mod],          "Right",    lazy.spawn("xbacklight -inc 5")),                           # +5% backlight
    # Key([mod],          "Left",     lazy.spawn("xbacklight -dec 5")),                           # -5% backlight
    # Key([mod],          "r",        lazy.spawn("xbacklight -set 50")),                          # resets to 50%

    # Moving cursor with keyboard
    Key([mod, ctrl],    "h",        lazy.spawn("xdotool mousemove_relative -- -46 0")),
    Key([mod, ctrl],    "j",        lazy.spawn("xdotool mousemove_relative -- 0 46")),
    Key([mod, ctrl],    "k",        lazy.spawn("xdotool mousemove_relative -- 0 -46")),
    Key([mod, ctrl],    "l",        lazy.spawn("xdotool mousemove_relative -- 46 0")),
    Key([mod, alt],     "h",        lazy.spawn("xdotool mousemove_relative -- -4 0")),
    Key([mod, alt],     "j",        lazy.spawn("xdotool mousemove_relative -- 0 4")),
    Key([mod, alt],     "k",        lazy.spawn("xdotool mousemove_relative -- 0 -4")),
    Key([mod, alt],     "l",        lazy.spawn("xdotool mousemove_relative -- 4 0")),
    Key([mod, alt],     "b",        lazy.spawn("xdotool click 1")),
    Key([mod, alt],     "n",        lazy.spawn("xdotool click 3")),

    # Special keys
    Key([], "XF86MonBrightnessUp",      lazy.spawn("brightlight -i 239")),                          # +5% backlight
    Key([], "XF86MonBrightnessDown",    lazy.spawn("brightlight -d 239")),                          # -5% backlight
    Key([], "XF86AudioRaiseVolume",     lazy.spawn("amixer set Master 5%+")),                       # +5% volume
    Key([], "XF86AudioLowerVolume",     lazy.spawn("amixer set Master 5%-")),                       # -5% volume
    Key([], "XF86AudioMute",            lazy.spawn("amixer set Master toggle")),                    # mute
]

# Mouse bindings
mouse = [
    Drag([mod],         "Button1",  lazy.window.set_position_floating(), start = lazy.window.get_position()),
    Drag([mod],         "Button3",  lazy.window.set_size_floating(), start = lazy.window.get_size())
]

# Groups' names and icons
groups = []
group_names = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]

group_labels = [
    "\uf120", #1 - Terminal
    "\uf0ac", #2 - Internet
    "\uf0e0", #3 - Email
    "\uf07c", #4 - File manager
    "\uf086", #5 - Chat
    "\uf001", #6 - Music
    "\uf03e", #7 - Picture
    "\uf19c", #8 - University
    "\uf1b2", #9 - Cube
    "\uf005"  #0 - Star
]

for i in range(len(group_names)):
    groups.append(
        Group(
            name = group_names[i],
            label = group_labels[i],
        )
    )

for i in groups:
    keys.extend([
        Key([mod],          i.name, lazy.group[i.name].toscreen()),
        Key([mod, sft],     i.name, lazy.window.togroup(i.name, switch_group = True)),
        Key([mod, ctrl],    i.name, lazy.window.togroup(i.name, switch_group = False)),
    ])

# Assign applications to a specific groupname
@hook.subscribe.client_new
def assign_app_group(client):
    d = {}
    d["1"] = []
    d["2"] = ["firefox", "Firefox"]
    d["3"] = ["Mail", "Thunderbird"]
    d["4"] = ["ranger", "Ranger"]
    d["5"] = ["telegram-desktop", "TelegramDesktop", "discord"]
    d["6"] = ["lmms.real"]
    d["7"] = []
    d["8"] = []

    wm_class = client.window.get_wm_class()[0]
    for i in range(len(d)):
        if wm_class in list(d.values())[i]:
            group = list(d.keys())[i]
            client.togroup(group)
            client.group.cmd_toscreen()

# Default layout theme
layout_theme = {
    "margin": 8,
    "single_margin": 0,
    "single_border_width": 0,
    "border_normal": accent3,
    "border_focus": accent1,
    "border_width": 1,
}

layouts = [
    # layout.Floating(),
    # layout.Stack(),
    # layout.Bsp(),
    # layout.Columns(),
    # layout.Matrix(),    
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.Slice(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
    # layout.TreeTab(),

    layout.MonadTall(**layout_theme),
    layout.MonadWide(**layout_theme),
    layout.Max(),
]

floating_layout = layout.Floating(
    border_focus = accent1,
    border_normal = accent3,
    border_width = 1,

    float_rules = [
        # Default
        {"wmclass": "confirm"},
        {"wmclass": "dialog"},
        {"wmclass": "download"},
        {"wmclass": "error"},
        {"wmclass": "file_progress"},
        {"wmclass": "notification"},
        {"wmclass": "splash"},
        {"wmclass": "toolbar"},
        {"wmclass": "confirmreset"},
        {"wmclass": "makebranch"},
        {"wmclass": "maketag"},
        {"wmclass": "ssh-askpass"},

        # Custom
        {"wmclass": "cpu-x"},                   # cpu-x windows
        {"wmclass": "gcr-prompter"},            # password input prompts
        {"wmclass": "blueman-manager"},         # blueman windows
        {"wmclass": "pavucontrol"},             # pavucontrol windows
        {"wmclass": "galculator"},              # galculator windows
        {"wmclass": "Msgcompose"},              # Thunderbird message window
        {"wmclass": "Calendar"},                # Thunderbird calendar window
        {"wmclass": "gsimplecal"},              # My minimal calendar of choice
        {"wmclass": "gcolor2"},                 # gcolor2 windows
        {"wmclass": "lxpolkit"},                # lxpolkit
        {"wmclass": "timeshift-gtk"},           # timeshift
        {"wmclass": "dragon"},                  # dragon
    ]
)

widget_defaults = dict(
    font = "Cantarell",
    fontsize = 14,
    padding = 3,
)

extension_defaults = widget_defaults.copy()

# Calendar spawner
def calendar(qtile):
    qtile.cmd_spawn("gsimplecal")

# Autostart script
@hook.subscribe.startup
def autostart():
    subprocess.call([home + "/.config/qtile/autostart.sh"])

# Monitor detection
@hook.subscribe.startup_once
def autostart_once():
    subprocess.call([home + "/.config/qtile/monitordetection.sh"])

# Separator defaults
separator = {
    "text": "",
    "font": FA4,
    "fontsize": 43,
    "padding": 0,
    "margin": 0
}

# Groupbox defaults
groupbox = {
    "this_current_screen_border": accent1,
    "this_screen_border": accent1,
    "highlight_color": accent2,
    "highlight_method": "line",
    "font": FA4,
    "fontsize": 16,
    "rounded": False,
}

# Screen settings
screens = [
    Screen(
        top = bar.Bar(
            [
                widget.GroupBox(
                    **groupbox,
                ),

                widget.WindowName(
                    font = "Cantarell Bold",
                    show_state = False,
                ),

                widget.TextBox(
                    **separator,
                    background = black,
                    foreground = accent3,
                ),

                widget.TextBox(
                    text = "\uf2c8",
                    font = FA4,
                    fontsize = 16,
                    background = accent3,
                    foreground = white,
                ),

                widget.ThermalSensor(
                    update_interval = 1,
                    foreground_alert = red,
                    threshold = 90,
                    padding = 5,
                    background = accent3,
                    foreground = white,
                ),

                widget.TextBox(
                    **separator,
                    background = accent3,
                    foreground = accent2,
                ),

                widget.TextBox(
                    text = "\uf0eb",
                    font = FA4,
                    fontsize = 16,
                    background = accent2,
                    foreground = white,
                ),

                widget.Backlight(
                    backlight_name = "intel_backlight",
                    brightness_file = "brightness",
                    background = accent2,
                    foreground = white,
                    change_command = "xbacklight -inc {0}",
                    step = 5,
                ),

                widget.TextBox(
                    **separator,
                    background = accent2,
                    foreground = accent1,
                ),

                widget.TextBox(
                    text = "\uf028",
                    font = FA4,
                    fontsize = 16,
                    background = accent1,
                    foreground = black,
                ),

                widget.Volume(
                    step = 5,
                    background = accent1,
                    foreground = black,
                ),

                widget.TextBox(
                    **separator,
                    background = accent1,
                    foreground = accent2,
                ),

                widget.Battery(
                    format = '{char}',
                    font = FA4,
                    fontsize = 16,
                    background = accent2,
                    foreground = white,
                    empty_char = "\uf244",
                    full_char = "\uf240",
                    charge_char = "\uf0e7",
                    discharge_char = "\uf242",
                    unknown_char = "\uf240",
                    low_foreground = red,
                    show_short_text = False,
                    update_interval = 30,
                ),

                widget.Battery(
                    format = '{percent:1.0%}',
                    background = accent2,
                    foreground = white,
                    low_foreground = red,
                    show_short_text = False,
                    notify_below = 10,
                    update_interval = 30,
                ),

                widget.TextBox(
                    **separator,
                    background = accent2,
                    foreground = accent3,
                ),

                widget.Clock(
                    background = accent3,
                    format = "%A %d %B, %H:%M",
                    mouse_callbacks = {"Button1": calendar},
                ),

                widget.TextBox(
                    **separator,
                    background = accent3,
                    foreground = black,
                ),

                widget.Systray(),

                widget.CurrentLayoutIcon(
                    scale = 0.75,
                ),
            ],

            size = 22,
            background = black,
        )
    ),

    Screen(
        top = bar.Bar(
            [
                widget.GroupBox(
                    **groupbox,
                ),

                widget.WindowName(
                    font = "Cantarell Bold",
                    show_state = False,
                ),

                widget.TextBox(
                    text = "\uf2db",
                    font = FA4,
                    fontsize = 16,
                ),

                widget.CPUGraph(
                    line_width = 2,
                    graph_color = accent1,
                    border_color = black,
                ),

                widget.TextBox(
                    text = "\uf176\uf175",
                    font = FA4,
                    fontsize = 16,
                ),

                widget.NetGraph(
                    line_width = 2,
                    graph_color = red,
                    border_color = black,
                ),

                widget.Clock(
                    format = "%A %d %B, %H:%M",
                    mouse_callbacks = {"Button1": calendar},
                ),

                widget.CurrentLayoutIcon(
                    scale = 0.75,
                ),
            ],

            size = 24,
            background = black,
        )
    )
]

# Other settings
dgroups_key_binder = None
dgroups_app_rules = []
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = "auto"

# neofetch fixes
wmname = "Qtile"
dename = ""
